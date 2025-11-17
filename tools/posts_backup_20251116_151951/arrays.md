---
date = "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- javascript
- arrays
- data-structures
- web-development
title: JavaScript Arrays
---
# JavaScript Arrays {#javascript-arrays .title}

An array is a data structure that allows you to store multiple values in
a single variable. In JavaScript, arrays are versatile and can hold
elements of different data types.

## Creating Arrays {#creating-arrays .subtitle}

You can create an array using the array literal syntax `[]` or the
`Array` constructor.

    // Array literal
    let fruits = ["Apple", "Banana", "Cherry"];
    console.log(fruits);

    // Array constructor
    let numbers = new Array(1, 2, 3, 4, 5);
    console.log(numbers);

## Accessing Array Elements {#accessing-array-elements .subtitle}

Array elements are accessed using zero-based indices.

    let fruits = ["Apple", "Banana", "Cherry"];
    console.log(fruits[0]); // "Apple"
    console.log(fruits[1]); // "Banana"

## Common Array Methods {#common-array-methods .subtitle}

JavaScript provides a rich set of methods for working with arrays.

- `push()`: Adds one or more elements to the end of an array.
- `pop()`: Removes the last element from an array.
- `shift()`: Removes the first element from an array.
- `unshift()`: Adds one or more elements to the beginning of an array.
- `forEach()`: Executes a provided function once for each array element.
- `map()`: Creates a new array with the results of calling a provided
  function on every element.
- `filter()`: Creates a new array with all elements that pass the test
  implemented by the provided function.
- `reduce()`: Executes a reducer function on each element of the array,
  resulting in a single output value.

### Examples of Array Methods {#examples-of-array-methods .subtitle}

    let numbers = [1, 2, 3, 4, 5];

    // forEach
    numbers.forEach(num => {
      console.log(num * 2);
    });

    // map
    let doubled = numbers.map(num => num * 2);
    console.log(doubled); // [2, 4, 6, 8, 10]

    // filter
    let evenNumbers = numbers.filter(num => num % 2 === 0);
    console.log(evenNumbers); // [2, 4]

    // reduce
    let sum = numbers.reduce((accumulator, currentValue) => accumulator + currentValue, 0);
    console.log(sum); // 15