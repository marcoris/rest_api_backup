<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, DELETE, PUT');
header("Content-type:application/json");

$method = $_SERVER['REQUEST_METHOD'];

$request  = explode('/', $_REQUEST['request']);
$classname = $request[0];
$id = (int)$request[1];
$data = file_get_contents('php://input');
$query = explode("token=", $_SERVER['QUERY_STRING']);

try {
    spl_autoload_register(function ($class) {
        if (file_exists($class.".php")) {
            require_once $class . '.php';
        } else {
            http_response_code(406);
            echo json_encode(
                array('error' => "Not an available endpoint!")
                , JSON_PRETTY_PRINT);
        }
    });

    if (class_exists($classname)) {
        $request = new $classname;
        switch ($method) {
            case "POST":
                if (isset($query[1]) && CheckToken::isCorrectToken($query[1])) {
                    if (method_exists($request, "create") && $request->create($data)) {
                        http_response_code(201);
                        echo $request->read($request->getId());
                    } else {
                        http_response_code(304);
                        echo json_encode(
                            array('error' => "Could not be created!")
                            , JSON_PRETTY_PRINT);
                    }
                } else {
                    http_response_code(401);
                    echo json_encode(
                        array('error' => "Invalid token!")
                        , JSON_PRETTY_PRINT);
                }
                break;
            case "PUT":
                if (isset($query[1]) && CheckToken::isCorrectToken($query[1])) {
                    if (is_int($id) && $id) {
                        if (method_exists($request, "update") && $request->update($data, $id)) {
                            http_response_code(200);
                            echo $request->read($id);
                        } else {
                            http_response_code(304);
                            echo json_encode(
                                array('error' => "Could not be updated!")
                                , JSON_PRETTY_PRINT);
                        }
                    } else {
                        http_response_code(400);
                        echo json_encode(
                            array('error' => "No Id set!")
                            , JSON_PRETTY_PRINT);
                    }
                } else {
                    http_response_code(401);
                    echo json_encode(
                        array('error' => "Invalid token!")
                        , JSON_PRETTY_PRINT);
                }
                break;
            case "DELETE":
                if (isset($query[1]) && CheckToken::isCorrectToken($query[1])) {
                    if (is_int($id) && $id) {
                        if (method_exists($request, "delete") && $request->delete($id)) {
                            http_response_code(200);
                            echo $request->read();
                        } else {
                            http_response_code(304);
                            echo json_encode(
                                array('error' => "Could not be deleted!")
                                , JSON_PRETTY_PRINT);
                        }
                    } else {
                        http_response_code(400);
                        echo json_encode(
                            array('error' => "No Id set!")
                            , JSON_PRETTY_PRINT);
                    }
                } else {
                    http_response_code(401);
                    echo json_encode(
                        array('error' => "Invalid token!")
                        , JSON_PRETTY_PRINT);
                }
                break;
            case "GET":
                if (method_exists($request, "read")) {
                    if (is_int($id) && $id) {
                        echo $request->read($id);
                    } else {
                        echo $request->read();
                    }
                } else {
                    http_response_code(405);
                    echo json_encode(
                        array('error' => "Method does not exist!")
                        , JSON_PRETTY_PRINT);
                }
                break;
            default:
                http_response_code(405);
                echo json_encode(
                    array('error' => "Method not allowed!")
                    , JSON_PRETTY_PRINT);
        }

    }
} catch (\Throwable $e) {
    http_response_code(404);
    echo json_encode(
        array('exception error' => $e->getMessage())
        , JSON_PRETTY_PRINT);
}

