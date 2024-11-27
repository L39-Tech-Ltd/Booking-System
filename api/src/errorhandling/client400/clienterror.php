<?php

namespace src\ErrorHandling\Client400;

use src\ErrorHandling\ClientErrorException;

class ClientError extends ClientErrorException{
    public function __construct($message = "Missing Data"){
        parent::__construct(400, $message);
    }
}