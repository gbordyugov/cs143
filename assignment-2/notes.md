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
