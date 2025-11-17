---
date = "2025-11-16T14:00:08-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- rust
- borrowing
- ownership
- programming
title: 🦀 Rust Borrowing
---
# Rust Borrowing {#rust-borrowing .title}

Borrowing allows you to have references to a value without taking
ownership. Rust\'s borrowing rules ensure memory safety at compile time.

## References and Borrowing {#references-and-borrowing .subtitle}

Use & to create a reference without taking ownership:

    fn main() {
        let s1 = String::from("hello");
        let len = calculate_length(&s1);  // Pass reference
        println!("The length of '{}' is {}.", s1, len);
    }

    fn calculate_length(s: &String) -> usize {
        s.len()
    } // s goes out of scope but doesn't drop what it refers to

## Mutable References {#mutable-references .subtitle}

Create mutable references with &mut:

    fn main() {
        let mut s = String::from("hello");
        change(&mut s);
        println!("{}", s);  // Prints "hello, world"
    }

    fn change(some_string: &mut String) {
        some_string.push_str(", world");
    }

## Borrowing Rules {#borrowing-rules .subtitle}

Rust enforces these rules at compile time:

- You can have either one mutable reference OR any number of immutable
  references
- References must always be valid

<!-- -->

    fn main() {
        let mut s = String::from("hello");
        
        // Only one mutable reference at a time
        let r1 = &mut s;
        // let r2 = &mut s;  // Error! Cannot borrow as mutable more than once
        
        println!("{}", r1);
    }

## Multiple Immutable References {#multiple-immutable-references .subtitle}

You can have multiple immutable references simultaneously:

    fn main() {
        let s = String::from("hello");
        
        let r1 = &s;  // OK
        let r2 = &s;  // OK
        // let r3 = &mut s;  // Error! Cannot have mutable ref while immutable refs exist
        
        println!("{} and {}", r1, r2);
    }

## Dangling References {#dangling-references .subtitle}

Rust prevents dangling references at compile time:

    fn main() {
        // let reference_to_nothing = dangle();  // Error!
    }

    // This won't compile
    fn dangle() -> &String {
        let s = String::from("hello");
        &s  // Error: returns a reference to data owned by this function
    } // s goes out of scope and is dropped

    // Solution: return the String directly
    fn no_dangle() -> String {
        let s = String::from("hello");
        s  // Ownership is moved out
    }

## Reference Scope {#reference-scope .subtitle}

A reference\'s scope starts from where it is introduced and continues
through the last time that reference is used:

    fn main() {
        let mut s = String::from("hello");

        let r1 = &s;
        let r2 = &s;
        println!("{} and {}", r1, r2);
        // r1 and r2 are no longer used after this point

        let r3 = &mut s;  // OK: no other references in scope
        println!("{}", r3);
    }
