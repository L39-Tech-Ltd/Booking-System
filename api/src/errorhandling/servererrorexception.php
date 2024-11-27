<?php

namespace src\ErrorHandling;

abstract class ServerErrorException extends ApiException{
    public function __construct($status_code, $message = "Server error occured"){
        parent::__construct($status_code, $message);
    }
}