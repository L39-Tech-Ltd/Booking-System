<?php

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
            throw new ClientErrorException("Invalid Request Method", 405);
        }
    }

    protected function validateParams($params){
        foreach($_GET as $key => $value){
            if(!in_array($key, $params)){
                http_response_code(400);
                $output['message'] = "Invalid Paramter: ". $key;
                exit(json_encode($output));
            }
        }
    }
}