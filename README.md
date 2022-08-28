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
There has to be a token for the `CREATE`, `PUT` and `DELETE` methods. You can generate the token under `http://localhost:8080/api/v1/login` with `marco:1234`

## Unit tests
They have to be written...
