---
date = "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
- Data Science
tags:
- python
- data-types
- programming
- data
- data-analysis
title: Python Data Types
---
# Python Data Types {#python-data-types .title}

Python has a wide variety of built-in data types. This section provides
an overview of the most common ones.

## Numeric Types {#numeric-types .subtitle}

Python has three distinct numeric types: integers, floating-point
numbers, and complex numbers.

    # Integers
    x = 10
    print(type(x))  # 

    # Floating-point numbers
    y = 3.14
    print(type(y))  # 

    # Complex numbers
    z = 1 + 2j
    print(type(z))  # 

## Sequence Types {#sequence-types .subtitle}

These represent ordered collections of items.

- **Strings (`str`):** Immutable sequences of Unicode characters.
- **Lists (`list`):** Mutable sequences, typically used to store
  collections of homogeneous items.
- **Tuples (`tuple`):** Immutable sequences, used to store collections
  of heterogeneous items.

<!-- -->

    # String
    my_string = "Hello, World!"
    print(my_string[7:])  # "World!"

    # List
    my_list = [1, 2, 3, "apple"]
    my_list.append(4)
    print(my_list)  # [1, 2, 3, 'apple', 4]

    # Tuple
    my_tuple = (1, "a", True)
    print(my_tuple[1])  # "a"

## Mapping Type {#mapping-type .subtitle}

The dictionary (`dict`) is a mutable, unordered collection of key-value
pairs.

    my_dict = {"name": "Alice", "age": 30}
    print(my_dict["name"])  # "Alice"
    my_dict["city"] = "New York"
    print(my_dict)  # {'name': 'Alice', 'age': 30, 'city': 'New York'}

## Set Types {#set-types .subtitle}

A set is an unordered collection of unique items.

- **Set (`set`):** Mutable, unordered collection of unique elements.
- **Frozenset (`frozenset`):** Immutable version of a set.

<!-- -->

    my_set = {1, 2, 3, 3, 4}
    print(my_set)  # {1, 2, 3, 4}
    my_set.add(5)
    print(my_set)  # {1, 2, 3, 4, 5}

## Boolean Type {#boolean-type .subtitle}

The boolean type (`bool`) has two possible values: `True` and `False`.

    is_active = True
    print(is_active)

    print(10 > 5)  # True