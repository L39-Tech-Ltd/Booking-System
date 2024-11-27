<?php

namespace src\Endpoints\Employee;

use src\ErrorHandling\ClientErrorException;
use src\Database\Database;

class EmployeeCreate extends Endpoint{

    public function __construct(){
        
        $db = new Database("db/db.db");

        $this->validateRequestMethod("POST");

        $this->validateParams(['businessID', 'userID', 'role'],"POST");

        $this->checkEmployeeExists($db);

        $this->initialiseSQL();
        $queryResults = $db->executeSQL($this->getSQL(), $this->getSQLParams());

        $this->setData(array(
            "length" => count($queryResults),
            "message" => "Success",
            "data" => $queryResults
        ));
    }

    private function checkEmployeeExists($db){
        //Check employee doesnt exist, UserID + BusiessID?
    }

    //Check userID and BusinessID? 

    
    protected function initialiseSQL(){
        $sql = "INSERT INTO employees (business_id, user_id, role)
        VALUES (:businessID, :userID, :role)";
        $this->setSQL($sql);
        $this->setSQLParams([
            'businessID'=>$_POST['businessID'],
            'userID'=>$_POST['userID'],
            'role'=>$_POST['role'],
        ]);
    }
}