<?php

use FirebaseJWT\JWT;

class UserData extends Endpoint{

    private $userID;

    public function __construct(){

        $db = new Database("db/db.db");

        $this->validateRequestMethod("POST");
        $this->validateJwtParameter();
        $jwtToken = $this->validateJwtToken();
        $this->$userID = $this->decodeJwtToken($jwtToken);

        $this->initialiseSQL();
        $queryResults = $db->executeSQL($this->getSQL(), $this->getSQLParams());

        $this->setData( array(
            "length" => count($queryResults), 
            "message" => "Success",
            "data" => $queryResults
        ));
    }

    private function validateJwtParameter(){
        $headers = getallheaders();
        if(!isset($headers['Authorization'])){
            throw new ClientErrorException("Missing JWT Token", 400);
        }
    }

    private function validateJwtToken(){
        $authHeader = getallheaders()['Authorization'];
        if(!preg_match('/Bearer\s(\S+)/', $authHeader, $matches)){
            throw new ClientErrorException("Malformed Authorization header", 400);
        }
        return $matches[1];
    }

    private function decodeJwtToken($jwtToken){
        $secretKey = SECRET; 
        try{
            $decoded = JWT::decode($jwtToken, $secretKey, ['HS256']);
            $user_Id = $decoded->sub;
            return $user_Id;
        } catch (Exception $e){
            throw new ClientErrorException("Invalid token", 401);
        }
    }

    protected function initialiseSQL(){
        $sql = "SELECT email, forename, surname FROM users WHERE user_id = :userID";
        $this->setSQL($sql);
        $this->setSQLParams(['userID'=>$this->$userID]);
    }
}