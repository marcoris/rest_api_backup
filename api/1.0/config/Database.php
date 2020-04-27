<?php
class Database {
    // DB params
    private $dbname = 'myblog';
    private $username = 'myblog';
    private $password = '';
    private $conn;

    // DB connect
    public function connect()
    {
        $this->conn = null;

        try {
            $this->conn = new PDO('mysql:host=localhost;dbname=' . $this->dbname, $this->username, $this->password);
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            echo 'Connection error: ' . $e->getMessage();
        }

        return $this->conn;
    }
}
