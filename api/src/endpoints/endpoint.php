<?php

namespace src\Endpoints;

use FirebaseJWT\JWT;
use FirebaseJWT\SignatureInvalidException;
use FirebaseJWT\ExpiredException;
use src\Database\Database;
use src\ErrorHandling\Client400\MethodErrorException;
use src\ErrorHandling\Client400\ClientError;
use src\ErrorHandling\Client400\UnauthorizedException;
use src\ErrorHandling\Server500\InternalServerError;

abstract class Endpoint{

    private $data;
    private $sql;
    private $params;

    public function __construct(){
        
        $db = new Database("db/db.db");
        $this->initialiseSQL();
        $this->validateParams($this->endpointParams());
        $data = $db->executeSQL($this->sql, $this->params);

        $this->setData( array(
            "length" => count($data),
            "message" => "Success",
            "data" => $data
        ));
    }

    protected function getSQL(){
        return $this->sql;
    }

    protected function setSQL($sql){
        $this->sql = $sql;
    }

    protected function getSQLParams(){
        return $this->params;
    }

    protected function setSQLParams($params){
        $this->params = $params;
    }

    public function getData(){
        return $this->data;
    }

    protected function setData($data){
        $this->data = $data;
    }

    protected function initialiseSQL(){
        $sql = "";
        $this->setSQL($sql);
        $this->setSQLParams([]);
    }

    protected function endpointParams(){
        return [];
    }

    protected function validateRequestMethod($method){
        if ($_SERVER['REQUEST_METHOD'] != $method){
            throw new MethodErrorException("Invalid Request Method"); //405
        }
    }

    protected function validateParams($params, $method = 'GET'){

        if(strtoupper($method) === "GET"){
            $inputData = $_GET;
        }elseif (strtoupper($method) === "POST"){
            $inputData = $_POST;
        }elseif (strtoupper($method) === "SERVER"){
            $inputData = $_SERVER;
        }else{
            throw new MethodErrorException("Invalid Request Method"); //405
        }

        $missingData = [];
        $emptyData = [];
        foreach($params as $param){
            if(!isset($inputData[$param])){
                $missingData[] = $param; //400
            }
            elseif(empty($inputData[$param])){
                $emptyData[] = $param;
            }
        }
        if(!empty($missingData)){
            throw new ClientError("Missing Data - Requires: ".  implode(', ', $missingData));//400
        }
        if(!empty($emptyData)){
            throw new ClientError("Data Empty - Requires: ".  implode(', ', $emptyData));//400
        }


        foreach($inputData as $key => $value){
            if(!in_array($key, $params) && (strtoupper($method) !== "SERVER") ){
                throw new ClientError("Invalid Parameter");//400
            }
        }
    }

    protected function validateJWT(){
        $headers = getallheaders();
        $authHeader = isset($headers['Authorization']) ? $headers['Authorization'] : null;

        if(!$authHeader || !preg_match('/Bearer\s(\S+)/', $authHeader, $matches)){
            throw new UnauthorizedException("Authorization Token Required");//401
        }

        $token = $matches[1];
        $secretKey = SECRET;

        try{
            $decoded = JWT::decode($token, $secretKey, ['HS256']);
            return $decoded;
        }catch(ExpiredException  $e){
            throw new UnauthorizedException("Token Expired");//401
        }catch(SignatureInvalidException $e){
            throw new UnauthorizedException("Invalid token signature");//401
        }catch(Exception $e){
            throw new UnauthorizedException("Invalid Token $e");//401
        }
    }

    protected function createJWT($queryResult){
        $secretKey = SECRET;

        $time = time();
        
        $tokenPayload = [
            'iat' => $time,
            'exp' => strtotime('+30 minutes', $time),
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