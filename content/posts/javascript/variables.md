---
date: "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- javascript
- variables
- es6
- web-development
title: JavaScript Variables
---
# JavaScript Variables {#javascript-variables .title}

Variables are containers for storing data values. In JavaScript, you can
declare variables using `var`, `let`, or `const`.

## `var` {#var .subtitle}

The `var` keyword has been in JavaScript since the beginning. Variables
declared with `var` are function-scoped or globally-scoped, but not
block-scoped.

    var name = "John Doe";
    function showName() {
      var name = "Jane Doe";
      console.log(name); // "Jane Doe"
    }
    showName();
    console.log(name); // "John Doe"

## `let` {#let .subtitle}

The `let` keyword, introduced in ES6, allows you to declare block-scoped
variables. This is generally preferred over `var`.

    let x = 10;
    if (true) {
      let x = 20;
      console.log(x); // 20
    }
    console.log(x); // 10

## `const` {#const .subtitle}

The `const` keyword is also block-scoped, but it's used for variables
that shouldn't be reassigned. The value of a `const` variable cannot be
changed, but if the variable is an object or array, its properties or
elements can be modified.

    const PI = 3.14;
    // PI = 3.14159; // This will cause an error

    const person = { name: "John" };
    person.name = "Jane"; // This is allowed
    console.log(person.name); // "Jane"

## Data Types {#data-types .subtitle}

JavaScript has several primitive data types:

- **String:** Represents textual data.
- **Number:** Represents both integer and floating-point numbers.
- **Boolean:** Represents `true` or `false`.
- **Null:** Represents the intentional absence of any object value.
- **Undefined:** Represents a variable that has been declared but not
  assigned a value.
- **Symbol:** A unique and immutable primitive value.
- **BigInt:** Represents integers with arbitrary precision.

JavaScript also has a complex data type, **Object**, which is used to
store collections of data.