# A Practical Guide to Regular Expressions in Go: Patterns, Pitfalls, and Power Techniques

Regular expressions remain one of the most versatile tools in a
developer's toolkit. They offer a concise, expressive language for
pattern matching, text extraction, validation, and transformation across
virtually every modern programming language. Go is no exception. Its
native `regexp` package provides a fast, safe, and capable regex engine
tailored for production systems.

Yet most developers under-utilize regex or rely on outdated patterns
borrowed from other languages without understanding how Go's engine
behaves. This guide distills the essentials: how regex works in Go, how
to use it effectively, and a complete cheat sheet for day-to-day pattern
construction.

## Why Regular Expressions Matter

Regex enables deterministic, declarative text processing. Instead of
manually stepping through strings with conditional logic, a single
expression can encode:

-   validation logic
-   tokenization
-   structural parsing
-   extraction of groups
-   replacement and transformation
-   data normalization

## The Go Regex Model

Go uses RE2 under the hood, a regex engine designed with a critical
constraint: no catastrophic backtracking. This design guarantees
linear-time operation for all patterns, solving a major performance and
security weakness found in PCRE-style engines.

Key implications:

-   Backreferences are not supported.
-   Lookaheads and lookbehinds are not supported.
-   Every regex runs in time proportional to input size.
-   Safe for production environments.

## Idiomatic Go Usage Patterns

### Compiled Regex

``` go
re := regexp.MustCompile(`\d{3}-\d{2}-\d{4}`)
if re.MatchString("123-45-6789") {
    fmt.Println("match")
}
```

### Runtime-Safe Compilation

``` go
re, err := regexp.Compile(pattern)
if err != nil {
    return err
}
```

### Matching and Extracting

``` go
matches := re.FindStringSubmatch("name=john age=29")
fmt.Println(matches)
```

### Replacing

``` go
result := re.ReplaceAllString("foo123bar", "***")
```

### Iterating Through Matches

``` go
for _, m := range re.FindAllString("abc123def456ghi", -1) {
    fmt.Println(m)
}
```

# Go Regex Cheat Sheet

## Character Classes

  Pattern    Meaning
  ---------- ------------------------------
  `.`        Any character except newline
  `[abc]`    a, b, or c
  `[^abc]`   Not a, b, or c
  `[a-z]`    Range a through z
  `\d`       Digit
  `\D`       Non-digit
  `\w`       Word char
  `\W`       Non-word
  `\s`       Whitespace
  `\S`       Non-whitespace

## Quantifiers

  Pattern    Meaning
  ---------- --------------
  `x*`       Zero or more
  `x+`       One or more
  `x?`       Zero or one
  `x{n}`     Exactly n
  `x{n,}`    n or more
  `x{n,m}`   n to m

Non-greedy versions: `*?`, `+?`, `??`, `{n,m}?`.

## Anchors

  Anchor   Meaning
  -------- ---------------
  `^`      Start
  `$`      End
  `\A`     Start of text
  `\z`     End of text

## Groups and Alternation

  Pattern     Meaning
  ----------- -------------
  `(abc)`     Capture
  `(?:abc)`   Non-capture
  `a|b`       Alternation

## Flags

  Flag     Meaning
  -------- ---------------------
  `(?i)`   Case-insensitive
  `(?m)`   Multiline
  `(?s)`   Dot matches newline

## Practical Examples

### Email Validation

``` go
re := regexp.MustCompile(`^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$`)
```

### Extract Numbers

``` go
re := regexp.MustCompile(`\b\d+\b`)
nums := re.FindAllString(logData, -1)
```

### Password Rules

``` go
re := regexp.MustCompile(`^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$])[A-Za-z\d@#$]{14}$`)
```

### Key=Value Parsing

``` go
re := regexp.MustCompile(`(\w+)=([^ ]+)`)
pairs := re.FindAllStringSubmatch("env=prod version=1.2.3 user=admin", -1)
```

## Common Pitfalls

-   Expecting PCRE features: backreferences, lookbehinds.
-   Overusing regex where simple string operations suffice.
-   Failing to reuse compiled patterns.

## Performance Guidance

-   Precompile patterns.
-   Benchmark regex against string functions for hot paths.
-   Minimize massive alternations.

## Closing Thoughts

Regular expressions remain a force multiplier in Go. Understanding RE2's
rules and leveraging idiomatic patterns will make text-heavy workloads
simpler, safer, and more efficient.
