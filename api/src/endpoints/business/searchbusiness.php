<?php

namespace src\Endpoints\Business;

use src\Endpoints\Endpoint;
use src\ErrorHandling\ClientErrorException;
use src\Database\Database;

class SearchBusiness extends Endpoint{
    
    private $query;
    private $limit;
    private $offset;

    public function __construct(){

        $db = new Database("db/db.db");

        $jwtToken = $this->validateJWT();
        
        $this->validateRequestMethod("GET");
        
        $this->validateParams(['searchTerm'], "GET");
        $this->setParams();

        $this->initialiseSQL();
        $queryResults = $db->executeSQL($this->getSQL(), $this->getSQLParams());

        $this->setData( array(
            "length" => count($queryResults), 
            "message" => "Success",
            "data" => $queryResults
        ));
    }
    
    protected function setParams(){
        $this->query = isset($_GET['searchTerm']) ? trim($_GET['searchTerm']) : '';

        $this->limit = isset($_GET['pageSize']) ? (int) $_GET['pageSize'] : 20;
        $this->page = isset($_GET['page']) ? (int) $_GET['page'] : 1;

        $this->offset = ($this->page - 1) * $this->limit;
    }

    protected function initialiseSQL(){
        $sql = 
        "SELECT business_id, name, email, phone, location 
        FROM business 
        WHERE name LIKE '%' || :query || '%' 
        LIMIT " . intval($this->limit) . " OFFSET " . intval($this->offset);
        $this->setSQL($sql);
        $this->setSQLParams([
            'query'=>$this->query,
        ]);
    }


}