<?php
class Database {
    /**
     * @var string
     */
    private $host = 'localhost';

    /**
     * @var string
     */
    private $dbname = '';

    /**
     * @var string
     */
    private $username = 'myblog';

    /**
     * @var string
     */
    private $password = '';

    /**
     * @var null
     */
    private $conn = null;

    /**
     * DB connection
     * @param string $dbname
     * @return object
     */
    public function connect($dbname)
    {
        $this->dbname = $dbname;

        try {
            $this->conn = new PDO('mysql:host=' . $this->host . ';dbname=' . $this->dbname, $this->username, $this->password);
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            echo 'Connection error: ' . $e->getMessage();
        }

        return $this->conn;
    }
}
