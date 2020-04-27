<?php
// Headers
header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Access-Control-Allow-Headers, Content-type, Access-Control-Allow-Methods, Authorization, X-Requested-Width');

include_once '../config/Database.php';
include_once '../models/Category.php';

// Get token and continue
if ($_SERVER['HTTP_TOKEN'] != '' && ($_SERVER['HTTP_TOKEN'] == '@@admintoken' || $_SERVER['HTTP_TOKEN'] == '@@usertoken')) {
    // Instantiate DB + connect
    $database = new Database();
    $db = $database->connect();

    // Instantiate Category object
    $category = new Category($db);

    // Get raw category data
    $data = json_decode(file_get_contents("php://input"));

    $category->name = $data->name;

    // Create Category
    if ($category->create()) {
        echo json_encode(
            array('message' => 'Category created')
        );
    } else {
        echo json_encode(
            array('message' => 'Category not created')
        );
    }
} else {
    echo json_encode(
        array('error' => 'Wrong token!')
    );
}
