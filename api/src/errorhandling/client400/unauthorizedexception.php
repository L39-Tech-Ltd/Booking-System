<?php

namespace src\ErrorHandling\Client400;

use src\ErrorHandling\ClientErrorException;

class UnauthorizedException extends ClientErrorException{
    public function __construct($message = "Unauthorized access"){
        parent::__construct(401, $message);
    }
}