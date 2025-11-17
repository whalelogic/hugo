---
date: "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- typescript
- interfaces
- web-development
title: TypeScript Interfaces
---
# TypeScript Interfaces {#typescript-interfaces .title}

Interfaces in TypeScript are a powerful way to define contracts within
your code and contracts with code outside of your project. They describe
the shape of objects.

## Basic Interface {#basic-interface .subtitle}

Define the structure of an object:

    interface User {
      name: string;
      age: number;
    }

    function greet(user: User) {
      console.log(`Hello, ${user.name}!`);
    }

    let myUser: User = { name: "Alice", age: 30 };
    greet(myUser);

## Optional Properties {#optional-properties .subtitle}

Some properties may not be required:

    interface Config {
      color?: string;
      width?: number;
    }

    function createSquare(config: Config) {
      let newSquare = { color: "white", area: 100 };
      if (config.color) {
        newSquare.color = config.color;
      }
      if (config.width) {
        newSquare.area = config.width * config.width;
      }
      return newSquare;
    }

    let mySquare = createSquare({ color: "black" });

## Readonly Properties {#readonly-properties .subtitle}

Properties that can only be modified when an object is first created:

    interface Point {
      readonly x: number;
      readonly y: number;
    }

    let p1: Point = { x: 10, y: 20 };
    // p1.x = 5; // Error: Cannot assign to 'x' because it is a read-only property

## Function Types {#function-types .subtitle}

Interfaces can describe function types:

    interface SearchFunc {
      (source: string, subString: string): boolean;
    }

    let mySearch: SearchFunc;
    mySearch = function(src: string, sub: string): boolean {
      let result = src.search(sub);
      return result > -1;
    };

## Extending Interfaces {#extending-interfaces .subtitle}

Interfaces can extend one or more other interfaces:

    interface Shape {
      color: string;
    }

    interface Square extends Shape {
      sideLength: number;
    }

    let square: Square = {
      color: "blue",
      sideLength: 10
    };

    // Multiple inheritance
    interface PenStroke {
      penWidth: number;
    }

    interface ColoredSquare extends Shape, PenStroke {
      sideLength: number;
    }

    let coloredSquare: ColoredSquare = {
      color: "red",
      sideLength: 20,
      penWidth: 5
    };

## Class Interfaces {#class-interfaces .subtitle}

Use interfaces to define contracts for classes:

    interface ClockInterface {
      currentTime: Date;
      setTime(d: Date): void;
    }

    class Clock implements ClockInterface {
      currentTime: Date = new Date();
      
      setTime(d: Date) {
        this.currentTime = d;
      }
      
      constructor(h: number, m: number) { }
    }