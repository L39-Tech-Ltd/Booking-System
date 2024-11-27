<?php

/**
 * Autoloader
 * Used to auto load classes
 * 
 * @author J.Osborne
 */

    function autoloader($className) {

        $baseDir = dirname(__DIR__) . "/src/";
        $className = strtolower(str_replace("src\\", "", $className.".php"));
        $filename = str_replace('\\', DIRECTORY_SEPARATOR, $baseDir.$className);

        if (is_readable($filename)) {
            include_once $filename;
        } else {
            exit("File not found: " . $className . " (" . $filename . ")");
        }
    }  