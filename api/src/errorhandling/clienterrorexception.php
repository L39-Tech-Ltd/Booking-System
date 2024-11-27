<?php

namespace src\ErrorHandling;

abstract class ClientErrorException extends ApiException{
    public function __construct($status_code, $message = "Client error occured"){
        parent::__construct($status_code, $message);
    }
}