---
date = "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- ruby
- blocks
- procs
- lambdas
- programming
title: Ruby Blocks and Procs
---
# Ruby Blocks and Procs {#ruby-blocks-and-procs .title}

Blocks, Procs, and Lambdas are powerful features in Ruby that allow you
to group code into reusable chunks and pass them around your program.

## Blocks {#blocks .subtitle}

Blocks are chunks of code enclosed between do\...end or curly braces:

    # Block with do...end
    [1, 2, 3].each do |num|
      puts num * 2
    end

    # Block with curly braces
    [1, 2, 3].each { |num| puts num * 2 }

    # Using yield to call a block
    def greet
      puts "Before yield"
      yield
      puts "After yield"
    end

    greet { puts "Hello from the block!" }

## Block Parameters {#block-parameters .subtitle}

Pass parameters to blocks:

    def repeat(n)
      n.times { |i| yield(i) }
    end

    repeat(3) { |num| puts "Iteration #{num}" }

    # Multiple parameters
    def test_block
      yield(1, 2)
    end

    test_block { |a, b| puts "a: #{a}, b: #{b}" }

## Procs {#procs .subtitle}

Procs are objects that contain blocks of code:

    # Creating a Proc
    square = Proc.new { |x| x ** 2 }

    puts square.call(5)  # 25

    # Procs as method parameters
    def run_proc(p)
      p.call
    end

    my_proc = Proc.new { puts "Hello from Proc!" }
    run_proc(my_proc)

## Lambdas {#lambdas .subtitle}

Lambdas are similar to Procs but with subtle differences:

    # Creating a lambda
    multiply = lambda { |x, y| x * y }
    # or using stabby lambda syntax
    multiply = ->(x, y) { x * y }

    puts multiply.call(3, 4)  # 12

    # Lambdas check argument count
    add = lambda { |a, b| a + b }
    # add.call(1)  # Error: wrong number of arguments

## Proc vs Lambda Differences {#proc-vs-lambda-differences .subtitle}

Key differences between Procs and Lambdas:

    # 1. Argument checking
    my_proc = Proc.new { |x, y| puts "x: #{x}, y: #{y}" }
    my_proc.call(1)  # Works: x: 1, y: (nil)

    my_lambda = lambda { |x, y| puts "x: #{x}, y: #{y}" }
    # my_lambda.call(1)  # Error!

    # 2. Return behavior
    def proc_return
      my_proc = Proc.new { return "from proc" }
      my_proc.call
      "from method"  # Never reached
    end

    def lambda_return
      my_lambda = lambda { return "from lambda" }
      my_lambda.call
      "from method"  # This is returned
    end

    puts proc_return    # "from proc"
    puts lambda_return  # "from method"

## Common Block Methods {#common-block-methods .subtitle}

Ruby provides many useful methods that accept blocks:

    # map/collect - transform elements
    squares = [1, 2, 3].map { |n| n ** 2 }

    # select/filter - filter elements
    evens = [1, 2, 3, 4].select { |n| n.even? }

    # reduce/inject - accumulate values
    sum = [1, 2, 3, 4].reduce(0) { |acc, n| acc + n }

    # each_with_index
    %w[a b c].each_with_index do |letter, index|
      puts "#{index}: #{letter}"
    end

## Block Methods {#block-methods .subtitle}

Check if a block was given and handle it:

    def optional_block
      if block_given?
        yield
      else
        puts "No block provided"
      end
    end

    optional_block { puts "Block!" }
    optional_block