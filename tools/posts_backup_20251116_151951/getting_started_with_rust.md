---
date = "2025-11-16T14:00:19-05:00"
author: "Keith Thomson"
categories:
  - "Programming"
description: "Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety."
tags:
  - "rust"
  - "programming"
title: "🦀 Getting Started with Rust"
---

Rust is a **systems programming language** that runs blazingly fast, prevents segfaults, and guarantees thread safety. In this post, we’ll explore the **fundamentals of Rust**, why it’s becoming increasingly popular among developers, and walk through practical examples that show how Rust differs from other languages.  



## 🌟 Why Rust?  

Rust offers several advantages over traditional systems programming languages like **C** and **C++**:  

- **Memory Safety**: Prevents common bugs like null pointer dereferences and buffer overflows.  
- **Performance**: Zero-cost abstractions — you don’t pay for features you don’t use.  
- **Concurrency**: Built-in support for safe, data-race-free concurrent programming.  
- **Modern Ecosystem**: A strong package manager (`cargo`), vibrant community, and modern tooling.  

> 💡 **Tip:** Rust enforces correctness at compile time, saving you from runtime surprises that are common in C/C++.  

---

## 🔤 Basic Concepts  

Let’s start with the classic **Hello, World!** program:  

```rust
fn main() {
    println!("Hello, World!");
}
```

This simple program demonstrates Rust’s **clean syntax** and its **macro system** (notice the `!` in `println!`). Macros in Rust are more powerful than standard functions — they can generate code at compile time.  

---

## 📝 Variables and Mutability  

In Rust, variables are **immutable by default**. This means once you assign a value, it cannot change unless you explicitly declare it as mutable.  

```rust
fn main() {
    let x = 5;        // immutable
    let mut y = 10;   // mutable

    println!("x = {}", x);
    println!("y = {}", y);

    y = 15;
    println!("y (after change) = {}", y);
}
```

- `let` creates a variable.  
- `mut` makes it mutable.  
- Rust encourages immutability to reduce bugs and improve safety.  

---

## 🔑 Ownership and Borrowing  

Rust’s **ownership system** is its most unique feature. It enforces memory safety without a garbage collector.  

### Example: Ownership  

```rust
fn main() {
    let s1 = String::from("Rust");
    let s2 = s1; // ownership moved from s1 to s2

    // println!("{}", s1); // ❌ Error: s1 is no longer valid
    println!("{}", s2);   // ✅ Works
}
```

- Variables own their data.  
- When ownership is transferred (moved), the old variable is invalidated.  

### Example: Borrowing  

```rust
fn main() {
    let s = String::from("Borrowing in Rust");
    print_length(&s); // pass reference (borrow)
    println!("s is still valid: {}", s);
}

fn print_length(s: &String) {
    println!("Length: {}", s.len());
}
```

- `&` means “borrow without taking ownership.”  
- The original variable remains valid.  

> 🔒 This system prevents dangling pointers and memory leaks at compile time.  

---

## 🔧 Functions and Control Flow  

Rust functions look familiar, but with strong typing and return value rules.  

```rust
fn main() {
    println!("Sum = {}", add(5, 7));

    let number = 6;
    if number % 2 == 0 {
        println!("Even");
    } else {
        println!("Odd");
    }
}

fn add(a: i32, b: i32) -> i32 {
    a + b  // no semicolon = return value
}
```

- Functions must declare parameter and return types.  
- Leaving out the semicolon `;` makes it an **expression** that returns a value.  

---

## ⚠️ Error Handling  

Rust does not have exceptions. Instead, it uses:  
- `Result<T, E>` for recoverable errors.  
- `Option<T>` for values that may or may not exist.  

```rust
use std::fs::File;
use std::io::ErrorKind;

fn main() {
    let file = File::open("data.txt");

    match file {
        Ok(_) => println!("File opened successfully."),
        Err(ref e) if e.kind() == ErrorKind::NotFound => {
            println!("File not found, creating one...");
        }
        Err(e) => {
            println!("Error: {:?}", e);
        }
    }
}
```

This forces you to **handle errors explicitly**.  

---

## 🧵 Concurrency  

Rust makes concurrency safe by design. Threads must follow ownership and borrowing rules.  

```rust
use std::thread;

fn main() {
    let handles: Vec<_> = (1..5).map(|i| {
        thread::spawn(move || {
            println!("Hello from thread {}", i);
        })
    }).collect();

    for handle in handles {
        handle.join().unwrap();
    }
}
```

- `move` transfers ownership into the thread.  
- No data races are possible because Rust enforces safe access at compile time.  

---

## 🏁 Conclusion  

Rust combines **the performance of C/C++** with **modern safety guarantees** and a thriving ecosystem. Its ownership model may take time to learn, but it pays off by eliminating entire classes of bugs.  

Whether you’re building:  
- 🚀 **High-performance applications**  
- 🌐 **Web servers with frameworks like Actix or Axum**  
- 📊 **Data pipelines and concurrent systems**  
- 🔒 **Secure, low-level embedded software**  

Rust is quickly becoming the **go-to language for systems programming** in the modern era.  

---

💡 *Next Step:* Try rewriting a small project you’ve built in Python, Go, or C into Rust — you’ll immediately see how ownership, borrowing, and safety rules shape your design.
