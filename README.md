# REST api v1.0

##


## Usage v1.0
|Category|URL|Method|Access|
|---|---|---|---|
|post|http://localhost:8080/api/1.0/post/read.php|GET|Public|
|post|http://localhost:8080/api/1.0/post/read.php?id={id}|GET|Public|
|post|http://localhost:8080/api/1.0/post/create.php|POST|Public|
|post|http://localhost:8080/api/1.0/post/update.php?id={id}|PUT|Private|
|post|http://localhost:8080/api/1.0/post/delete.php?id={id}|DELETE|Private|
|category|http://localhost:8080/api/1.0/category/read.php|GET|Public|
|category|http://localhost:8080/api/1.0/category/read.php?id={id}|GET|Public|
|category|http://localhost:8080/api/1.0/category/create.php|POST|Public|
|category|http://localhost:8080/api/1.0/category/update.php?id={id}|PUT|Private|
|category|http://localhost:8080/api/1.0/category/delete.php?id={id}|DELETE|Private|

## Token
There has to be a token for the `PUT` and `DELETE` methods. The token is not public. The only public token is for the `GET` and `POST` methods.