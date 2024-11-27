<?php

    use src\ErrorHandling\Server500\InternalServerError;

    //Headers
    header("Content-type: application/json; charset=UTF-8");
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Headers: *");
    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {    
        exit(0);
    } 

    //Include Auto Loader
    include 'config/autoloader.php';
    spl_autoload_register("autoloader");

    //Include Exception Handler
    include 'config/exceptionhandler.php';
    set_exception_handler('exceptionHandler');

    
    include 'config/registerendpoints.php';

    //Define Secret key for JWT
    define('SECRET', getenv('SECRET'));

    //Seperate URL
    $url = $_SERVER["REQUEST_URI"];
    $path = parse_url($url)['path'];
    $path = trim($path, '/');

    try{
        $endpoints = registerEndpoints(__DIR__.'/src/endpoints');
    
        //print_r($endpoints);

        if(isset($endpoints[$path])){
            $className = $endpoints[$path];
            $endpoint = new $className();
            $response = $endpoint->getData();
            echo json_encode($response);
        }else {
            throw new InternalServerError("Endpoint not initialized, $path"); // Handle case where endpoint is not set
        }

    }catch (Exception $e){
        http_response_code((int) $e->getStatusCode());
        echo json_encode([
            "error" => true,
            "message" => $e->getMessage()
        ]);
    }

    // switch($path){
        //     case '/authenticate':
        //     case '/authenticate/':
        //         $endpoint = new Authenticate();
        //         break;

        //     case '/refreshToken':
        //     case '/refreshToken/':
        //         $endpoint = new RefreshToken();
        //         break;

        //     case '/accountCreate':
        //     case '/accountCreate/':
        //         $endpoint = new AccountCreate();
        //         break;

        //     case '/userData':
        //     case '/userData/':
        //         $endpoint = new UserData();
        //         break;

        //     case '/businessCreate':
        //     case '/businessCreate/':
        //         $endpoint = new BusinessCreate();
        //         break;

        //     case '/employeeCreate':
        //     case '/employeeCreate/':
        //         $endpoint = new EmployeeCreate();
        //         break;

        //     case '/searchBusiness':
        //     case '/searchBusiness/':
        //         $endpoint = new SearchBusiness();
        //         break;

        //     default:
        //     throw new Exception("No valid endpoint found", 404);
        // }
        // if ($endpoint) {
        //     $response = $endpoint->getData();
        //     echo json_encode($response);
        // } else {
        //     throw new Exception("Endpoint not initialized", 500); // Handle case where endpoint is not set
        // }