<?php

class Posts implements IRestApi
{
    /**
     * @var int|null
     */
    private ?int $lastCreatedId = null;

    /**
     * @return int|null
     */
    public function getId(): ?int
    {
        return $this->lastCreatedId;
    }

    /**
     * @param int $lastCreatedId
     * @return void
     */
    private function setLastCreatedId(int $lastCreatedId): void
    {
        $this->lastCreatedId = $lastCreatedId;
    }

    /**
     * @param int|null $id
     * @return string
     */
    public function read(int $id = null): string
    {
        try {
            $db = new Database;
            $conn = $db->connect();
            $where = "";
            $array = [];

            if ($id) {
                $where = "WHERE p.id = :id";
                $array[':id'] = $id;
            }

            $stmt = $conn->prepare(
                "SELECT
                    c.name as category_name,
                    p.id,
                    p.category_id,
                    p.title,
                    p.body,
                    p.author,
                    p.created_at
                FROM posts p
                    LEFT JOIN categories c ON p.category_id = c.id
                $where
                ORDER BY
                    p.created_at DESC"
            );

            if ($id) {
                $stmt->execute($array);
            } else {
                $stmt->execute();
            }

            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                $arr[] = $row;
            }

            if (!$arr) {
                http_response_code(404);
                $arr = "Not found";
            } else {
                http_response_code(200);
            }

            return json_encode(
                array('content' => $arr)
                , JSON_PRETTY_PRINT);
        } catch (PDOException $e) {
            return json_encode(
                array('internal_error' => $e->getMessage())
                , JSON_PRETTY_PRINT);
        }
    }

    /**
     * @param string $data
     * @return bool
     */
    public function create(string $data): bool
    {
        $json = json_decode($data);

        try {
            $db = new Database;
            $conn = $db->connect();

            $stmt = $conn->prepare(
                "INSERT INTO posts
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
                $this->setLastCreatedId($conn->lastInsertId());
            }
        } catch (PDOException $e) {
            echo json_encode(
                array('internal_error' => $e->getMessage())
            );
        }

        return $this->getId() !== null;
    }

    /**
     * @param string $data
     * @param int $id
     * @return bool
     */
    public function update(string $data, int $id): bool
    {
        $json = json_decode($data);

        try {
            $db = new Database;
            $conn = $db->connect();

            $stmt = $conn->prepare(
                "UPDATE posts
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
     * @param int $id
     * @return bool
     */
    public function delete(int $id): bool
    {
        try {
            $db = new Database;
            $conn = $db->connect();

            $stmt = $conn->prepare("DELETE FROM posts WHERE id = :id");

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
