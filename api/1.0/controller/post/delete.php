<?php
// Headers
header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');
header('Access-Control-Allow-Methods: DELETE');
header('Access-Control-Allow-Headers: Access-Control-Allow-Headers, Content-type, Access-Control-Allow-Methods, Authorization, X-Requested-Width');

include_once '../../config/Database.php';
include_once '../../models/Post.php';
include_once '../../token.php';

if (isLoggedIn()) {
    $data = json_decode(file_get_contents("php://input"));

    if ($data->id) {
        // Instantiate DB + connect
        $database = new Database();
        $db = $database->connect('myblog');

        // Instantiate Post object
        $post = new Post($db);
        $post->post_id = $data->id;
        $result = $post->readSingle();

        if ($result->rowCount() > 0) {
            // Delete post
            if ($post->delete()) {
                echo json_encode(
                    array('message' => 'Post deleted')
                );
            } else {
                echo json_encode(
                    array('error' => 'Post could not be deleted')
                );
            }
        } else {
            echo json_encode(
                array('error' => 'Id not found')
            );
        }
    } else {
        echo json_encode(
            array('error' => 'Id not set')
        );
    }
} else {
    echo json_encode(
        array('error' => 'Wrong token!')
    );
}
