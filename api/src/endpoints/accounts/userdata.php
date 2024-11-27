<?php

namespace src\Endpoints\Accounts;

use src\Endpoints\Endpoint;
use src\Database\Database;

class UserData extends Endpoint{

    private $userID;

    public function __construct(){

        $db = new Database("db/db.db");

        $this->validateRequestMethod("GET");

        $jwtToken = $this->validateJWT();
        $this->userID = $jwtToken->sub;

        $this->initialiseSQL();
        $queryResults = $db->executeSQL($this->getSQL(), $this->getSQLParams());

        $this->setData( array(
            "length" => count($queryResults), 
            "message" => "Success",
            "data" => $queryResults
        ));
    }

    protected function initialiseSQL(){
        $sql = "SELECT email, forename, surname FROM users WHERE user_id = :userID";
        $this->setSQL($sql);
        $this->setSQLParams(['userID'=>$this->userID]);
    }
}