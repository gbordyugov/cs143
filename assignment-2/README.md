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
