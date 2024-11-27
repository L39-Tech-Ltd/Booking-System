<?php

namespace src\Endpoints\Employee;

use src\Endpoints\Endpoint;
use src\Database\Database;

class BusinessEmployees extends Endpoint{

    public function __construct(){
        $db = new Database("db/db.db");

        $this->validateRequestMethod("GET");

        $this->validateParams(['business_id'],"GET");

        $this->initialiseSQL();
        $queryResults = $db->executeSQL($this->getSQL(), $this->getSQLParams());

        $this->setData( array(
            "length" => count($queryResults), 
            "message" => "Success",
            "data" => $queryResults
        ));
    }

    protected function initialiseSQL(){
        $sql = "SELECT 
            employees.employee_id,
            users.email, 
            users.forename, 
            users.surname,
            employees.role
        FROM employees 
        JOIN users ON employees.user_id = users.user_id
        WHERE employees.business_id = :business_id";
        $this->setSQL($sql);
        $this->setSQLParams(['business_id'=>$_GET['business_id']]);
    }

}