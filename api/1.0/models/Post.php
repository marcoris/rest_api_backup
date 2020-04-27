<?php
class Post {
    // DB stuff
    private $conn;
    private $table = 'posts';

    // Post properties
    public $post_id;
    public $title;
    public $body;
    public $author;
    public $category_id;
    public $category_name;
    public $created_at;
    public $num;

    // Constructor with DB
    public function __construct($database)
    {
        $this->conn = $database;
    }

    // Get Posts
    public function read()
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

    // Get single post
    public function readSingle()
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
            WHERE
                p.id = :id"
        );

        // Execute query
        $stmt->execute(array(
            ':id' => $this->post_id
        ));

        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        $num = $stmt->rowCount();

        // Set properties
        $this->title = $row['title'];
        $this->body = $row['body'];
        $this->author = $row['author'];
        $this->category_id = $row['category_id'];
        $this->category_name = $row['category_name'];
        $this->created_at = $row['created_at'];
        $this->num = $num;
    }

    // Create post
    public function create()
    {
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
            return true;
        }

        // Print error
        printf("Error: %s.\n", $stmt->error);

        return false;
    }

    // Update post
    public function update()
    {
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

        // Print error
        printf("Error: %s.\n", $stmt->error);

        return false;
    }

    // Delete post
    public function delete()
    {
        $stmt = $this->conn->prepare("DELETE FROM " . $this->table . " WHERE id = :id");
        
        if ($stmt->execute(array(
            ":id" => $this->post_id
        ))) {
            return true;
        }

        // Print error
        printf("Error: %s.\n", $stmt->error);

        return false;
    }
}