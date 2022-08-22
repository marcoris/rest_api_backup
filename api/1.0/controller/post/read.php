<?php
// Headers
header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');

include_once '../../config/Database.php';
include_once '../../models/Post.php';

// Instantiate DB + connect
$database = new Database();
$db = $database->connect('myblog');

// Instantiate Post object
$post = new Post($db);
$data = json_decode(file_get_contents("php://input"));
$post->post_id = $data->id;

// Post query
if ($post->post_id != null) {
    $result = $post->readSingle();
} else {
    $result = $post->read();
}

// Check if any post
if ($result->rowCount() > 0) {
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
            'category_name' => $category_name,
            'created_at' => $created_at
        );

        // Push to data
        $postArr['data'][] = $postItem;
    }

    // Turn into JSON
    echo json_encode($postArr);
} else {
    // No posts
    echo json_encode(
        array('error' => 'No Posts found')
    );
}
