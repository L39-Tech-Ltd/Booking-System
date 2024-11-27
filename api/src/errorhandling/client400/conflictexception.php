<?php

namespace src\ErrorHandling\Client400;

use src\ErrorHandling\ClientErrorException;

class ConflictException extends ClientErrorException{
    public function __construct($message = "A Conflict occurred"){
        parent::__construct(409, $message);
    }
}