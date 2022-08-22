<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, DELETE, PUT');

$method = $_SERVER["REQUEST_METHOD"];
//$requestUri = $_SERVER["REQUEST_URI"];
echo $method;
