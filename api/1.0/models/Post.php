<?php

class Post {
    /**
     * @var string
     */
    private $table;

    /**
     * @var object
     */
    private $conn;

    /**
     * @var integer
     */
    public $post_id;

    /**
     * @var string
     */
    public $title;

    /**
     * @var string
     */
    public $body;

    /**
     * @var string
     */
    public $author;

    /**
     * @var integer
     */
    public $category_id;

    /**
     * Post constructor
     * @param object $database
     */
    public function __construct(object $database)
    {
        $this->conn = $database;
        $this->table = "posts";
    }

    /**
     * Get Posts
     *
     * @return object
     */
    public function read(): object
    {
        // Prepare statement
        $stmt = $this->conn->prepare(
            "SELECT
                c.name as category_name,
                p.id,
                p.category_id,
                p.title,
                p.body,
                p.author,
                p.created_at
            FROM " .
                $this->table . " p
                LEFT JOIN categories c ON p.category_id = c.id
            ORDER BY
                p.created_at DESC"
        );

        // Execute query
        $stmt->execute();

        return $stmt;
    }

    /**
     * Get single post
     *
     * @return object|null
     */
    public function readSingle(): ?object
    {
        try {
            // Prepare statement
            $stmt = $this->conn->prepare(
                "SELECT
                    c.name as category_name,
                    p.id,
                    p.category_id,
                    p.title,
                    p.body,
                    p.author,
                    p.created_at
                FROM " .
                    $this->table . " p
                    LEFT JOIN categories c ON p.category_id = c.id
                WHERE
                    p.id = :id"
            );

            // Execute query
            $stmt->execute(array(
                ':id' => $this->post_id
            ));

            return $stmt;
        } catch (PDOException $e) {
            echo json_encode(
                array('internal_error' => $e->getMessage())
            );
        }

        return null;
    }

    /**
     * Create post
     *
     * @return bool
     */
    public function create(): bool
    {
        try {
            $stmt = $this->conn->prepare(
                "INSERT INTO " . $this->table . "
                SET
                    title = :title,
                    body = :body,
                    author = :author,
                    category_id = :category_id"
            );

            if ($stmt->execute(array(
                ':title' => htmlspecialchars(strip_tags($this->title)),
                ':body' => htmlspecialchars(strip_tags($this->body)),
                ':author' => htmlspecialchars(strip_tags($this->author)),
                ':category_id' => htmlspecialchars(strip_tags($this->category_id))
            ))) {
                $this->post_id = $this->conn->lastInsertId();
                return true;
            }
        } catch (PDOException $e) {
            echo json_encode(
            array('internal_error' => $e->getMessage())
            );
        }

        return false;
    }

    /**
     * Get id
     *
     * @return int
     */
    public function getId(): int
    {
        return $this->post_id;
    }

    /**
     * Update post
     *
     * @return bool
     */
    public function update(): bool
    {
        try {
            $stmt = $this->conn->prepare(
                "UPDATE " . $this->table . "
                SET
                    title = :title,
                    body = :body,
                    author = :author,
                    category_id = :category_id
                WHERE
                    id = :id"
            );

            if ($stmt->execute(array(
                ':title' => htmlspecialchars(strip_tags($this->title)),
                ':body' => htmlspecialchars(strip_tags($this->body)),
                ':author' => htmlspecialchars(strip_tags($this->author)),
                ':category_id' => htmlspecialchars(strip_tags($this->category_id)),
                ':id' => htmlspecialchars(strip_tags($this->post_id))
            ))) {
                return true;
            }
        } catch (PDOException $e) {
            echo json_encode(
            array('internal_error' => $e->getMessage())
            );
        }

        return false;
    }

    /**
     * Delete post
     *
     * @return bool
     */
    public function delete(): bool
    {
        try {
            $stmt = $this->conn->prepare("DELETE FROM " . $this->table . " WHERE id = :id");

            if ($stmt->execute(array(
                ":id" => $this->post_id
            ))) {
                return true;
            }
        } catch (PDOException $e) {
            echo json_encode(
                array('internal_error' => $e->getMessage())
            );
        }

        return false;
    }
}
