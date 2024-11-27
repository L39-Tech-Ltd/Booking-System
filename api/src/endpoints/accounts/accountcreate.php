<?php

namespace src\Endpoints\Accounts;

use src\Endpoints\Endpoint;
use src\Database\Database;
use src\ErrorHandling\Client400\ConflictException;

class AccountCreate extends Endpoint{

    public function __construct(){

        $db = new Database("db/db.db");

        $this->validateRequestMethod("POST");

        $this->validateParams(['email','password','forename','surname'],"POST");

        $this->checkUserExists($db);

        $this->initialiseSQL();
        $queryResults = $db->executeSQL($this->getSQL(), $this->getSQLParams());

        $this->setData(array(
            "length" => count($queryResults),
            "message" => "Success",
            "data" => $queryResults
        ));
    }

    private function checkUserExists($db){
        $sql = "SELECT * FROM users WHERE email = :email";
        $this->setSQL($sql);
        $this->setSQLParams(['email'=>$_POST['email']]);
        $queryResults = $db->executeSQL($this->getSQL(), $this->getSQLParams());
        if(count($queryResults) > 0){
            throw new ConflictException("User Already Exists");//409
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