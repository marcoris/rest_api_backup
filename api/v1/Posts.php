<?php

class Posts
{
    /**
     * @var string
     */
    private $table = 'posts';

    /**
     * @var null
     */
    private $lastCreatedId = null;

    public function getId()
    {
        return $this->lastCreatedId;
    }

    /**
     * @return false|string
     */
    public function read(): string
    {
        try {
            $db = new Database;
            $conn = $db->connect();

            // Prepare statement
            $stmt = $conn->prepare(
                "SELECT
                    c.name as category_name,
                    p.id,
                    p.category_id,
                    p.title,
                    p.body,
                    p.author,
                    p.created_at
                FROM $this->table p
                    LEFT JOIN categories c ON p.category_id = c.id
                ORDER BY
                    p.created_at DESC"
            );

            // Execute query
            $stmt->execute();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $emparray[] = $row;
            }

            return json_encode(
                array('ok' => $emparray)
                , JSON_PRETTY_PRINT);
        } catch (PDOException $e) {
            return json_encode(
                array('internal_error' => $e->getMessage())
                , JSON_PRETTY_PRINT);
        }
    }

    /**
     * @param int $id
     * @return string
     */
    public function readSingle(int $id): string
    {
        try {
            $db = new Database;
            $conn = $db->connect();

            // Prepare statement
            $stmt = $conn->prepare(
                "SELECT
                    c.name as category_name,
                    p.id,
                    p.category_id,
                    p.title,
                    p.body,
                    p.author,
                    p.created_at
                FROM $this->table p
                    LEFT JOIN categories c ON p.category_id = c.id
                WHERE
                    p.id = :id"
            );

            // Execute query
            $stmt->execute(array(
                ':id' => $id
            ));

            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $emparray[] = $row;
            }

            return json_encode(
                array('ok' => $emparray)
                , JSON_PRETTY_PRINT);
        } catch (PDOException $e) {
            return json_encode(
                array('internal_error' => $e->getMessage())
            );
        }
    }

    /**
     * @param $data
     * @return bool
     */
    public function create($data): bool
    {
        $json = json_decode($data);

        try {
            $db = new Database;
            $conn = $db->connect();

            $stmt = $conn->prepare(
                "INSERT INTO " . $this->table . "
                SET
                    title = :title,
                    body = :body,
                    author = :author,
                    category_id = :category_id,
                    created_at = :created_at"
            );


            if ($stmt->execute(array(
                ':title' => htmlspecialchars(strip_tags($json->title)),
                ':body' => htmlspecialchars(strip_tags($json->body)),
                ':author' => htmlspecialchars(strip_tags($json->author)),
                ':category_id' => htmlspecialchars(strip_tags($json->category_id)),
                ':created_at' => date("Y-m-d H:i:s")
            ))) {
                $this->lastCreatedId = $conn->lastInsertId();
                return true;
            }
                return true;
        } catch (PDOException $e) {
            echo json_encode(
                array('internal_error' => $e->getMessage())
            );
        }

        return false;
    }

    /**
     * @return bool
     */
    public function update($data, $id): bool
    {
        $json = json_decode($data);

        try {
            $db = new Database;
            $conn = $db->connect();

            $stmt = $conn->prepare(
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
                ':title' => htmlspecialchars(strip_tags($json->title)),
                ':body' => htmlspecialchars(strip_tags($json->body)),
                ':author' => htmlspecialchars(strip_tags($json->author)),
                ':category_id' => htmlspecialchars(strip_tags($json->category_id)),
                ':id' => $id)
            )) {
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
     * @param $id
     * @return bool
     */
    public function delete($id): bool
    {
        try {
            $db = new Database;
            $conn = $db->connect();

            $stmt = $conn->prepare("DELETE FROM " . $this->table . " WHERE id = :id");

            if ($stmt->execute(array(
                ":id" => $id
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
