# REST api v1
## Usage
| Category | URL                                                      | Method | Access  |
|----------|----------------------------------------------------------|--------|---------|
| login    | http://localhost:8080/api/v1/login                       | GET    | Private |
| post     | http://localhost:8080/api/v1/posts                       | GET    | Public  |
| post     | http://localhost:8080/api/v1/posts/{:id}                 | GET    | Public  |
| post     | http://localhost:8080/api/v1/posts                       | POST   | Private |
| post     | http://localhost:8080/api/v1/posts/{:id}                 | PUT    | Private |
| post     | http://localhost:8080/api/v1/posts/{:id}                 | DELETE | Private |

## Token
There has to be a token for the `POST`, `PUT` and `DELETE` methods. You can generate the token under `http://localhost:8080/api/v1/login` with `marco:1234`. There is no production solution implemented yet!

## Unit tests
They have to be written...

## Adding new endpoint
1. Create Table with columns
2. Put a file in the directory `api/v1` named [Endpointname].php with the same CRUD methods like `api/v1/Posts.php`
3. Write some tests

## Payload
In the header: the token

In the body: { json }
