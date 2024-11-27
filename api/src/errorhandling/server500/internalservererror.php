<?php

namespace src\ErrorHandling\Server500;

use src\ErrorHandling\ServerErrorException;

class InternalServerError extends ServerErrorException{
    public function __construct($message = "Internal Server Error"){
        parent::__construct(500, $message);
    }
}