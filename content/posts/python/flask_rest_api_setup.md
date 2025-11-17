---
date: "2025-11-16T14:10:27-05:00"
author: "Keith Thomson"
categories:
  - "Web Development"
description: "In this tutorial, we'll walk through setting up a basic Flask REST API. We'll cover the essential steps, from installing dependencies to creating routes for CRUD operations."
tags:
  - "python"
  - "flask"
  - "rest-api"
  - "tutorial"
  - "crud"
  - "api"
  - "web-services"
title: "🐍 Flask REST API Setup: A Step-by-Step Tutorial"
---

## 📋 Introduction

In this tutorial, we'll walk through setting up a **basic Flask REST API**. We'll cover the essential steps, from installing dependencies to creating routes for **CRUD operations**.

---

## 🛠️ Step 1: Install Dependencies

To start, you'll need to install **Flask** and **Flask-RESTful**. Use `pip` to install them:

```bash
pip install flask flask-restful
```

### 📂 Step 2: Create a New Flask App
Create a new file called app.py and add the following code:
```python
from flask import Flask
from flask_restful import Api

app = Flask(__name__)
api = Api(app)

@app.route('/')
def home():
    return "Welcome to my API!"

if __name__ == '__main__':
    app.run(debug=True)
```
This sets up a basic Flask app with a single route.

### 🔧 Step 3: Define Your API Endpoints
Let's create a simple API for managing books. We'll define endpoints for CRUD operations:
from flask_restful import Resource, reqparse

# Sample in-memory data store
```python
books = [
    {"id": 1, "title": "Book 1", "author": "Author 1"},
    {"id": 2, "title": "Book 2", "author": "Author 2"}
]

class BookList(Resource):
    def get(self):
        return books

    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument("title", type=str, required=True)
        parser.add_argument("author", type=str, required=True)
        args = parser.parse_args()
        new_book = {
            "id": len(books) + 1,
            "title": args["title"],
            "author": args["author"]
        }
        books.append(new_book)
        return new_book, 201

class Book(Resource):
    def get(self, book_id):
        book = next((book for book in books if book["id"] == book_id), None)
        if book is None:
            return {"error": "Book not found"}, 404
        return book

    def put(self, book_id):
        book = next((book for book in books if book["id"] == book_id), None)
        if book is None:
            return {"error": "Book not found"}, 404
        parser = reqparse.RequestParser()
        parser.add_argument("title", type=str)
        parser.add_argument("author", type=str)
        args = parser.parse_args()
        book["title"] = args.get("title", book["title"])
        book["author"] = args.get("author", book["author"])
        return book

    def delete(self, book_id):
        book = next((book for book in books if book["id"] == book_id), None)
        if book is None:
            return {"error": "Book not found"}, 404
        books.remove(book)
        return {"message": "Book deleted"}

api.add_resource(BookList, "/books")
api.add_resource(Book, "/books/<int\:book_id>")
```
## Endpoint Summary
- BookListGET/booksRetrieve all books
- BookListPOST/booksCreate a new book
- BookGET/books/<book_id>Retrieve a single book
- BookPUT/books/<book_id>Update a book
- BookDELETE/books/<book_id>Delete a book

### ▶️ Step 4: Run Your API
Run your API using:
python app.py
You can now interact with your API using tools like curl or a REST client.

### 📌 Example Use Cases
Get all bookscurl http://localhost:5000/books 
Create a new book 
```bash 
curl -X POST -H "Content-Type: application/json" -d '{"title": "New Book", "author": "New Author"}' http://localhost:5000/booksGet a single bookcurl http://localhost:5000/books/1Update a bookcurl -X PUT -H "Content-Type: application/json" -d '{"title": "Updated Book"}' http://localhost:5000/books/1Delete a bookcurl -X DELETE http://localhost:5000/books/1
```
## 🎯 Conclusion
This tutorial provides a basic setup for a Flask REST API. You can build upon this example to create more complex APIs with additional features like:
