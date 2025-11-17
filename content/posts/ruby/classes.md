---
date: "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- ruby
- classes
- oop
- programming
title: Ruby Classes and Objects
---
# Ruby Classes and Objects {#ruby-classes-and-objects .title}

Ruby is a pure object-oriented language where everything is an object.
Classes are the blueprints for creating objects.

## Defining a Class {#defining-a-class .subtitle}

Use the class keyword to define a class:

    class Person
      def initialize(name, age)
        @name = name
        @age = age
      end
      
      def introduce
        puts "Hi, I'm #{@name} and I'm #{@age} years old."
      end
    end

    person = Person.new("Alice", 30)
    person.introduce

## Instance Variables {#instance-variables .subtitle}

Instance variables start with @ and belong to individual objects:

    class Dog
      def initialize(name)
        @name = name
        @energy = 100
      end
      
      def bark
        puts "#{@name} says Woof!"
        @energy -= 10
      end
      
      def energy_level
        puts "Energy: #{@energy}"
      end
    end

    dog = Dog.new("Buddy")
    dog.bark
    dog.energy_level

## Attribute Accessors {#attribute-accessors .subtitle}

Ruby provides shortcuts for getter and setter methods:

    class Person
      # Creates getter and setter methods
      attr_accessor :name, :age
      
      # Only getter
      attr_reader :id
      
      # Only setter
      attr_writer :password
      
      def initialize(name, age)
        @name = name
        @age = age
        @id = rand(1000)
      end
    end

    person = Person.new("Bob", 25)
    puts person.name  # Getter
    person.age = 26   # Setter

## Class Variables and Methods {#class-variables-and-methods .subtitle}

Shared across all instances of a class:

    class Counter
      @@count = 0
      
      def initialize
        @@count += 1
      end
      
      def self.count
        @@count
      end
      
      def self.reset
        @@count = 0
      end
    end

    Counter.new
    Counter.new
    puts Counter.count  # 2
    Counter.reset
    puts Counter.count  # 0

## Inheritance {#inheritance .subtitle}

Classes can inherit from other classes:

    class Animal
      def initialize(name)
        @name = name
      end
      
      def speak
        puts "#{@name} makes a sound"
      end
    end

    class Dog < Animal
      def speak
        puts "#{@name} barks"
      end
      
      def fetch
        puts "#{@name} fetches the ball"
      end
    end

    dog = Dog.new("Max")
    dog.speak
    dog.fetch

## Super Keyword {#super-keyword .subtitle}

Call the parent class\'s method:

    class Vehicle
      def initialize(wheels)
        @wheels = wheels
      end
      
      def info
        "This vehicle has #{@wheels} wheels"
      end
    end

    class Car < Vehicle
      def initialize(wheels, brand)
        super(wheels)
        @brand = brand
      end
      
      def info
        super + " and is a #{@brand}"
      end
    end

    car = Car.new(4, "Toyota")
    puts car.info

## Access Control {#access-control .subtitle}

Control method visibility with public, private, and protected:

    class BankAccount
      def initialize(balance)
        @balance = balance
      end
      
      # Public methods (default)
      def deposit(amount)
        @balance += amount
      end
      
      def withdraw(amount)
        return unless valid_amount?(amount)
        @balance -= amount
      end
      
      def balance
        @balance
      end
      
      private
      
      # Private methods - only accessible within the class
      def valid_amount?(amount)
        amount > 0 && amount <= @balance
      end
      
      protected
      
      # Protected methods - accessible within class and subclasses
      def transfer_to(other_account, amount)
        other_account.receive(amount)
      end
      
      def receive(amount)
        @balance += amount
      end
    end

## Modules and Mixins {#modules-and-mixins .subtitle}

Share functionality across classes using modules:

    module Swimmable
      def swim
        puts "#{self.class} is swimming"
      end
    end

    module Flyable
      def fly
        puts "#{self.class} is flying"
      end
    end

    class Duck
      include Swimmable
      include Flyable
    end

    duck = Duck.new
    duck.swim
    duck.fly