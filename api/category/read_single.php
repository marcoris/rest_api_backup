<?php
// Headers
header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');

include_once '../../config/Database.php';
include_once '../../models/Category.php';

// Instantiate DB + connect
$database = new Database();
$db = $database->connect();

// Instantiate category object
$category = new Category($db);

// Get ID from URL
$category->category_id = isset($_GET['id']) ? $_GET['id'] : die();

// Get single category
$category->readSingle();

// Check if any Category
if ($category->num > 0) {
    // Create array
    $categoryArr = array(
        'id' => $category->id,
        'name' => $category->name,
        'created_at' => $category->created_at,
    );

    // Make JSON
    print_r(json_encode($categoryArr));
} else {
    // No Categorys
    echo json_encode(
        array('message' => 'No Category found')
    );
}
