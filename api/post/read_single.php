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

// Get ID from URL
$post->post_id = isset($_GET['id']) ? $_GET['id'] : die();

// Get single post
$post->readSingle();

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
