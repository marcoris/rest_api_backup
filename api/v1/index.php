<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, DELETE, PUT');
header("Content-type:application/json");

$method = $_SERVER['REQUEST_METHOD'];

$request  = explode('/', $_REQUEST['request']);
$classname = $request[0];
$id = $request[1];
$data = file_get_contents('php://input');
$query = explode("token=", $_SERVER['QUERY_STRING']);


try {
    spl_autoload_register(function ($class) {
        if (file_exists($class.".php")) {
            require_once $class . '.php';
        } else {
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
                        echo $request->read($request->getId());
                    } else {
                        echo json_encode(
                            array('error' => "Could not be created!")
                            , JSON_PRETTY_PRINT);
                    }
                } else {
                    echo json_encode(
                        array('error' => "Invalid token!")
                        , JSON_PRETTY_PRINT);
                }
                break;
            case "PUT":
                if (isset($query[1]) && CheckToken::isCorrectToken($query[1])) {
                    if ($id) {
                        if (method_exists($request, "update") && $request->update($data, $id)) {
                            echo $request->read($id);
                        } else {
                            echo json_encode(
                                array('error' => "Could not be updated!")
                                , JSON_PRETTY_PRINT);
                        }
                    } else {
                        echo json_encode(
                            array('error' => "No Id set!")
                            , JSON_PRETTY_PRINT);
                    }
                } else {
                    echo json_encode(
                        array('error' => "Invalid token!")
                        , JSON_PRETTY_PRINT);
                }
                break;
            case "DELETE":
                if (isset($query[1]) && CheckToken::isCorrectToken($query[1])) {
                    if ($id) {
                        if (method_exists($request, "delete") && $request->delete($id)) {
                            echo $request->read();
                        } else {
                            echo json_encode(
                                array('error' => "Could not be deleted!")
                                , JSON_PRETTY_PRINT);
                        }
                    } else {
                        echo json_encode(
                            array('error' => "No Id set!")
                            , JSON_PRETTY_PRINT);
                    }
                } else {
                    echo json_encode(
                        array('error' => "Invalid token!")
                        , JSON_PRETTY_PRINT);
                }
                break;
            case "GET":
                if (method_exists($request, "read")) {
                    if ($id) {
                        echo $request->read($id);
                    } else {
                        echo $request->read();
                    }
                }
                break;
            default:
                echo json_encode(
                    array('error' => "Not an available method!")
                    , JSON_PRETTY_PRINT);
        }

    }
} catch (\Throwable $e) {
    echo json_encode(
        array('exception error' => $e->getMessage())
        , JSON_PRETTY_PRINT);
}

