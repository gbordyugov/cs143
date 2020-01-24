# My notes to the sample JLex lexer

[Here](https://www.cs.princeton.edu/~appel/modern/java/JLex/current/manual.html)
one can find the official JLex manual.

## Pre-defined regexes

### The straight-forward ones

```
ALPHA=[A-Za-z]
DIGIT=[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
WHITE_SPACE_CHAR=[\n\ \t\b\012]
```

### String text

```
STRING_TEXT=(\\\"|[^\n\"]|\\{WHITE_SPACE_CHAR}+\\)*
```

The content of a string can be

- an escaped double quotation sign, or
- anything other than a newline or a quotation sign, or
- escaped, therefore `\\`, multiple white space chars.

### Comment text

```
COMMENT_TEXT=([^/*\n] | [^*\n]"/"[^*\n] | [^/\n]"*"[^/\n] | "*"[^/\n] | "/"[^*\n])*
```

Note that I added extra spaces around the choice dashes `|`.

It is a sequence of

- anything but `/`, or `*`, or a new line, or
- anything but `*` or a new line, followed by `/`, followed by
  anything but `/` or newline, or
- `*`, followed by anything but a `/` or a newline, or
- `/`, followed by anything but a `*` or a newline.

JLex-style regexes use double-quotes `"..."` to represent the literal
meaning of the quotation body, so `"*"` represent the star `*` itself
and `"/"` represent the slash `/`.
