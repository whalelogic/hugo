---
date: "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- python
- classes
- oop
- programming
title: Python Classes
---
# Python Classes {#python-classes .title}

Classes provide a means of bundling data and functionality together.
Creating a new class creates a new type of object, allowing new
instances of that type to be made.

## Defining a Class {#defining-a-class .subtitle}

You can define a class using the `class` keyword.

    class Dog:
        # Class attribute
        species = "Canis familiaris"

        # Initializer / Instance attributes
        def __init__(self, name, age):
            self.name = name
            self.age = age

        # Instance method
        def description(self):
            return f"{self.name} is {self.age} years old"

        # Another instance method
        def speak(self, sound):
            return f"{self.name} says {sound}"

## Creating an Instance {#creating-an-instance .subtitle}

To create an instance of a class, you call the class as if it were a
function.

    # Create an instance of the Dog class
    my_dog = Dog("Buddy", 5)

    # Access instance attributes
    print(my_dog.name)  # Buddy
    print(my_dog.age)   # 5

    # Call instance methods
    print(my_dog.description())  # Buddy is 5 years old
    print(my_dog.speak("Woof"))  # Buddy says Woof

## Inheritance {#inheritance .subtitle}

Inheritance allows you to create a new class that inherits the
attributes and methods of an existing class.

    class Bulldog(Dog):
        def speak(self, sound="Arf"):
            return f"{self.name} says {sound}"

    my_bulldog = Bulldog("Rocky", 3)
    print(my_bulldog.description())  # Rocky is 3 years old
    print(my_bulldog.speak())        # Rocky says Arf

## Special Methods {#special-methods .subtitle}

Classes in Python can implement special methods (also known as
"dunder" methods) that begin and end with double underscores. These
methods allow you to customize the behavior of your objects.

- `__init__`: The constructor for the class.
- `__str__`: Returns a string representation of the object.
- `__len__`: Returns the length of the object.
- `__repr__`: Returns an official string representation of the object.

<!-- -->

    class Car:
        def __init__(self, make, model):
            self.make = make
            self.model = model

        def __str__(self):
            return f"A {self.make} {self.model}"

    my_car = Car("Toyota", "Corolla")
    print(my_car)  # A Toyota Corolla