<?php

class CheckToken
{
    /**
     * @param $token
     * @return bool
     */
    public static function isCorrectToken($token): bool
    {
        return $token === "b7ab0a29ef271eaedf169168d0eadc40";
    }
}
