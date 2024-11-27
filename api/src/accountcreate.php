<?php

class AccountCreate extends Endpoint{

    public function __construct(){
        
        $db = new Database("db/db.db");

        $this->validateRequestMethod("POST");

        $this->validateUserParameters();

        $this->checkUserExists($db);

        $this->initialiseSQL();
        $queryResults = $db->executeSQL($this->getSQL(), $this->getSQLParams());

        $this->setData(array(
            "length" => count($queryResults),
            "message" => "Success",
            "data" => $queryResults
        ));
    }

    private function validateUserParameters(){
        if (!isset($_POST['email']) 
        || !isset($_POST['password']) 
        || !isset($_POST['forename']) 
        || !isset($_POST['surname'])){
            throw new ClientErrorException("Missing Data", 400);
        }
        if (empty($_POST['email']) 
        || empty($_POST['password']) 
        || empty($_POST['forename']) 
        || empty($_POST['surname'])){
            throw new ClientErrorException("Data Empty", 400);
        }
    }

    private function checkUserExists($db){
        $sql = "SELECT * FROM users WHERE email = :email";
        $this->setSQL($sql);
        $this->setSQLParams(['email'=>$_POST['email']]);
        $queryResults = $db->executeSQL($this->getSQL(), $this->getSQLParams());
        if(count($queryResults) > 0){
            throw new ClientErrorException("User Already Exists", 401);
        }
    }

    private function hashPassword(){
        return(password_hash($_POST['password'], PASSWORD_DEFAULT));
    }

    protected function initialiseSQL(){
        $sql = "INSERT INTO users (email, password, forename, surname)
        VALUES (:email, :password, :forename, :surname)";
        $this->setSQL($sql);
        $this->setSQLParams([
            'email'=>$_POST['email'],
            'password'=>$this->hashPassword(),
            'forename'=>$_POST['forename'],
            'surname'=>$_POST['surname'],
        ]);
    }
}