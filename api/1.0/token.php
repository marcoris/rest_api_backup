<?php

function getToken() {
    if (isset($_SERVER['QUERY_STRING'])) {
        $qstring = explode("=", $_SERVER['QUERY_STRING']);
        if (isset($qstring[0]) && isset($qstring[1]) && $qstring[0] == "token") {
            return $qstring[1];
        }
    }

    return null;
}

// TODO This is just a cheap way for demonstration purposes and has to be replaced with a database query
function isLoggedIn() {
    return getToken() == "b7ab0a29ef271eaedf169168d0eadc40";
}
