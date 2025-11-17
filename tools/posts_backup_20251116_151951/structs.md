---
date = "2025-11-16T14:01:15-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- rust
- structs
- programming
title: 🦀 Rust Structs
---
# Rust Structs {#rust-structs .title}

Structs let you create custom types that group related data together.
They're similar to tuples, but each piece of data has a name.

## Defining Structs {#defining-structs .subtitle}

Define a struct using the struct keyword:

    struct User {
        active: bool,
        username: String,
        email: String,
        sign_in_count: u64,
    }

    fn main() {
        let user1 = User {
            email: String::from("someone@example.com"),
            username: String::from("someusername123"),
            active: true,
            sign_in_count: 1,
        };
        
        println!("User email: {}", user1.email);
    }

## Mutable Structs {#mutable-structs .subtitle}

The entire struct must be mutable to change fields:

    fn main() {
        let mut user1 = User {
            email: String::from("someone@example.com"),
            username: String::from("someusername123"),
            active: true,
            sign_in_count: 1,
        };
        
        user1.email = String::from("anotheremail@example.com");
    }

## Struct Update Syntax {#struct-update-syntax .subtitle}

Create instances from other instances:

    fn main() {
        let user1 = User {
            email: String::from("someone@example.com"),
            username: String::from("someusername123"),
            active: true,
            sign_in_count: 1,
        };
        
        let user2 = User {
            email: String::from("another@example.com"),
            ..user1  // Use remaining fields from user1
        };
    }

## Tuple Structs {#tuple-structs .subtitle}

Structs without named fields:

    struct Color(i32, i32, i32);
    struct Point(i32, i32, i32);

    fn main() {
        let black = Color(0, 0, 0);
        let origin = Point(0, 0, 0);
        
        println!("First color value: {}", black.0);
    }

## Unit-Like Structs {#unit-like-structs .subtitle}

Structs without any fields:

    struct AlwaysEqual;

    fn main() {
        let subject = AlwaysEqual;
    }

## Method Syntax {#method-syntax .subtitle}

Define methods within an impl block:

    struct Rectangle {
        width: u32,
        height: u32,
    }

    impl Rectangle {
        fn area(&self) -> u32 {
            self.width * self.height
        }
        
        fn can_hold(&self, other: &Rectangle) -> bool {
            self.width > other.width && self.height > other.height
        }
    }

    fn main() {
        let rect1 = Rectangle {
            width: 30,
            height: 50,
        };
        
        println!("Area: {}", rect1.area());
    }

## Associated Functions {#associated-functions .subtitle}

Functions that don't take self as a parameter:

    impl Rectangle {
        fn square(size: u32) -> Rectangle {
            Rectangle {
                width: size,
                height: size,
            }
        }
    }

    fn main() {
        let sq = Rectangle::square(3);
    }
