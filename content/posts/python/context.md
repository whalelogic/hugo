---
date: "2025-11-16T14:08:00-05:00"
author: Keith Thomson
categories:
- Programming
tags:
- python
- context-managers
- with-statement
- programming
title: 🐍 Context Managers in Python
---
# Context Managers in Python {#context-managers-in-python .title}

Context managers allow you to allocate and release resources precisely
when you want to. The most common use is with the `with` statement.

## The with Statement {#the-with-statement .subtitle}

Automatically handle resource cleanup:

    # Without context manager
    file = open('example.txt', 'r')
    try:
        content = file.read()
        print(content)
    finally:
        file.close()

    # With context manager
    with open('example.txt', 'r') as file:
        content = file.read()
        print(content)
    # File is automatically closed

## Creating Context Managers with Classes {#creating-context-managers-with-classes .subtitle}

Implement __enter__ and __exit__ methods:

    class DatabaseConnection:
        def __init__(self, host, port):
            self.host = host
            self.port = port
            self.connection = None
        
        def __enter__(self):
            print(f"Connecting to {self.host}:{self.port}")
            self.connection = self._create_connection()
            return self.connection
        
        def __exit__(self, exc_type, exc_val, exc_tb):
            print("Closing connection")
            if self.connection:
                self.connection.close()
            
            # Return False to propagate exceptions
            # Return True to suppress exceptions
            return False
        
        def _create_connection(self):
            # Simulate connection creation
            return {"status": "connected"}

    # Usage
    with DatabaseConnection('localhost', 5432) as conn:
        print(f"Connection status: {conn['status']}")

## Using contextlib {#using-contextlib .subtitle}

Create context managers with the contextlib module:

    from contextlib import contextmanager

    @contextmanager
    def file_manager(filename, mode):
        print(f"Opening {filename}")
        file = open(filename, mode)
        try:
            yield file
        finally:
            print(f"Closing {filename}")
            file.close()

    # Usage
    with file_manager('test.txt', 'w') as f:
        f.write('Hello, World!')

    # Timer context manager
    import time

    @contextmanager
    def timer(label):
        start = time.time()
        try:
            yield
        finally:
            end = time.time()
            print(f"{label}: {end - start:.2f} seconds")

    with timer("Download"):
        # Simulate work
        time.sleep(2)

## Multiple Context Managers {#multiple-context-managers .subtitle}

Handle multiple resources in one statement:

    # Multiple with statements (old way)
    with open('input.txt', 'r') as infile:
        with open('output.txt', 'w') as outfile:
            outfile.write(infile.read())

    # Multiple managers in one statement (Python 3+)
    with open('input.txt', 'r') as infile, \
         open('output.txt', 'w') as outfile:
        outfile.write(infile.read())

    # Using contextlib.ExitStack
    from contextlib import ExitStack

    def process_files(filenames):
        with ExitStack() as stack:
            files = [stack.enter_context(open(fname)) for fname in filenames]
            # All files are automatically closed when exiting
            for f in files:
                print(f.read())

## Exception Handling {#exception-handling .subtitle}

Context managers can handle exceptions:

    class ErrorHandler:
        def __enter__(self):
            return self
        
        def __exit__(self, exc_type, exc_val, exc_tb):
            if exc_type is None:
                print("No errors occurred")
                return False
            
            if exc_type == ValueError:
                print(f"Handled ValueError: {exc_val}")
                return True  # Suppress the exception
            
            # Let other exceptions propagate
            return False

    # Usage
    with ErrorHandler():
        raise ValueError("This will be suppressed")
        print("This won't print")

    print("Execution continues")

## Async Context Managers {#async-context-managers .subtitle}

Context managers for async code:

    class AsyncDatabaseConnection:
        async def __aenter__(self):
            print("Connecting asynchronously")
            # await actual connection
            return self
        
        async def __aexit__(self, exc_type, exc_val, exc_tb):
            print("Disconnecting asynchronously")
            # await actual disconnection
            return False

    # Usage with async/await
    async def main():
        async with AsyncDatabaseConnection() as conn:
            # Do async work
            pass

    # Using contextlib for async
    from contextlib import asynccontextmanager

    @asynccontextmanager
    async def async_timer(label):
        import asyncio
        start = asyncio.get_event_loop().time()
        try:
            yield
        finally:
            end = asyncio.get_event_loop().time()
            print(f"{label}: {end - start:.2f} seconds")

    async def example():
        async with async_timer("Operation"):
            await asyncio.sleep(1)

## Common Use Cases {#common-use-cases .subtitle}

Practical applications of context managers:

    # 1. Lock management
    from threading import Lock

    lock = Lock()
    with lock:
        # Critical section
        pass

    # 2. Directory changes
    import os
    from contextlib import contextmanager

    @contextmanager
    def change_dir(path):
        old_dir = os.getcwd()
        os.chdir(path)
        try:
            yield
        finally:
            os.chdir(old_dir)

    with change_dir('/tmp'):
        # Work in /tmp
        pass
    # Back to original directory

    # 3. Temporary environment variables
    @contextmanager
    def temp_env_var(key, value):
        old_value = os.environ.get(key)
        os.environ[key] = value
        try:
            yield
        finally:
            if old_value is None:
                del os.environ[key]
            else:
                os.environ[key] = old_value

    # 4. Database transactions
    @contextmanager
    def transaction(connection):
        connection.begin()
        try:
            yield connection
            connection.commit()
        except Exception:
            connection.rollback()
            raise

    with transaction(db_connection) as conn:
        conn.execute("INSERT INTO ...")
