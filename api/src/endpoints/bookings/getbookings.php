<?php

namespace src\Endpoints\Bookings;

use src\Endpoints\Endpoint;
use src\Database\Database;

class GetBookings extends Endpoint{

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
        $sql = "SELECT 
            bookings.business_id,
            bookings.title,
            bookings.start_date,
            bookings.end_date,
            bookings.location,
            bookings.notes,
            bookings.status,
            users.forename,
            users.surname
        FROM bookings 
        JOIN employees ON bookings.employee_id = employees.employee_id
        JOIN users ON  employees.user_id = users.user_id
        WHERE bookings.user_id = :user_id";
        $this->setSQL($sql);
        $this->setSQLParams(['user_id'=>$this->userID]);
    }

}