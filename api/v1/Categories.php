<?php

class Categories implements IRestApi
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
     * @param int|null $lastCreatedId
     */
    public function setLastCreatedId(?int $lastCreatedId): void
    {
        $this->lastCreatedId = $lastCreatedId;
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
                "INSERT INTO categories
                SET
                    name = :name,
                    created_at = :created_at"
            );

            if ($stmt->execute(array(
                ':name' => htmlspecialchars(strip_tags($json->name)),
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
                $where = "WHERE id = :id";
                $array[':id'] = $id;
            }

            $stmt = $conn->prepare(
                "SELECT
                    id,
                    name,
                    created_at
                FROM categories
                $where
                ORDER BY
                    created_at DESC"
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
                "UPDATE categories
                SET
                    name = :name
                WHERE
                    id = :id"
            );

            if ($stmt->execute(array(
                    ':name' => htmlspecialchars(strip_tags($json->name)),
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

            $stmt = $conn->prepare("DELETE FROM categories WHERE id = :id");

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
