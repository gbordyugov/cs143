# My solution to the second assignment of the CS143 course

The task is to create a parser for the grammar of Cool language.

Tools needed:

- Java CUP parser generator,
- JLex, a Java lexer generator,
- The Tree package that generates Java classes for the AST of Cool.

Available documentation:

- PA2.pdf from the course, explaining what to do,
- tour of the Cool support code, including...
- ... the definition of the Tree package

Notes:

- class `Program` has a `programc` constructor, class `class_` has a
  `class_c` constructor,
- other constructors don't have an `c` suffix as there is no
  counterpart phylum,
- constructors are nothing else but subclasses of the corresponding class,

## The problem with `LET`

The syntax of `let` reads

```
let ID : TYPE [ <- expr ] [, ID : TYPE [ <- expr]]+ in expr
```

There is a corresponding constructor for AST node:

```
constructor let(identifier, type_decl: Symbol;
                init, body: Expression): Expression;
```

### Problem description

The problem is that the constructor assumes only one identifier. In
the case of several identifiers, the whole let expression should be
parser as a nested set of several let expressions, each one with only
one identifier. I am therefore confused about how to express this
logic in the parser specification `cool.cup`.

### Example

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

### Solution

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
