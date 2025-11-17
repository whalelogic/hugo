---
date: "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- typescript
- generics
- web-development
title: TypeScript Generics
---
# TypeScript Generics {#typescript-generics .title}

Generics allow you to create reusable components that can work with a
variety of types rather than a single one. This allows users to consume
these components and use their own types.

## Generic Functions {#generic-functions .subtitle}

Create a function that works with any type:

    function identity<T>(arg: T): T {
      return arg;
    }

    let output1 = identity<string>("myString");
    let output2 = identity<number>(42);

    // Type argument inference
    let output3 = identity("hello"); // Type inferred as string

## Generic Interfaces {#generic-interfaces .subtitle}

Define interfaces that use type parameters:

    interface GenericIdentityFn<T> {
      (arg: T): T;
    }

    let myIdentity: GenericIdentityFn<number> = identity;
    myIdentity(123);

## Generic Classes {#generic-classes .subtitle}

Create classes that work with multiple types:

    class GenericNumber<T> {
      zeroValue: T;
      add: (x: T, y: T) => T;
    }

    let myGenericNumber = new GenericNumber<number>();
    myGenericNumber.zeroValue = 0;
    myGenericNumber.add = function(x, y) { return x + y; };

    let stringNumeric = new GenericNumber<string>();
    stringNumeric.zeroValue = "";
    stringNumeric.add = function(x, y) { return x + y; };

## Generic Constraints {#generic-constraints .subtitle}

Restrict generics to types that have certain properties:

    interface Lengthwise {
      length: number;
    }

    function loggingIdentity<T extends Lengthwise>(arg: T): T {
      console.log(arg.length); // Now we know it has a .length property
      return arg;
    }

    loggingIdentity({ length: 10, value: 3 });
    // loggingIdentity(3); // Error: number doesn't have .length

## Using Type Parameters in Constraints {#using-type-parameters-in-constraints .subtitle}

Declare a type parameter that is constrained by another type parameter:

    function getProperty<T, K extends keyof T>(obj: T, key: K) {
      return obj[key];
    }

    let x = { a: 1, b: 2, c: 3, d: 4 };
    getProperty(x, "a");
    // getProperty(x, "m"); // Error: Argument of type 'm' isn't assignable