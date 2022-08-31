<?php
// TODO This is just a cheap way for demonstration purposes and has to be replaced with a database query
if (
    $_SERVER['PHP_AUTH_USER'] == 'marco' &&
    $_SERVER['PHP_AUTH_PW'] == '1234'
) {
    http_response_code(202);
    echo json_encode(
        array('token' => md5("SECRETKEY"))
        , JSON_PRETTY_PRINT);
    exit;
}

http_response_code(401);
echo "Wrong credentials!";
exit;
