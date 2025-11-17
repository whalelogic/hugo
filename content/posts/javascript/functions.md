---
date: "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- javascript
- functions
- web-development
title: JavaScript Functions
---
# JavaScript Functions {#javascript-functions .title}

Functions are one of the fundamental building blocks in JavaScript. A
function is a reusable block of code that performs a specific task.

## Defining Functions {#defining-functions .subtitle}

There are several ways to define a function in JavaScript.

### Function Declaration {#function-declaration .subtitle}

    function greet(name) {
      return `Hello, ${name}!`;
    }
    console.log(greet("World"));

### Function Expression {#function-expression .subtitle}

    const greet = function(name) {
      return `Hello, ${name}!`;
    };
    console.log(greet("World"));

### Arrow Function {#arrow-function .subtitle}

Arrow functions provide a more concise syntax for writing functions.

    const greet = (name) => {
      return `Hello, ${name}!`;
    };
    console.log(greet("World"));

    // For single expression functions, you can omit the braces and return statement
    const add = (a, b) => a + b;
    console.log(add(2, 3)); // 5

## Function Parameters {#function-parameters .subtitle}

JavaScript functions can accept parameters. You can also define default
and rest parameters.

    // Default parameters
    function greet(name = "Guest") {
      console.log(`Hello, ${name}!`);
    }
    greet(); // "Hello, Guest!"
    greet("Alice"); // "Hello, Alice!"

    // Rest parameters
    function sum(...numbers) {
      return numbers.reduce((acc, current) => acc + current, 0);
    }
    console.log(sum(1, 2, 3)); // 6

## Higher-Order Functions {#higher-order-functions .subtitle}

Functions that operate on other functions, either by taking them as
arguments or by returning them, are called higher-order functions.

    function withLogging(fn) {
      return function(...args) {
        console.log(`Calling function ${fn.name}`);
        return fn(...args);
      };
    }

    function add(a, b) {
      return a + b;
    }

    const loggedAdd = withLogging(add);
    console.log(loggedAdd(3, 4));