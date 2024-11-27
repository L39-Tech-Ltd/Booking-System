<?php

namespace src\ErrorHandling\Client400;

use src\ErrorHandling\ClientErrorException;

class MissingDataException extends ClientErrorException{
    public function __construct($message = "Missing Data"){
        parent::__construct(404, $message);
    }
}