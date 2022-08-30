<?php

interface Iapi
{
    public function getId();
    public function create(string $data) : bool;
    public function read(int $id = null): string;
    public function update(string $data, int $id): bool;
    public function delete(int $id): bool;
}
