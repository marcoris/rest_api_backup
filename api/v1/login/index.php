<?php
// TODO This is just a cheap way for demonstration purposes and has to be replaced with a database query
if (
    $_SERVER['PHP_AUTH_USER'] == 'marco' &&
    $_SERVER['PHP_AUTH_PW'] == '1234'
) {
    header("HTTP/1.1 200 OK");
    echo json_encode(
        array('token' => md5("SECRETKEY"))
        , JSON_PRETTY_PRINT);
    exit;
}

header("WWW-Authenticate: Basic realm=\"Secret Area\"");
header("HTTP/1.0 401 Unauthorized");
echo "Wrong credentials!";
exit;
