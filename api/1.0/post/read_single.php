<?php
// Headers
header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');

include_once '../config/Database.php';
include_once '../models/Post.php';

// Instantiate DB + connect
$database = new Database();
$db = $database->connect();

// Instantiate Post object
$post = new Post($db);

// Get raw posted data
$data = json_decode(file_get_contents("php://input"));

// Set id to update
$post->post_id = $data->id;

// Get ID from URL
$post->post_id = isset($_GET['id']) ? $_GET['id'] : die();

// Get single post
$post->readSingle();

if ($post->num > 0) {
    // Create array
    $postArr = array(
        'id' => $post->post_id,
        'title' => $post->title,
        'body' => $post->body,
        'author' => $post->author,
        'category_id' => $post->category_id,
        'category_name' => $post->category_name,
        'created_at' => $post->created_at,
    );
    
    // Make JSON
    print_r(json_encode($postArr));
} else {
    // No posts
    echo json_encode(
        array('message' => 'No Post found')
    );
}

