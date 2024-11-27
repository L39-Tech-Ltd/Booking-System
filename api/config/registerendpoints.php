<?php

function registerEndpoints($dir){
    $endpoints = [];
    $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($dir));

    foreach($iterator as $file){
        if ($file->isDir()) {
            continue;
        }
        
        if($file->getExtension() === "php"){
            $className = getClassName($file->getPathname());
            if($className){
                $classNameParts = explode('\\', $className);
                $classNameEnd = end($classNameParts);
                $shortClassName = lcfirst($classNameEnd);
                $endpoints[$shortClassName] = $className;

                //echo "Registered endpoint: $shortClassName -> $className\n";
            }
        }
    }

    return $endpoints;
}

function getClassName($filePath){
    
    $contents = file_get_contents($filePath);
    preg_match('/namespace\s+(.+?);/', $contents, $namespaceMatch);
    preg_match('/class\s+(\w+)/', $contents, $classMatch);

    if (isset($namespaceMatch[1]) && isset($classMatch[1])) {
        return $namespaceMatch[1] . '\\' . $classMatch[1];
    }
    return null;
}