---
date = "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- javascript
- objects
- data-structures
- web-development
title: JavaScript Objects
---
# JavaScript Objects {#javascript-objects .title}

An object is a collection of key-value pairs. In JavaScript, objects are
used to represent complex data structures and are a fundamental part of
the language.

## Creating Objects {#creating-objects .subtitle}

You can create an object using object literal syntax `{}` or the
`Object` constructor.

    // Object literal
    let person = {
      firstName: "John",
      lastName: "Doe",
      age: 30
    };
    console.log(person);

    // Object constructor
    let car = new Object();
    car.make = "Toyota";
    car.model = "Camry";
    console.log(car);

## Accessing Properties {#accessing-properties .subtitle}

You can access object properties using dot notation or bracket notation.

    let person = {
      firstName: "John",
      lastName: "Doe"
    };

    // Dot notation
    console.log(person.firstName); // "John"

    // Bracket notation
    console.log(person["lastName"]); // "Doe"

## Object Methods {#object-methods .subtitle}

An object can have methods, which are functions stored as object
properties.

    let person = {
      firstName: "John",
      lastName: "Doe",
      greet: function() {
        console.log(`Hello, my name is ${this.firstName} ${this.lastName}`);
      }
    };

    person.greet(); // "Hello, my name is John Doe"

## The `this` Keyword {#the-this-keyword .subtitle}

In an object method, `this` refers to the object itself. The value of
`this` can change depending on how the function is called.

## Object Destructuring {#object-destructuring .subtitle}

Destructuring makes it easy to extract properties from objects.

    let person = {
      firstName: "John",
      lastName: "Doe",
      age: 30
    };

    const { firstName, age } = person;
    console.log(firstName); // "John"
    console.log(age); // 30