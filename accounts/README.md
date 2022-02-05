# Accounts API

## Authenticate
### Request
- type: POST
- path: /accounts/authenticate/
- content: JSON
- request body:
  ```
  {
    "username": string,
    "password": string
  }
  ```
  
### Response:
- content: JSON
- codes:
  - 200 Ok - success
  - 400 Bad Request - authentication failed
- content on success:
  ```
  {
    "auth_token": string
  }
  ```
  
## Authorized
### Request
- type: POST
- path: /authorize/
- content: JSON
- additional headers:
  ```
  Authorization:Token
  ```
  
### Response
- content: JSON
- codes:
  - 200 Ok - success
  - 401 Unathorized - unauthorised
  - 400 Bad Request - params missing
- additional headers:
  ```
  Authenticated:UserId
  ```
  
## Register
### Request
- type: POST
- path: /accounts/register/
- content: JSON
- request body:
  ```
  {
    "username": string,
    "password": string,
    "password_confirmation": string
  }
  ```
  
### Response
- content: JSON
- codes:
  - 200 Ok - success
  - 400 Bad Request - params missing or incorrect
- content on success:
  ```
  {
    "auth_token": string
  }
  ```
