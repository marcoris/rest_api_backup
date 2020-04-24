<?php
// Headers
header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Methods: DELETE');
header('Access-Control-Allow-Headers: Access-Control-Allow-Headers, Content-type, Access-Control-Allow-Methods, Authorization, X-Requested-Width');

include_once '../../config/Database.php';
include_once '../../models/Post.php';

// Instantiate DB + connect
$database = new Database();
$db = $database->connect();

// Instantiate Post object
$post = new Post($db);

// Get raw posted data
$data = json_decode(file_get_contents("php://input"));

// Set id to update
$post->post_id = $data->id;

// Delete post
if ($post->delete()) {
    echo json_encode(
        array('message' => 'Post deleted')
    );
} else {
        echo json_encode(
            array('message' => 'Post not deleted')
        );
}
