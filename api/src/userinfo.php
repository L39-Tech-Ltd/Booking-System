<?php

class UserInfo extends Endpoint{

    public function __construct(){

        $db = new Database("db/db.db");

        $this->validateRequestMethod("POST");
        $this->validateUserParameters();
        
        $this->initialiseSQL();
        $queryResults = $db->executeSQL($this->getSQL(), $this->getSQLParams());

        $this->setData( array(
            "length" => 0, 
            "message" => "Success",
            "data" => $queryResults
        ));
    }

    private function validateUserParameters(){
        if(!isset($_POST['userID'])){
            throw new ClientErrorException("Missing Data", 400);
        }
        if(empty($_POST['userID'])){
            throw new ClientErrorException("Data Empty", 400);
        }
    }

    protected function initialiseSQL(){
        $sql = "SELECT email, forename, surname FROM users WHERE user_id = :userID";
        $this->setSQL($sql);
        $this->setSQLParams(['userID'=>$_POST['userID']]);
    }
}