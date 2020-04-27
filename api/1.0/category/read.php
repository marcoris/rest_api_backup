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

// Category query
$result = $category->read();

// Get row count
$num = $result->rowCount();

// Check if any Category
if ($num > 0) {
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
