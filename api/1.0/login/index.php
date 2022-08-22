<?php
// TODO This is just a cheap way for demonstration purposes and has to be replaced with a database query
if (
    isset($_SERVER['PHP_AUTH_USER']) &&
    $_SERVER['PHP_AUTH_PW'] &&
    $_SERVER['PHP_AUTH_USER'] == 'marco' &&
    $_SERVER['PHP_AUTH_PW'] == '1234'
) {
    echo "Token: " . md5("SECRETKEY");
    exit;
}

echo "Wrong credentials!";
header("WWW-Authenticate: Basic realm=\"Secret Area\"");
head("HTTP/1.0 401 Unauthorized");
exit;
