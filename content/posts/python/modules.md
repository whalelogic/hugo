---
date: "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- python
- modules
- packages
- programming
title: Python Modules
---
# Python Modules {#python-modules .title}

A module is a file containing Python definitions and statements. The
file name is the module name with the suffix `.py` appended. Modules
allow you to organize your code logically and reuse it in other
programs.

## Creating and Using Modules {#creating-and-using-modules .subtitle}

To create a module, you simply save the code you want in a file with a
`.py` extension.

**mymodule.py:**

    def greeting(name):
      print(f"Hello, {name}")

    person1 = {
      "name": "John",
      "age": 36,
      "country": "Norway"
    }

You can use the `import` statement to use the module in another program.

**main.py:**

    import mymodule

    mymodule.greeting("Jonathan")  # "Hello, Jonathan"

    a = mymodule.person1["age"]
    print(a)  # 36

## Importing From a Module {#importing-from-a-module .subtitle}

You can choose to import only specific parts from a module by using the
`from` keyword.

    from mymodule import person1

    print(person1["age"])  # 36

## The `__name__` Attribute {#the-__name__-attribute .subtitle}

The `__name__` attribute of a module is a special variable that is set
to "__main__" when the module is run as the main program, and to the
module\'s name when it is imported.

    # mymodule.py
    if __name__ == "__main__":
        print("This module is being run directly.")
    else:
        print("This module is being imported.")

This is often used to provide a command-line interface to a module.

## Packages {#packages .subtitle}

Packages are a way of structuring Python's module namespace by using
"dotted module names". A package is a directory of Python modules
containing an additional `__init__.py` file, which can be empty or can
execute initialization code for the package.