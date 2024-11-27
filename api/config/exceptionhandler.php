<?php

/**
 * Exception Handler
 * 
 * @author J.Osborne
 */

function exceptionHandler($e){
    http_response_code($e->getCode() ?? 500);
    $output['message'] = $e->getMessage();
    $output['location']['file'] = $e->getFile();
    $output['location']['line'] = $e->getLine();
    echo json_encode($output);
}

