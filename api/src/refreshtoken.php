<?php

use FirebaseJWT\JWT;

class RefreshToken extends Endpoint{

    public function __construct(){

        $this->validateRequestMethod("POST");
        $this->validateRefreshToken();

        $refreshToken = $_POST['refresh_token'];

        $decoded = $this->validateRefreshTokenJWT($refreshToken);

        $data['token'] = $this->createJWT($decoded->sub);
        $data['refresh_token'] = $refreshToken;

        $this->setData( array(
            "length" => 0, 
            "message" => "Success",
            "data" => $data
        ));
    }

    private function validateRefreshToken(){
        if(!isset($_POST['refresh_token'])){
            throw new ClientErrorException("Refresh Token required", 401);
        }
    }

    private function validateRefreshTokenJWT($refreshToken){
        $secretKey = SECRET; 
        try{
            $decoded = JWT::decode($refreshToken, $secretKey, ['HS256']);
            if ($decoded->type !== 'refresh'){
                throw new ClientErrorException("Invalid token type", 401);
            }
            return $decoded;
        } catch (Exception $e){
            throw new ClientErrorException("Invalid refresh token", 401);
        }
    }
    
    protected function createJWT($queryResult){
        $secretKey = SECRET;

        $time = time();
        
        $tokenPayload = [
            'iat' => $time,
            'exp' => strtotime('+1 day', $time),
            'iss' => $_SERVER['HTTP_HOST'],
            'sub' => $queryResult[0]['user_id'],
            'name' => $queryResult[0]['email'],
            'admin' => $queryResult[0]['admin']
        ];
        $jwt = JWT::encode($tokenPayload, $secretKey, 'HS256');
    
        return $jwt;
    }

}