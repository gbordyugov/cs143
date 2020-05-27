# How to scan/parse quotes

## The problem

This is a written attempt of solving the problem of parsing/lexing
single quotes in the s-expressions parser.

Examples of single quote usage:

```
'a
'124
'"string"
'(a b c)
'(a (b c))
```

The rule is that `'X` should be expanded into `(quote X)` for any `X`,
both atoms and lists.

The problem is that if we want to make this expansion work for `X`
being a list, we need the full power of a parser to take care of it,
since `X` can have any degree of nestedness.

## The solution

I went to the \#lisp channel and asked what to do, spaces between the
quote and the quoted s-expr are perfectly fine. Thus it can be
performed during the parsing step.
