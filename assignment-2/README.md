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


## Static vs dynamic types

The _static_ type of an expression is the type that is assigned to the
expression by the compiler at compile time. Contrarily, the _dynamic_
type is the type to which the expression evaluates at runtime, i.e.
during execution.

A type checker is called _sound_ if each expression's dynamic type is
not broader (i.e. not a super-class of) than the static type. For
example, given that `Dog` is a sub-class of `Animal`, it's OK to
resolve a statically typed (=declared in the source code) `Animal` to
an `Dog` at runtime, but not the other way around.

## Running the grading script

Get `pa2-grading.pl` from _somewhere_. Run it for a first time, it
will generate a directory called `grading` with lots of files in it.

The following steps might be needed to get grading to run properly:

- on Mac OSX, change the path to `sed` in `grading/PA3-filter`,
- you might want to change `grading/myparser` in such a way that it
  calls your lexer and parser in an appropriate way.

After you have set up all this, run

```
pa2-grading.pl -r
```

where the `-r` flag ensures that the grading script doesn't overwrite
your changes in the `grading` repository.
