---
date: "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- typescript
- types
- web-development
title: TypeScript Types
---
# TypeScript Types {#typescript-types .title}

TypeScript extends JavaScript by adding types to the language. Types
provide a way to describe the shape of an object, providing better
documentation and allowing TypeScript to validate that your code is
working correctly.

## Basic Types {#basic-types .subtitle}

TypeScript supports several basic types including primitives and complex
types:

    // Primitives
    let isDone: boolean = false;
    let decimal: number = 6;
    let color: string = "blue";

    // Arrays
    let list: number[] = [1, 2, 3];
    let items: Array<number> = [1, 2, 3];

    // Tuple
    let tuple: [string, number] = ["hello", 10];

    // Enum
    enum Color { Red, Green, Blue }
    let c: Color = Color.Green;

    // Any - opts out of type checking
    let notSure: any = 4;
    notSure = "maybe a string";

    // Void - absence of any type
    function warn(): void {
      console.log("Warning!");
    }

    // Null and Undefined
    let u: undefined = undefined;
    let n: null = null;

    // Never - represents values that never occur
    function error(message: string): never {
      throw new Error(message);
    }

## Type Annotations {#type-annotations .subtitle}

You can add type annotations to variables, function parameters, and
return types:

    function greeter(person: string): string {
      return "Hello, " + person;
    }

    let user = "Jane";
    console.log(greeter(user));

## Type Inference {#type-inference .subtitle}

TypeScript can automatically infer types based on the assigned value:

    // Type is inferred as string
    let message = "Hello World";

    // Type is inferred as number
    let count = 42;

    // Type is inferred from return value
    function add(a: number, b: number) {
      return a + b; // returns number
    }

## Union Types {#union-types .subtitle}

A union type describes a value that can be one of several types:

    function printId(id: number | string) {
      console.log("Your ID is: " + id);
    }

    printId(101);
    printId("202");

    // Type narrowing
    function welcomePeople(x: string[] | string) {
      if (Array.isArray(x)) {
        console.log("Hello, " + x.join(" and "));
      } else {
        console.log("Welcome lone traveler " + x);
      }
    }

## Type Aliases {#type-aliases .subtitle}

Create custom type names for any type:

    type Point = {
      x: number;
      y: number;
    };

    type ID = number | string;

    function printCoord(pt: Point) {
      console.log("x: " + pt.x + ", y: " + pt.y);
    }

    let myId: ID = "abc123";