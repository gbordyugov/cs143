# My fotes around the second home assignment in CS 143 Compilers, Stanford

## The problem with let

The syntax of `let` reads

```
let ID : TYPE [ <- expr ] [, ID : TYPE [ <- expr]]+ in expr
```

There is a corresponding constructor for AST node:

```
constructor let(identifier, type_decl: Symbol;
                init, body: Expression): Expression;
```

The problem is that the constructor assumes only one identifier. In
the case of several identifiers, the whole let expression should be
parser as a nested set of several let expressions, each one with only
one identifier. I am therefore confused about how to express this
logic in the parser specification `cool.cup`.

## Example

The expression

```
let
    a: String <- "foo",
    b: String <- "buzz"
in
    3.1415926
```

should result in the parser calling the following chained constructor:

```
let(a, String; "foo",
    let(b, String, "buzz", 3.1415926))
```

But I still don't understanding how to do that!

## Solution

Taken from [here](https://github.com/egaburov/CS143-Compilers-Stanford/blob/master/PA3/cool.y).

The idea is to move the `LET` keyword out of the definition of
let-expressions. Then we have to do either with simple, i.e,
single-id, let-expressions like

```
    b: String <- "buzz"
in
    3
```

or multi-id let-expressions like

```
    b: String <- "buzz"
    c: String <- "qux"
in
    3
```

The latter is just a one-id let-expression prefixed by `b: String <-
"buzz"` that could be trivially parsed with the help of a two-choice
production rule.
