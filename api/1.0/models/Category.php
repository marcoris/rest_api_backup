<?php
class Category {
    // DB stuff
    private $conn;
    private $table = 'categories';

    // Category properties
    public $id;
    public $name;
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
                id,
                name,
                created_at
            FROM " .
                $this->table . "
            ORDER BY
                created_at DESC"
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
            id,
            name,
            created_at
        FROM " .
            $this->table . "
            WHERE
                id = :id"
        );

        // Execute query
        $stmt->execute(array(
            ':id' => $this->id
        ));

        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        $num = $stmt->rowCount();

        // Set properties
        $this->id = $row['id'];
        $this->name = $row['name'];
        $this->created_at = $row['created_at'];
        $this->num = $num;
    }

    // Create post
    public function create()
    {
        $stmt = $this->conn->prepare(
            "INSERT INTO " . $this->table . " SET name = :name");

        if ($stmt->execute(array(
            ':name' => htmlspecialchars(strip_tags($this->name)),
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
            "UPDATE " . $this->table . " SET name = :name WHERE id = :id");

        if ($stmt->execute(array(
            ':name' => htmlspecialchars(strip_tags($this->name)),
            ':id' => htmlspecialchars(strip_tags($this->id))
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
            ":id" => $this->id
        ))) {
            return true;
        }

        // Print error
        printf("Error: %s.\n", $stmt->error);

        return false;
    }
}