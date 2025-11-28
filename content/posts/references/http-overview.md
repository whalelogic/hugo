---
date: "2025-11-16T13:54:10-05:00"
author: "Keith Thomson"
categories:
  - "Network"
  - "Go"
description: "A guide to understanding fundamental HTTP concepts, including the anatomy of a request, how Go parses requests, and how to use headers effectively."
tags:
  - "http"
  - "networking"
  - "web-development"
  - "go"
  - "fiber"
title: "Understanding HTTP Concepts"
---
# 🌀 Understanding HTTP Concepts

**Think of an HTTP request like mailing a package.**

- **URL Path** (`/users/123`): The street address on the package.
- **HTTP Method** (`GET`, `POST`): The delivery instruction (e.g.,
  "Standard Delivery" or "Signature Required").
- **Headers**: The labels on the outside of the box (*From*, *To*,
  *Contents*: Books, *Fragile*: Yes).
- **Body**: The actual items inside the box (like a JSON payload).

::: section
## 📦 The Anatomy of an HTTP Request

A raw request sent from a client might look like this:

    GET /posts/42?comments=true HTTP/1.1
    Host: whalerapi.com
    User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64)
    Accept: application/json
    Authorization: Bearer my-secret-auth-token

    {
      "key": "This is the optional request body, often used with POST or PUT"
    }

Every HTTP request contains **a method, a URL, headers, and optionally a
body**. The server reads this, processes it, and returns a response
(usually in JSON for APIs).
:::

::: section
## 🧠 How Go Parses HTTP Requests

Whether you use Go's `net/http` standard library or a framework like
**Fiber**, the request is parsed into a structured object you can easily
inspect.

### Using the Standard `net/http` Library

``` go
func myHandler(w http.ResponseWriter, r *http.Request) {
    // 1. Get the Method and Path
    method := r.Method        // "GET"
    path := r.URL.Path        // "/posts/42"

    // 2. Get Query Parameters
    showComments := r.URL.Query().Get("comments") // "true"

    // 3. Get Headers
    userAgent := r.Header.Get("User-Agent")      // "Mozilla/5.0..."
    authToken := r.Header.Get("Authorization")   // "Bearer my-secret-auth-token"

    // You can also iterate through all headers
    for name, values := range r.Header {
        fmt.Printf("Header '%s': %s\n", name, values[0])
    }

    // 4. Read the Body (important for POST, PUT, PATCH)
    body, err := io.ReadAll(r.Body)
    if err != nil {
        // Handle error
    }
    fmt.Println(string(body))
}
```

### Using the Fiber Framework

``` go
func myFiberHandler(c *fiber.Ctx) error {
    // 1. Get the Method and Path
    method := c.Method() // "GET"
    path := c.Path()     // "/posts/42"

    // 2. Get Query Parameters
    showComments := c.Query("comments") // "true"

    // 3. Get Headers
    userAgent := c.Get("User-Agent")    // "Mozilla/5.0..."
    authToken := c.Get("Authorization") // "Bearer my-secret-auth-token"

    // 4. Read the Body
    body := c.Body()

    // Parse JSON body into a struct
    var requestData MyStruct
    if err := c.BodyParser(&requestData); err != nil {
        return c.Status(fiber.StatusBadRequest).SendString("Invalid JSON")
    }

    return c.SendString("Request parsed successfully!")
}
```
:::

::: section
## 🔐 Using Headers to Create Better Code

Headers carry metadata that's essential for building robust, secure
APIs. Let's explore a few key headers and how to handle them in Go.

### 1️⃣ Content-Type --- Handling Different Data Formats

This header tells the server what kind of data is in the request body,
such as `application/json` or `multipart/form-data`.

``` go
func createUser(c *fiber.Ctx) error {
    var user User

    if c.Is("json") {
        if err := c.BodyParser(&user); err != nil {
            return c.Status(fiber.StatusBadRequest).SendString("Invalid JSON")
        }
    } else {
        return c.Status(fiber.StatusUnsupportedMediaType).SendString("Content-Type must be application/json")
    }

    // ... Save user to DB ...
    return c.Status(fiber.StatusCreated).JSON(user)
}
```

### 2️⃣ Authorization --- Securing Your Endpoints

The `Authorization` header usually contains a Bearer token or API key.
Middleware validates this before the request reaches your handler.

``` go
func AuthMiddleware(c *fiber.Ctx) error {
    authHeader := c.Get("Authorization")

    if authHeader == "" || !strings.HasPrefix(authHeader, "Bearer ") {
        return c.Status(fiber.StatusUnauthorized).SendString("Missing or malformed JWT")
    }

    token := strings.TrimPrefix(authHeader, "Bearer ")

    if !isValid(token) {
        return c.Status(fiber.StatusUnauthorized).SendString("Invalid JWT")
    }

    return c.Next()
}
```

Apply it globally:

``` go
app.Use(AuthMiddleware)
```

### 3️⃣ Accept --- Content Negotiation

The `Accept` header lets a client specify the preferred response format.
Your server can dynamically choose between JSON, XML, etc.

``` go
func getUser(c *fiber.Ctx) error {
    user := GetUserFromDB()

    switch c.Accepts("json", "xml") {
    case "json":
        return c.JSON(user)
    case "xml":
        return c.XML(user)
    default:
        return c.JSON(user)
    }
}
```
:::

::: section
## 🌍 Understanding the HTTP Lifecycle

HTTP follows a request-response cycle:

1.  **Client sends a request** --- includes method, URL, headers, and
    optional body.
2.  **Server processes the request** --- matches routes, runs
    middleware, interacts with databases.
3.  **Server sends a response** --- includes a status code, headers, and
    optional body.

Example response:

    HTTP/1.1 200 OK
    Content-Type: application/json
    Date: Mon, 06 Oct 2025 19:00:00 GMT

    {
      "message": "User retrieved successfully",
      "id": 123
    }
:::

::: section
## ⚡ Common HTTP Status Codes

- **200 OK** --- Request successful
- **201 Created** --- Resource created successfully
- **400 Bad Request** --- Malformed or invalid request
- **401 Unauthorized** --- Missing or invalid authentication
- **403 Forbidden** --- You're not allowed to access this resource
- **404 Not Found** --- The requested resource doesn't exist
- **500 Internal Server Error** --- Something went wrong on the server
:::

::: section
## 💡 Pro Tips for API Developers

- Always log the `Method`, `Path`, and `Status` for each request.
- Use middleware for repetitive tasks like authentication and
  rate-limiting.
- Return meaningful error messages in JSON format.
- Validate request bodies before database operations.
- Always use HTTPS (TLS) in production to protect credentials and
  tokens.
:::

------------------------------------------------------------------------

*Written by Keith Thomson --- Go Developer & API Engineer*