<?php
// Headers
header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');

include_once '../../config/Database.php';
include_once '../../models/Post.php';

// Instantiate DB + connect
$database = new Database();
$db = $database->connect();

// Instantiate Post object
$post = new Post($db);

// Post query
$result = $post->read();

// Get row count
$num = $result->rowCount();

// Check if any post
if ($num > 0) {
    // Post array
    $postArr = array();
    $postArr['data'] = array();

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);

        $postItem = array(
            'id' => $id,
            'title' => $title,
            'body' => html_entity_decode($body),
            'author' => $author,
            'category_id' => $category_id,
            'category_name' => $category_name
        );

        // Push to data
        array_push($postArr['data'], $postItem);
    }

    // Turn into JSON
    echo json_encode($postArr);
} else {
    // No posts
    echo json_encode(
        array('message' => 'No Posts found')
    );
}
