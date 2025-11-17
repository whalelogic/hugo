---
date: "2025-11-15T23:28:05-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- ruby
- symbols
- strings
- programming
title: Ruby Symbols and Strings
---
# Ruby Symbols and Strings {#ruby-symbols-and-strings .title}

Symbols and strings are both used to represent text in Ruby, but they
have different characteristics and use cases.

## Strings {#strings .subtitle}

Strings are mutable sequences of characters:

    # String creation
    str1 = "Hello"
    str2 = 'World'
    str3 = %q(Another way)
    str4 = %Q(With interpolation: #{str1})

    # String interpolation (only works with double quotes)
    name = "Alice"
    puts "Hello, #{name}!"

    # Multi-line strings
    multiline = <<-TEXT
      This is a
      multi-line
      string
    TEXT

    # String concatenation
    full_name = "John" + " " + "Doe"
    full_name << " Jr."  # Append in place

## Common String Methods {#common-string-methods .subtitle}

Ruby provides many useful string manipulation methods:

    str = "hello world"

    # Case manipulation
    str.upcase        # "HELLO WORLD"
    str.downcase      # "hello world"
    str.capitalize    # "Hello world"
    str.swapcase      # "HELLO WORLD"

    # Checking content
    str.include?("world")   # true
    str.start_with?("hello") # true
    str.end_with?("world")   # true
    str.empty?               # false

    # Transformations
    str.reverse       # "dlrow olleh"
    str.split         # ["hello", "world"]
    str.gsub("world", "ruby")  # "hello ruby"

    # Length and indexing
    str.length        # 11
    str[0]            # "h"
    str[0..4]         # "hello"
    str[-1]           # "d"

## Symbols {#symbols .subtitle}

Symbols are immutable, interned strings that start with a colon:

    # Symbol creation
    symbol1 = :name
    symbol2 = :email
    symbol3 = :"with spaces"

    # Symbols are unique - same symbol always has same object_id
    :name.object_id == :name.object_id  # true

    # Strings are not unique
    "name".object_id == "name".object_id  # false

## When to Use Symbols vs Strings {#when-to-use-symbols-vs-strings .subtitle}

Guidelines for choosing between symbols and strings:

    # Use symbols for:
    # - Hash keys
    person = { name: "Alice", age: 30, city: "NYC" }

    # - Method names and identifiers
    obj.send(:method_name)

    # - Constants that won't change
    STATUS_ACTIVE = :active
    STATUS_INACTIVE = :inactive

    # Use strings for:
    # - User input and output
    user_input = gets.chomp
    puts "Welcome, #{user_input}"

    # - Text that will be manipulated
    message = "Hello"
    message << ", World!"

    # - Data from external sources
    data = File.read("file.txt")

## Converting Between Symbols and Strings {#converting-between-symbols-and-strings .subtitle}

Easy conversion between the two types:

    # String to symbol
    "hello".to_sym    # :hello
    "hello".intern    # :hello

    # Symbol to string
    :hello.to_s       # "hello"
    :hello.id2name    # "hello"

    # Hash keys conversion
    hash = { "name" => "Alice", "age" => 30 }
    hash.transform_keys(&:to_sym)  # { name: "Alice", age: 30 }

## String Formatting {#string-formatting .subtitle}

Different ways to format strings in Ruby:

    # sprintf/format
    sprintf("Hello, %s", "World")
    "Hello, %s" % "World"

    # Multiple values
    "Name: %s, Age: %d" % ["Alice", 30]

    # Padding and alignment
    "%10s" % "hi"     # "        hi"
    "%-10s" % "hi"    # "hi        "
    "%05d" % 42       # "00042"

    # Floating point
    "%.2f" % 3.14159  # "3.14"

## String Encoding {#string-encoding .subtitle}

Ruby supports multiple character encodings:

    # Check encoding
    "hello".encoding  # #<Encoding:UTF-8>

    # Force encoding
    str = "café"
    str.encoding                     # UTF-8
    str.force_encoding("ASCII-8BIT")

    # Convert encoding
    str.encode("ISO-8859-1")