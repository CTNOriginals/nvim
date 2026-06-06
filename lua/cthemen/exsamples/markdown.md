# Cthemen Syntax Highlighting Demo

This document demonstrates **Markdown** syntax highlighting across various elements.

## Text Formatting

- **bold text** with double asterisks or __underscores__
- *italic text* with single asterisks or _underscores_
- ***bold and italic*** with triple asterisks
- ~~strikethrough~~ with double tildes
- `inline code` with backticks
- ==highlighted text==

## Lists

### Unordered

- item one
- item two
- nested item a
- nested item b
- deeply nested
- item three

### Ordered

1. first step
2. second step
1. sub-step a
2. sub-step b
3. third step

### Task List

- [x] completed task
- [ ] pending task
- [ ] another todo

## Blockquotes

> This is a blockquote.
> It can span multiple lines.
>
> > Nested blockquote for demonstration.

## Tables

| Feature       | Status | Priority |
| :------------ | :----: | -------: |
| syntax        |   ✅   |      high |
| treesitter    |   ✅   |      high |
| lsp           |   ✅   |    medium |
| dap           |   ⏳   |       low |



## Code Blocks

### Go

```go
package main

import "fmt"

func greet(name string) string {
    return fmt.Sprintf("hello, %s", name)
}
```

### JavaScript

```javascript
function fibonacci(n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}
```

### TypeScript

```typescript
type TResponse<T> = {
data: T;
error: null | string;
};
```

### C#

```csharp
public static class Helpers
{
    public static int Add(int a, int b) => a + b;
}
```

### Rust

    ```rust
    fn factorial(n: u64) -> u64 {
        match n {
            0 | 1 => 1,
              _ => n * factorial(n - 1),
        }
    }
```

### Diff

```diff
- console.log("old code");
+ console.log("new code");
```

## Links and Images

- [GitHub](https://github.com)
- [reference-style link][ref]
- ![placeholder](https://via.placeholder.com/150)

[ref]: https://example.com

## Horizontal Rules

---

***

___

## HTML

<div class="warning">
<p>HTML blocks are also rendered.</p>
</div>

<details>
<summary>Click to expand</summary>

Hidden content here.

</details>

## Footnotes

Here is a footnote reference[^1] and another[^2].

[^1]: First footnote definition.
[^2]: Second footnote with more detail.

## Math (LaTeX)

Inline: $E = mc^2$

Display:

    $$
\int_{a}^{b} f(x) \, dx = F(b) - F(a)
    $$

## Definition Lists

    Term
    : Definition for the term.

    Another term
    : Definition for this one.
    : Another definition.

## Abbreviations

    *[HTML]: HyperText Markup Language
    *[CSS]: Cascading Style Sheets

    The HTML specification is maintained by the W3C.
