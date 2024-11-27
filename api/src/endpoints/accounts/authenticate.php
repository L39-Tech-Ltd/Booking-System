<?php

namespace src\Endpoints\Accounts;

use src\Endpoints\Endpoint;
use src\Database\Database;
use src\ErrorHandling\Client400\ClientError;
use src\ErrorHandling\Client400\UnauthorizedException;

class Authenticate extends Endpoint{

    public function __construct() {

        $db = new Database("db/db.db");

        $this->validateRequestMethod("POST");

        $this->validateParams([]);

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

    protected function validateParams($params, $method = 'GET') {
        if ( !isset($_SERVER['PHP_AUTH_USER']) || !isset($_SERVER['PHP_AUTH_PW']) ) {
            throw new ClientError("Username and Password required");//400
        }
        if ( empty($_SERVER['PHP_AUTH_USER']) || empty($_SERVER['PHP_AUTH_PW']) ) {
            throw new ClientError("Username and Password required");//400
        }
    }

    protected function initialiseSQL() {
        $sql = "SELECT user_id, email, password FROM users WHERE email = :email";
        $this->setSQL($sql);
        $this->setSQLParams(['email'=>$_SERVER['PHP_AUTH_USER']]);
    }

    protected function validateUsername($data){
        if (count($data)<1){
            throw new UnauthorizedException("invalid credentials"); //401
        }
    }

    protected function validatePassword($data){
        if(!password_verify($_SERVER['PHP_AUTH_PW'], $data[0]['password'])){
            throw new UnauthorizedException("invalid credentials"); //401
        }
    }

}