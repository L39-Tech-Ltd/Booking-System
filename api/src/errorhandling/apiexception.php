<?php

namespace src\ErrorHandling;


abstract class ApiException extends \Exception{
    protected $status_code;
    protected $message;

    public function __construct($status_code, $message = "An Error Occurred"){
        parent::__construct($message);
        $this->status_code = $status_code;
        $this->message = $message;
    }

    public function getStatusCode() {
        return $this->status_code;
    }
    
}

