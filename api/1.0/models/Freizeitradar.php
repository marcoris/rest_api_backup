<?php
class Freizeitradar {
    // DB stuff
    private $conn;
    private $table = 'freizeit_aktivitaeten';

    // freizeitradar properties
    public $freizeitradar_id;

    // Constructor with DB
    public function __construct($database)
    {
        $this->conn = $database;
    }

    // Get freizeitradars
    public function read()
    {       
        // Prepare statement
        $stmt = $this->conn->prepare(
            "SELECT
                *
            FROM " .
                $this->table . "
            ORDER BY
                id DESC"
        );

        // Execute query
        $stmt->execute();

        return $stmt;
    }

    // Get single freizeitradar
    public function readSingle()
    {
        // Prepare statement
        $stmt = $this->conn->prepare(
            "SELECT
                *
            FROM " .
                $this->table . " 
            WHERE
                id = :id"
        );

        // Execute query
        $stmt->execute(array(
            ':id' => $this->freizeitradar_id
        ));

        return $stmt;
    }

    // Create freizeitradar
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

    // Update freizeitradar
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
            ':id' => htmlspecialchars(strip_tags($this->freizeitradar_id))
        ))) {
            return true;
        }

        // Print error
        printf("Error: %s.\n", $stmt->error);

        return false;
    }

    // Delete freizeitradar
    public function delete()
    {
        $stmt = $this->conn->prepare("DELETE FROM " . $this->table . " WHERE id = :id");
        
        if ($stmt->execute(array(
            ":id" => $this->freizeitradar_id
        ))) {
            return true;
        }

        // Print error
        printf("Error: %s.\n", $stmt->error);

        return false;
    }
}