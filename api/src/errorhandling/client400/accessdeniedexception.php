<?php

namespace src\ErrorHandling\Client400;

use src\ErrorHandling\ClientErrorException;

class AccessDeniedException extends ClientErrorException{
    public function __construct($message = "Access Denied"){
        parent::__construct(403, $message);
    }
}