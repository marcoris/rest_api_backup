<?php
// Headers
header('Access-Control-Allow-Origin: *');
header('Content-type: application/json');

include_once '../config/Database.php';
include_once '../models/Freizeitradar.php';

// Get token and continue
if ($_SERVER['HTTP_TOKEN'] != '' && ($_SERVER['HTTP_TOKEN'] == '@@admintoken' || $_SERVER['HTTP_TOKEN'] == '@@usertoken')) {
    // Instantiate DB + connect
    $database = new Database();
    $db = $database->connect('cl10-freizeit');
    
    // Instantiate freizeitradar object
    $freizeitradar = new Freizeitradar($db);
    $freizeitradar->freizeitradar_id = isset($_GET['id']) ? $_GET['id'] : null;

    // freizeitradar query
    if ($freizeitradar->freizeitradar_id != null) {
        $result = $freizeitradar->readSingle();
    } else {
        $result = $freizeitradar->read();
    }

    // Check if any freizeitradar
    if ($result->rowCount() > 0) {
        // freizeitradar array
        $freizeitradarArr = array();
        $freizeitradarArr['data'] = array();

        while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
            extract($row);

            $freizeitradarItem = array(
                'id' => $id
            );

            // Push to data
            array_push($freizeitradarArr['data'], $freizeitradarItem);
        }

        // Turn into JSON
        echo json_encode($freizeitradarArr);
    } else {
        // No freizeitradars
        echo json_encode(
            array('error' => 'No freizeitradars found')
        );
    }
} else {
    echo json_encode(
        array('error' => 'Wrong token!')
    );
}
