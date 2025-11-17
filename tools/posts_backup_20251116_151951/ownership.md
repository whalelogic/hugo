---
date = "2025-11-16T14:01:10-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- rust
- programming
title: "🦀 Rust Ownership"
---

# Rust Ownership {#rust-ownership .title}

Ownership is Rust\'s most unique feature and has deep implications for
the rest of the language. It enables Rust to make memory safety
guarantees without needing a garbage collector.

## Ownership Rules {#ownership-rules .subtitle}

Rust\'s ownership system follows three main rules:

- Each value in Rust has an owner
- There can only be one owner at a time
- When the owner goes out of scope, the value will be dropped

## Variable Scope {#variable-scope .subtitle}

A scope is the range within a program for which an item is valid:

    fn main() {
        {                      // s is not valid here, not yet declared
            let s = "hello";   // s is valid from this point forward
            // do stuff with s
        }                      // scope is over, s is no longer valid
    }

## Move Semantics {#move-semantics .subtitle}

Rust moves ownership by default for types on the heap:

    fn main() {
        let s1 = String::from("hello");
        let s2 = s1;  // s1 is moved to s2
        
        // println!("{}", s1); // Error: value borrowed after move
        println!("{}", s2);  // This works
    }

## Clone {#clone .subtitle}

To create a deep copy, use the clone method:

    fn main() {
        let s1 = String::from("hello");
        let s2 = s1.clone();  // Explicitly copy data
        
        println!("s1 = {}, s2 = {}", s1, s2);  // Both work
    }

## Copy Types {#copy-types .subtitle}

Types stored entirely on the stack use Copy semantics:

    fn main() {
        let x = 5;
        let y = x;  // x is copied, not moved
        
        println!("x = {}, y = {}", x, y);  // Both work
    }

    // Types that implement Copy:
    // - All integer types
    // - Boolean type
    // - All floating-point types
    // - Character type
    // - Tuples (if they only contain Copy types)

## Ownership and Functions {#ownership-and-functions .subtitle}

Passing a value to a function transfers ownership:

    fn main() {
        let s = String::from("hello");
        takes_ownership(s);  // s is moved into the function
        // s is no longer valid here
        
        let x = 5;
        makes_copy(x);  // x is copied
        // x is still valid here
    }

    fn takes_ownership(some_string: String) {
        println!("{}", some_string);
    } // some_string goes out of scope and is dropped

    fn makes_copy(some_integer: i32) {
        println!("{}", some_integer);
    } // some_integer goes out of scope, nothing special happens

## Return Values and Scope {#return-values-and-scope .subtitle}

Returning values transfers ownership:

    fn main() {
        let s1 = gives_ownership();
        let s2 = String::from("hello");
        let s3 = takes_and_gives_back(s2);
    }

    fn gives_ownership() -> String {
        let some_string = String::from("yours");
        some_string  // Returned and moves out
    }

    fn takes_and_gives_back(a_string: String) -> String {
        a_string  // Returned and moves out
    }
:::
