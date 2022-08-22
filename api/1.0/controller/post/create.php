<?php
// Headers
header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Access-Control-Allow-Headers, Content-type, Access-Control-Allow-Methods, Authorization, X-Requested-Width');

include_once '../../config/Database.php';
include_once '../../models/Post.php';
include_once '../../token.php';

if (isLoggedIn()) {
    $data = json_decode(file_get_contents("php://input"));

    if (
        $data &&
        $data->title &&
        $data->body &&
        $data->author &&
        $data->category_id
    ) {
        // Instantiate DB + connect
        $database = new Database();
        $db = $database->connect('myblog');

        // Instantiate Post object
        $post = new Post($db);
        $post->title = $data->title;
        $post->body = $data->body;
        $post->author = $data->author;
        $post->category_id = $data->category_id;

        // Create post
        if ($post->create()) {
            $id = $post->getId();
            echo json_encode(
                array('message' => "Post with id $id created")
            );
        } else {
            echo json_encode(
                array('error' => 'Post could not be created!')
            );
        }
    } else {
        echo json_encode(
            array('error' => 'Error in data')
        );
    }
} else {
    echo json_encode(
        array('error' => 'Wrong token!')
    );
}
