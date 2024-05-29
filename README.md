# Backend Senior Coding Challenge 🍿

## ✅ Requirements

- [*] The backend should expose RESTful endpoints to handle user input and
  return movie ratings.
- [*] The system should store data in a database. You can use any existing
  dataset or API to populate the initial database.
- [*] Implement user endpoints to create and view user information.
- [*] Implement movie endpoints to create and view movie information.
- [*] Implement a rating system to rate the entertainment value of a movie.
- [*] Implement a basic profile where users can view their rated movies.
- [*] Include unit tests to ensure the reliability of your code.
- [*] Ensure proper error handling and validation of user inputs.

## ✨ Bonus Points

- [*] Implement authentication and authorization mechanisms for users.
- [*] Provide documentation for your API endpoints using tools like Swagger.
- [*] Implement logging to record errors and debug information.
- [ ] Implement caching mechanisms to improve the rating system's performance.
- [ ] Implement CI/CD quality gates.


# Movie Rating API

## Project Overview

This is a Ruby on Rails API built for managing and rating movies. It provides endpoints for user authentication, movie creation/retrieval, and user ratings. The API follows JSON:API conventions and leverages JWT (JSON Web Tokens) for authentication.

### System Design

#### The API follows a layered architecture:

- Controller Layer: Handles incoming HTTP requests, interacts with service objects, and renders JSON API responses.
- Service Layer: Encapsulates business logic related to rating functionality.
- Model Layer: Represents the data entities (User, Movie, Rating) and their relationships.
- Data Access Layer (Active Record): Handles database interactions and provides an abstraction over the underlying database.

**Key Features:**

*   User registration and login (JWT authentication)
*   Create, retrieve, movies
*   Rate movies (1-10 scale) with average rating calculation
*   API versioning
*   Error handling and input validation
*   RSpec test suite with FactoryBot for test data generation

**Future Improvements:**

*   User roles (normal user, admin) with authorization to restrict movie creation to admins.
*   Background job processing for average rating calculation (using Sidekiq or similar).
*   Potential implementation of a Redis cache to store and update average ratings efficiently.

## Technologies Used
*   Ruby 3.3.0
*   Rails 7.1.3
*   SQLite (development database)
*   JWT (JSON Web Tokens) for authentication
*   jsonapi-serializer for JSON:API serialization
*   RSpec for testing


## Setup Instructions

1.  **Clone the Repository:**
  * Make sure you have Ruby 3.3.0 installed

2.  **Install Dependencies:**
    ```bash
    bundle install
    ```

3.  **Environment Variables:**
    *   Copy `.env.example` to `.env`.
    *   Update `.env` with your actual credentials (e.g., JWT secret key).

4.  **Prepare the Database:**
    ```bash
    rails db:create
    rails db:migrate
    ```

5.  **Seed the Database:**
    ```bash
    rails db:seed
    ```

6.  **Start the Server:**
    ```bash
    rails s
    ```

## Testing

Run the test suite with:

```bash
rspec
  ```

## API Endpoints
**HOST: localhost:3000/**
### Users

**POST /api/v1/users**

Creates a new user account.

**Request Body:**

```json
{ "user": {
    "email": "john.doe@example.com",
    "password": "password123",
    "password_confirmation": "password123",
    "name": "John Doe"
  }
}
```
**Response (Success):**
```json
{
  "data": {
    "id": "1",
    "type": "users",
    "attributes": {
      "email": "john.doe@example.com",
      "name": "John Doe"
    }
  }
}
```

**Response (Error):**
```json
{
  "errors": [
    {
      "status": "422",
      "title": "Validation error",
      "detail": "Email can't be blank" 
    }
  ]
}
```

**GET /api/v1/users/:id**
- Retrieves a specific user's information by their ID. Requires authentication.

**Response (Success):**
```json
{
  "data": {
    "id": "1",
    "type": "users",
    "attributes": {
      "email": "john.doe@example.com",
      "name": "John Doe"
    }
  }
}
```

**Response (Error):**
```json
{
  "errors": [
    {
      "status": "404",
      "title": "Not Found"
    }
  ]
}
```


*GET GET /api/v1/profile**
- Retrieves the currently authenticated user's profile, including their rated movies. Requires authentication..
- Include the JWT token in the Authorization header.

**Response (Success):**
```json
{
  "data": {
    "id": "2",
    "type": "users",
    "attributes": {
      "email": "jane.smith@example.com",
      "name": "Jane Smith"
    },
    "relationships": {
      "rated_movies": {
        "data": [
          // ... movie details (from the MovieSerializer) ...
        ]
      }
    }
  }
}
```

## Authentication

**POST /api/v1/login**

- Authenticates a user and returns a JWT token. This token is required for accessing protected endpoints (e.g., rating movies, viewing user profiles).

**Request Body:**

```json
{
  "email": "[email address removed]",
  "password": "password123"
}
```

**Response (Success):**

```json
{
  "token": "your_generated_jwt_token"
}
```

**Response (Error):**

```json
{
  "error": "Unauthorized"
}
```


## Ratings

**POST /api/v1/movies/:movie_id/ratings**

- Creates a new rating for a specified movie.
- This endpoint requires authentication.
- Authorization: Bearer your_jwt_token

**Request Body:**

```json
{
  "rating": {
    "score": 8  
  }
}
```

**Response (Success):**

```json
{
  "data": {
    "id": "123", 
    "type": "ratings",
    "attributes": {
      "score": 8,
      "created_at": "2023-11-23T16:45:00Z",
      "updated_at": "2023-11-23T16:45:00Z"
    },
    "relationships": {
      "user": {
        "data": {
          "id": "1", 
          "type": "users"
        }
      },
      "movie": {
        "data": {
          "id": "1",
          "type": "movies"
        }
      }
    }
  }
}
```

**Response (Error - 422 Unprocessable Entity):**

```json
{
  "errors": [
    {
      "status": "422",
      "title": "Validation error",
      "detail": "Score must be less than or equal to 10" 
    }
  ]
}
```

