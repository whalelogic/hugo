---
date: "2025-11-16T14:13:41-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- javascript
- promises
- async
- web-development
title: 🏺 JavaScript Promises
---
# JavaScript Promises {#javascript-promises .title}

A Promise is an object representing the eventual completion or failure
of an asynchronous operation. Promises are a core feature of modern
JavaScript for handling async code.

## Creating a Promise {#creating-a-promise .subtitle}

You can create a promise using the `Promise` constructor, which takes a
function (the "executor") as an argument. The executor itself takes
two functions as arguments: `resolve` and `reject`.

    const myPromise = new Promise((resolve, reject) => {
      // Asynchronous operation
      setTimeout(() => {
        const success = true;
        if (success) {
          resolve("The operation was successful!");
        } else {
          reject("The operation failed.");
        }
      }, 1000);
    });

## Consuming a Promise {#consuming-a-promise .subtitle}

You can consume a promise using the `then()`, `catch()`, and `finally()`
methods.

    myPromise
      .then(result => {
        console.log(result); // "The operation was successful!"
      })
      .catch(error => {
        console.error(error); // "The operation failed."
      })
      .finally(() => {
        console.log("Promise finished.");
      });

## Async/Await {#asyncawait .subtitle}

`async/await` is syntactic sugar built on top of promises, making
asynchronous code look and behave more like synchronous code.

    async function fetchData() {
      try {
        const response = await fetch('https://api.example.com/data');
        const data = await response.json();
        console.log(data);
      } catch (error) {
        console.error("Failed to fetch data:", error);
      }
    }

    fetchData();

An `async` function always returns a promise. If the function returns a
value, the promise will be resolved with that value. If the function
throws an exception, the promise will be rejected with that exception.

## Promise Chaining {#promise-chaining .subtitle}

You can chain promises to execute asynchronous operations in sequence.

    fetch('https://api.example.com/users/1')
      .then(response => response.json())
      .then(user => fetch(`https://api.example.com/users/${user.id}/posts`))
      .then(response => response.json())
      .then(posts => {
        console.log(posts);
      })
      .catch(error => {
        console.error("Error fetching data:", error);
      });
