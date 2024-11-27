<?php

namespace src\Database;

use src\ErrorHandling\Server500\InternalServerError;


class Database{

    private $dbConnection;

    public function __construct($dbName){
        try{
            $this->dbConnection = new \PDO('sqlite:'.$dbName);
            $this->dbConnection->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
        } catch(\PDOException  $e){
            throw new InternalServerError("Database connection failed: " . $e->getMessage());
        }
    }

    public function executeSQL($sql, $params=[]){
        try{
            $stmt = $this->dbConnection->prepare($sql);
            $stmt->execute($params);

            return $stmt->fetchAll(\PDO::FETCH_ASSOC);
        } catch(\PDOException $e){
            throw new InternalServerError ("SQL execution failed: " . $e->getMessage());
        }
    }

}