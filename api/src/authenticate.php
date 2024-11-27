<?php

//Import Firebase for creating JWT
use FirebaseJWT\JWT;

class Authenticate extends Endpoint{

    public function __construct() {

        $db = new Database("db/db.db");

        $this->validateRequestMethod("POST");

        $this->validateAuthParameters();

        $this->initialiseSQL();
        $queryResults = $db->executeSQL($this->getSQL(), $this->getSQLParams());

        $this->validateUsername($queryResults);
        $this->validatePassword($queryResults);

        $data['token'] = $this->createJWT($queryResults);
        $data['refresh_token'] = $this->createRefreshToken($queryResults[0]['user_id']);

        $this->setData( array(
            "length" => 0, 
            "message" => "Success",
            "data" => $data
        ));
    }

    private function validateAuthParameters() {
        if ( !isset($_SERVER['PHP_AUTH_USER']) || !isset($_SERVER['PHP_AUTH_PW']) ) {
            throw new ClientErrorException("Username and Password required", 401);
        }
    }

    protected function initialiseSQL() {
        $sql = "SELECT user_id, email, password FROM users WHERE email = :email";
        $this->setSQL($sql);
        $this->setSQLParams(['email'=>$_SERVER['PHP_AUTH_USER']]);
    }

    protected function validateUsername($data){
        if (count($data)<1){
            throw new ClientErrorException("invalid credentials", 401);
        }
    }

    protected function validatePassword($data){
        if(!password_verify($_SERVER['PHP_AUTH_PW'], $data[0]['password'])){
            throw new ClientErrorException(
                "invalid credentials" , 401);
        }
    }

    protected function createJWT($queryResult){
        $secretKey = SECRET;

        $time = time();
        
        $tokenPayload = [
            'iat' => $time,
            'exp' => strtotime('+15 minutes', $time),
            'iss' => $_SERVER['HTTP_HOST'],
            'sub' => $queryResult[0]['user_id'],
            'name' => $queryResult[0]['email'],
            'admin' => $queryResult[0]['admin']
        ];
        $jwt = JWT::encode($tokenPayload, $secretKey, 'HS256');
    
        return $jwt;
    }

    protected function createRefreshToken($userID){
        $secretKey = SECRET;

        $time = time();

        $refreshTokenPayload = [
            'iat' => $time,
            'exp' => strtotime('+1 days'),
            'sub' => $userID,
            'type' => 'refresh',
        ];
        $refreshToken = JWT::encode($refreshTokenPayload, $secretKey, 'HS256');

        return $refreshToken;
    }
}