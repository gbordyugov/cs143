# S-Expression parser

I wrote this to understand how to make Java CUP and JLex run together
to produce a working parser of a small grammar (a subset of
s-expressions).

What I learned here:

- CUP produces sym.java which defines symbols for all terminals from
  the corresponding .cup file, plus a couple of aux symbols (EOF and error),
- the code of JLex actions should return a java_cup.runtime.Symbol instance,
- those symbols hold the symbol code plus the object, which is an
  element of the AST,
- the AST should be defined somewhere around.
