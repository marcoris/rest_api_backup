<?php
// Headers
header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');

include_once '../config/Database.php';
include_once '../models/Post.php';

// Get token and continue
if ($_SERVER['HTTP_TOKEN'] != '' && ($_SERVER['HTTP_TOKEN'] == '@@admintoken' || $_SERVER['HTTP_TOKEN'] == '@@usertoken')) {
    // Instantiate DB + connect
    $database = new Database();
    $db = $database->connect();
    
    // Instantiate Post object
    $post = new Post($db);
    $post->post_id = isset($_GET['id']) ? $_GET['id'] : null;

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
            array('error' => 'No Posts found')
        );
    }
} else {
    echo json_encode(
        array('error' => 'Wrong token!')
    );
}
