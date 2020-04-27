<?php
class Database {
    // DB params
    private $host = '@@dbhost';
    private $dbname = '@@dbname';
    private $username = '@@dbname';
    private $password = '@@dbpass';
    private $conn;

    // DB connect
    public function connect()
    {
        $this->conn = null;

        try {
            $this->conn = new PDO('mysql:host=' . $this->host . ';dbname=' . $this->dbname, $this->username, $this->password);
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            echo 'Connection error: ' . $e->getMessage();
        }

        return $this->conn;
    }
}
