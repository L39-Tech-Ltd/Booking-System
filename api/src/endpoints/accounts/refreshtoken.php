<?php

namespace src\Endpoints\Accounts;

use src\Endpoints\Endpoint;
use FirebaseJWT\JWT;
use src\Database\Database;
use src\ErrorHandling\Client400\UnauthorizedException;

class RefreshToken extends Endpoint{

    private $userID;

    public function __construct(){

        $db = new Database("db/db.db");

        $this->validateRequestMethod("POST");
        $this->validateParams(['refresh_token'],"POST");

        $refreshToken = $_POST['refresh_token'];

        $decoded = $this->validateRefreshTokenJWT($refreshToken);
        $this->userID = $decoded->sub;


        $this->initialiseSQL();
        $queryResults = $db->executeSQL($this->getSQL(), $this->getSQLParams());

        $data['token'] = $this->createJWT($queryResults);
        $data['refresh_token'] = $refreshToken;

        $this->setData( array(
            "length" => 0, 
            "message" => "Success",
            "data" => $data
        ));
    }

    private function validateRefreshTokenJWT($refreshToken){
        $secretKey = SECRET; 
        try{
            $decoded = JWT::decode($refreshToken, $secretKey, ['HS256']);
            if ($decoded->type !== 'refresh'){
                throw new UnauthorizedException("Invalid token type"); //401
            }
            return $decoded;
        } catch (Exception $e){
            throw new UnauthorizedException("Invalid refresh token"); //401
        }
    }

    protected function initialiseSQL(){
        $sql = "SELECT user_id, email, forename, surname FROM users WHERE user_id = :userID";
        $this->setSQL($sql);
        $this->setSQLParams(['userID'=>$this->userID]);
    }
}