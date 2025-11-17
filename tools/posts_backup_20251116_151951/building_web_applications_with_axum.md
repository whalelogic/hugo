---
date = "2025-11-16T14:00:13-05:00"
author: "Keith Thomson"
categories:
  - "Programming"
description: "Axum is a web application framework that focuses on ergonomics and modularity. Built on top of Tokio (for async runtime) and Tower (for middleware and services), it provides a solid foundation for building scalable, fast, and reliable web applications in Rust."
tags:
  - "rust"
  - "axum"
  - "webdev"
  - "web-applications"
  - "tokio"
  - "tower"
  - "programming"
title: "🦀 Building Web Applications with Axum in Rust"
---

Axum is a **web application framework** that focuses on ergonomics and modularity. Built on top of **Tokio** (for async runtime) and **Tower** (for middleware and services), it provides a solid foundation for building **scalable, fast, and reliable web applications** in Rust.  

In this post, we’ll walk through setting up an Axum project, creating routes, handling requests, adding middleware, and building APIs with JSON.  


## 🔧 Setting Up Your Project  

First, let’s create a new Rust project and add Axum as a dependency:  

```bash
cargo new my-web-app
cd my-web-app
cargo add axum tokio --features tokio/full
cargo add tower-http --features full
cargo add serde serde_json --features derive
```  

This will set up a new project with **Axum**, **Tokio**, **Tower HTTP utilities**, and **Serde** for JSON support.  

---

## 🌍 Creating Your First Route  

Here’s how to create a simple HTTP server with Axum:  

```rust
use axum::{
    routing::get,
    Router,
};

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/", get(|| async { "Hello, World!" }));

    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}
```

This creates a basic web server that responds with `"Hello, World!"` on the root path.  

Run it with:  

```bash
cargo run
```  

Visit [http://localhost:3000](http://localhost:3000) in your browser to see it in action.  

---

## 🔗 Handling Path and Query Parameters  

Axum makes it easy to capture path and query parameters.  

```rust
use axum::{extract::Path, routing::get, Router};

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/hello/:name", get(greet));

    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}

async fn greet(Path(name): Path<String>) -> String {
    format!("Hello, {}!", name)
}
```

Now, visiting `/hello/Alice` will return:  

```
Hello, Alice!
```  

You can also extract query parameters using `axum::extract::Query`.  

---

## 📦 Returning JSON Responses  

Axum integrates with `serde` for JSON serialization.  

```rust
use axum::{routing::get, Json, Router};
use serde::Serialize;

#[derive(Serialize)]
struct Message {
    message: String,
}

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/json", get(get_message));

    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}

async fn get_message() -> Json<Message> {
    Json(Message {
        message: "Hello from JSON!".to_string(),
    })
}
```

Visiting `/json` will return:  

```json
{"message": "Hello from JSON!"}
```  

---

## 🛡 Adding Middleware  

Axum builds on **Tower**, so you can add middleware like logging, timeouts, or request limits.  

```rust
use axum::{
    routing::get,
    Router,
};
use tower_http::trace::TraceLayer;

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/", get(|| async { "Hello with middleware!" }))
        .layer(TraceLayer::new_for_http()); // log requests

    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}
```

This logs each request/response, useful for debugging and monitoring.  

---

## 🔨 Building a Small REST API  

Here’s a simple **in-memory todo API** with Axum:  

```rust
use axum::{
    extract::{Path, State},
    routing::{get, post},
    Json, Router,
};
use serde::{Deserialize, Serialize};
use std::sync::{Arc, Mutex};

#[derive(Serialize, Deserialize, Clone)]
struct Todo {
    id: usize,
    text: String,
}

#[derive(Clone, Default)]
struct AppState {
    todos: Arc<Mutex<Vec<Todo>>>,
}

#[tokio::main]
async fn main() {
    let state = AppState::default();

    let app = Router::new()
        .route("/todos", get(list_todos).post(add_todo))
        .route("/todos/:id", get(get_todo))
        .with_state(state);

    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}

async fn list_todos(State(state): State<AppState>) -> Json<Vec<Todo>> {
    let todos = state.todos.lock().unwrap().clone();
    Json(todos)
}

async fn add_todo(State(state): State<AppState>, Json(todo): Json<Todo>) -> Json<Todo> {
    let mut todos = state.todos.lock().unwrap();
    todos.push(todo.clone());
    Json(todo)
}

async fn get_todo(Path(id): Path<usize>, State(state): State<AppState>) -> Option<Json<Todo>> {
    let todos = state.todos.lock().unwrap();
    todos.iter().find(|t| t.id == id).cloned().map(Json)
}
```

Endpoints:  
- `GET /todos` → List todos  
- `POST /todos` → Add a todo (JSON body)  
- `GET /todos/:id` → Fetch a todo by ID  

---

## 🏁 Conclusion  

Axum provides:  
- Clean, ergonomic APIs for routing and request handling.  
- Native async support via Tokio.  
- Integration with Tower for middleware.  
- Strong type safety and Rust’s memory guarantees.  

It’s an excellent choice for building **web servers, REST APIs, and microservices** in Rust.  

💡 *Next Step:* Extend this project with persistent storage (SQLite, Postgres, or Redis) to turn it into a production-ready API.
