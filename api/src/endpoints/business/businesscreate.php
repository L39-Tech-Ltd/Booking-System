<?php

namespace src\Endpoints\Business;

use src\Endpoints\Endpoint;
use src\ErrorHandling\ClientErrorException;
use src\Database\Database;

class BusinessCreate extends Endpoint{

    public function __construct(){

        $db = new Database("db/db.db");

        $this->validateRequestMethod("POST");

        $this->validateParams(['name','email','phone','location'], "POST");
        
        $this->checkBusinessExists($db);

        $this->initialiseSQL();
        $queryResults = $db->executeSQL($this->getSQL(), $this->getSQLParams());

        $this->setData(array(
            "length" => count($queryResults),
            "message" => "Success",
            "data" => $queryResults
        ));
    }

    private function checkBusinessExists($db){
        //Add logic for checking business, Name + Location? Email?
    }

    protected function initialiseSQL(){
        $sql = "INSERT INTO business (name, email, phone, location)
        VALUES (:name, :email, :phone, :surname)";
        $this->setSQL($sql);
        $this->setSQLParams([
            'name'=>$_POST['name'],
            'email'=>$_POST['email'],
            'phone'=>$_POST['phone'],
            'surname'=>$_POST['surname'],
        ]);
    }
}