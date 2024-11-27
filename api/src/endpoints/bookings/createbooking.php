<?php

namespace src\Endpoints\Bookings;

use src\Endpoints\Endpoint;
use src\Database\Database;

class CreateBooking extends Endpoint{

    public function __construct(){

        $db = new Database("db/db.db");

        $this->validateRequestMethod("POST");

        $jwtToken = $this->validateJWT();
        $this->userID = $jwtToken->sub;

        $this->validateParams(
            ['business_id', 'employee_id', 'title', 'start_date', 
            'end_date', 'location', 'notes', 'status'],"POST");

        
        $this->initialiseSQL();
        $queryResults = $db->executeSQL($this->getSQL(), $this->getSQLParams());

        $this->setData(array(
            "length" => count($queryResults),
            "message" => "Success",
            "data" => $queryResults
        ));
    }

    //Add any data checking

    protected function initialiseSQL(){
        $sql = "INSERT INTO bookings 
        (user_id, business_id, employee_id, title, start_date, end_date, location, notes, status)
        VALUES 
        (:user_id, :business_id, :employee_id, :title, :start_date, :end_date, :location, :notes, :status)";
        $this->setSQL($sql);
        $this->setSQLParams([
            'user_id' =>$this->userID, 
            'business_id'=>$_POST['business_id'],
            'employee_id'=>$_POST['employee_id'],
            'title'=>$_POST['title'],
            'start_date'=>$_POST['start_date'],
            'end_date'=>$_POST['end_date'],
            'location'=>$_POST['location'],
            'notes'=>$_POST['notes'],
            'status'=>$_POST['status'],
        ]);
    }


}


// 'user_id', 'business_id', 'employee_id', 'title', 'start_date', 'end_data', 'location', 'notes', 'status'