<?php

namespace src\ErrorHandling\Client400;

use src\ErrorHandling\ClientErrorException;

class ValidationErrorException extends ClientErrorException{
    public function __construct($message = "Validation Error"){
        parent::__construct(422, $message);
    }
}