---
date: "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- python
- functions
- programming
title: Python Functions
---
# Python Functions {#python-functions .title}

A function is a block of organized, reusable code that is used to
perform a single, related action. Functions provide better modularity
for your application and a high degree of code reusing.

## Defining a Function {#defining-a-function .subtitle}

You can define a function using the `def` keyword.

    def greet(name):
        """This function greets the person passed in as a parameter."""
        print(f"Hello, {name}!")

    # Calling the function
    greet("Alice")  # "Hello, Alice!"

## Arguments {#arguments .subtitle}

Information can be passed into functions as arguments. Arguments are
specified after the function name, inside the parentheses.

### Positional and Keyword Arguments {#positional-and-keyword-arguments .subtitle}

    def describe_pet(animal_type, pet_name):
        """Display information about a pet."""
        print(f"I have a {animal_type}.")
        print(f"My {animal_type}'s name is {pet_name.title()}.")

    # Positional arguments
    describe_pet("hamster", "harry")

    # Keyword arguments
    describe_pet(pet_name="willie", animal_type="dog")

### Default Arguments {#default-arguments .subtitle}

    def describe_pet(pet_name, animal_type="dog"):
        """Display information about a pet with a default animal type."""
        print(f"I have a {animal_type}.")
        print(f"My {animal_type}'s name is {pet_name.title()}.")

    describe_pet("willie")  # Uses the default animal_type "dog"

### Arbitrary Arguments {#arbitrary-arguments .subtitle}

If you do not know how many arguments will be passed into your function,
you can use `*args` for non-keyword arguments and `**kwargs` for keyword
arguments.

    def make_pizza(*toppings):
        """Print the list of toppings that have been requested."""
        print(toppings)

    make_pizza("pepperoni")
    make_pizza("mushrooms", "green peppers", "extra cheese")

    def build_profile(first, last, **user_info):
        """Build a dictionary containing everything we know about a user."""
        profile = {"first_name": first, "last_name": last}
        for key, value in user_info.items():
            profile[key] = value
        return profile

    user_profile = build_profile("albert", "einstein",
                                 location="princeton",
                                 field="physics")
    print(user_profile)

## Lambda Functions {#lambda-functions .subtitle}

A lambda function is a small anonymous function. A lambda function can
take any number of arguments, but can only have one expression.

    # A lambda function that adds 10 to the number passed in as an argument
    x = lambda a: a + 10
    print(x(5))  # 15

    # A lambda function that multiplies two arguments
    multiply = lambda x, y: x * y
    print(multiply(5, 6))  # 30