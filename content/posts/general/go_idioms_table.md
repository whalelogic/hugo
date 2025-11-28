---
date: "2025-11-27T12:00:00-05:00"
author: "Keith Thomson"
categories:
  - "Programming"
  - "Go"
description: "An AI-generated table of advanced Go idioms and techniques for formatting, inspection, error handling, and more."
tags:
  - "go"
  - "idioms"
  - "table"
  - "reference"
title: "🥋 Advanced Go Idioms"
---

## Advanced Go Idioms Table

---

| Category | Idiom / Technique | Why It Matters | Example | Notes / Gotchas |
|---------|--------------------|----------------|---------|------------------|
| Formatting & Inspection | `%#v` Go-syntax dump | Produce copy-pasteable Go structs for debugging | `fmt.Printf("%#v
", cmd)` | Only prints exported fields |
| Formatting & Inspection | `%T` on interfaces | Reveals concrete runtime type | `fmt.Printf("%T
", x)` | Useful for debugging interface pollution |
| Formatting & Inspection | `fmt.Printf("%[1]T %[1]v
", v)` | Print type + value without repeating vars | Format indexing | Good for logging |
| Error Handling | `errors.Join` | Aggregate multiple errors | `return errors.Join(err1, err2)` | Useful in cleanup |
| Error Handling | Wrapping with `%w` | Preserve stackchain | `fmt.Errorf("failed: %w", err)` | Enables unwrapping |
| Context Usage | Context first argument | Idiomatic API design | `func Run(ctx context.Context)` | Signals lifecycle |
| Exec & Processes | `Cmd.Env = append(os.Environ(), ...)` | Correct env overrides | Same | Avoid wiping env |
| Concurrency | Context-aware goroutines | Avoid leaks | `go worker(ctx)` | Critical for servers |
| Concurrency | Buffered channel fan-in | Prevent producer blocking | `ch := make(chan T, n)` | Sizing matters |
| Performance | `strings.Builder` | Fast string concat | `var b strings.Builder` | Preferred method |
| Performance | Pre-size slices | Reduce reallocs | `make([]T, 0, n)` | Helps GC |
| Filesystems | `os.MkdirAll` | Idempotent | `os.MkdirAll(...)` | Safe |
| Networking | Reuse `http.Client` | Keep connection pools | same | Do not recreate |
| Testing | Table tests | Scalable | Common | Standard |
| Interfaces | Small boundaries | Decouple | `type Reader...` | Canonical rule |
| Generics | Numeric constraints | Expressive | `~int | ~float64` | Useful |
| String Handling | `strings.Cut` | Zero alloc | `Cut(s,"=")` | Prefer over Split |
| Time | UTC normalization | Consistency | `time.Now().UTC()` | Avoid bugs |
| Memory | Escape analysis | Performance | `go build -gcflags=-m` | Critical in loops |
| Tooling | `go vet` | Catch subtle bugs | run | Use in CI |

---
