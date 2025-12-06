# Go Regex Cheat Sheet (RE2)

### Go Standard Library: *Package: `regexp`* 

> Regular expressions provide a highly expressive pattern-matching language that, when applied correctly, becomes one of the most efficient tools for text processing, validation, and data extraction. Most programming languages implement broadly compatible regex engines, enabling developers to reuse core pattern syntax across different tech stacks with minimal adjustment.

## 1. The Golden Rule
Always use **Raw Strings** (backticks) for regex patterns to avoid double-escaping backslashes.
* ❌ Bad: `"^\\d+\\.\\d+$"`
* ✅ Good: `` `^\d+\.\d+$` ``

## 2. Compiling
| Method | Usage |
| :--- | :--- |
| `regexp.MustCompile(str)` | **Use this 99% of the time.** Panics on bad syntax. Safe for global variables. |
| `regexp.Compile(str)` | Returns `(regex, error)`. Use only if pattern is user-provided (dynamic). |

## 3. Syntax Reference

### Anchors & Boundaries
| Symbol | Meaning |
| :--- | :--- |
| `^` | Start of text (or start of line if `(?m)` flag is set). |
| `$` | End of text (or end of line if `(?m)` flag is set). |
| `\A` | absolute Start of text (ignores `(?m)`). |
| `\z` | Absolute End of text (ignores `(?m)`). |
| `\b` | ASCII Word boundary. |
| `\B` | Not a word boundary. |

### Character Classes
| Symbol | Meaning |
| :--- | :--- |
| `.` | Any character (EXCEPT newline, unless `(?s)` is set). |
| `[abc]` | Character set: a, b, or c. |
| `[^abc]` | Negated set: anything EXCEPT a, b, or c. |
| `\d` | Digits `[0-9]`. |
| `\D` | Non-digits. |
| `\w` | Word characters `[0-9A-Za-z_]`. |
| `\W` | Non-word characters. |
| `\s` | Whitespace `[\t\n\f\r ]`. |
| `\S` | Non-whitespace. |

### Quantifiers (Greedy vs Non-Greedy)
| Greedy | Non-Greedy (Lazy) | Description |
| :--- | :---: | :--- |
| `*` | `*?` | 0 or more. |
| `+` | `+?` | 1 or more. |
| `?` | `??` | 0 or 1. |
| `{n}` | | Exactly n times. |
| `{n,}` | `{n,}?` | n or more times. |
| `{n,m}` | `{n,m}?` | Between n and m times. |

### Groups & Flags
| Syntax | Description |
| :--- | :--- |
| `(re)` | Capturing group. |
| `(?:re)` | Non-capturing group (faster). |
| `(?P<name>re)` | Named capturing group. |
| `(?i)` | Case-insensitive (flag). |
| `(?m)` | Multi-line mode (`^` and `$` match lines). |
| `(?s)` | Dot matches newline (flag). |
| `(?U)` | Ungreedy (swaps meaning of `*` and `*?`). |

---

## 4. Go Methods Cheat Sheet
Assume `r` is a compiled `*regexp.Regexp`.

### Checking & Finding
| Method | Returns | Description |
| :--- | :--- | :--- |
| `r.MatchString(s)` | `bool` | True if the pattern exists in string. |
| `r.FindString(s)` | `string` | Returns the **first** match text (or empty). |
| `r.FindAllString(s, n)` | `[]string` | Returns all matches. Set `n` to `-1` for all. |
| `r.FindStringIndex(s)` | `[]int` | Returns `[start, end]` index of first match. |

### Submatches (Capture Groups)
*Assuming pattern: `Email: (.+)`*
| Method | Returns | Description |
| :--- | :--- | :--- |
| `r.FindStringSubmatch(s)` | `[]string` | Slice containing full match at `[0]`, group 1 at `[1]`, etc. |
| `r.FindAllStringSubmatch(s, -1)`| `[][]string` | Slice of slices (all matches + all groups). |

### Replacements
| Method | Usage |
| :--- | :--- |
| `r.ReplaceAllString(src, repl)` | Replaces all matches with `repl`. Use `$1` for group 1. |
| `r.ReplaceAllLiteralString(...)`| Replaces matches with `repl`, ignoring `$` expansion. |
| `r.ReplaceAllStringFunc(src, fn)`| Passes match to `fn(string) string` for dynamic logic. |

### Splitting
| Method | Usage |
| :--- | :--- |
| `r.Split(s, n)` | Splits string by the separator defined in regex. `-1` for all. |

---

## 5. Performance Tips
1.  **Compile Once:** Never call `MustCompile` inside a loop or a hot function. Compile it as a global package variable (`var regex = ...`).
2.  **Bytes vs Strings:** If performance is critical, use the `[]byte` versions of the methods (`Match`, `Find`, `FindSubmatch`) to avoid string allocation overhead.
    * `r.Match([]byte("..."))`
3.  **Prefix Optimization:** RE2 optimizes queries that have a static prefix. `prefix(regex)` is much faster than `(regex)`.
