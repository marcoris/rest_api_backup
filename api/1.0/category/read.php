<?php
// Headers
header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');

include_once '../config/Database.php';
include_once '../models/Category.php';

// Instantiate DB + connect
$database = new Database();
$db = $database->connect();

// Instantiate Category object
$category = new Category($db);

$category->category_id = isset($_GET['id']) ? $_GET['id'] : null;

// Post query
if ($category->category_id != null) {
    $result = $category->readSingle();
} else {
    $result = $category->read();
}

// Check if any Category
if ($result->rowCount() > 0) {
    // Category array
    $categoryArr = array();
    $categoryArr['data'] = array();

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);

        $categoryItem = array(
            'id' => $id,
            'name' => $name,
            'created_at' => html_entity_decode($created_at)
        );

        // Push to data
        array_push($categoryArr['data'], $categoryItem);
    }

    // Turn into JSON
    echo json_encode($categoryArr);
} else {
    // No Categorys
    echo json_encode(
        array('message' => 'No Categories found')
    );
}
