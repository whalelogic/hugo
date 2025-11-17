---
date: "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- python
- exceptions
- error-handling
- programming
title: Python Exceptions
---
# Python Exceptions {#python-exceptions .title}

Exceptions are events that occur during the execution of a program that
disrupt the normal flow of instructions. In Python, exceptions are
handled using `try...except` blocks.

## Handling Exceptions {#handling-exceptions .subtitle}

You can use a `try...except` block to catch and handle exceptions. The
code that might raise an exception is placed in the `try` block, and the
code to handle the exception is placed in the `except` block.

    try:
        result = 10 / 0
    except ZeroDivisionError:
        print("You can't divide by zero!")

## The `else` and `finally` Clauses {#the-else-and-finally-clauses .subtitle}

You can also include `else` and `finally` clauses in a `try...except`
block.

- The `else` block is executed if no exceptions are raised in the `try`
  block.
- The `finally` block is always executed, regardless of whether an
  exception was raised.

<!-- -->

    try:
        num = int(input("Enter a number: "))
    except ValueError:
        print("That's not a valid number!")
    else:
        print(f"You entered {num}")
    finally:
        print("Execution complete.")

## Raising Exceptions {#raising-exceptions .subtitle}

You can raise exceptions in your own code using the `raise` keyword.
This is useful when you want to signal that an error has occurred.

    def validate_age(age):
        if age < 0:
            raise ValueError("Age cannot be negative")
        return True

    try:
        validate_age(-5)
    except ValueError as e:
        print(e)  # "Age cannot be negative"

## Common Built-in Exceptions {#common-built-in-exceptions .subtitle}

Python has a number of built-in exceptions that are commonly raised:

- `TypeError`: Raised when an operation or function is applied to an
  object of inappropriate type.
- `ValueError`: Raised when a built-in operation or function receives an
  argument that has the right type but an inappropriate value.
- `IndexError`: Raised when a sequence subscript is out of range.
- `KeyError`: Raised when a dictionary key is not found.
- `FileNotFoundError`: Raised when a file or directory is requested but
  doesn't exist.