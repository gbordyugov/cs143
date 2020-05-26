JARLIB = ${HOME}/src/foreign/cup/target/dist

CUPJARS = ${JARLIB}/java-cup-11b.jar:${JARLIB}/java-cup-11b-runtime.jar
CUP := ${HOME}/cs143/bin/java_cup_11b

Parser.java: s-expressions.cup Makefile
	java -cp \
		${JARLIB}/java-cup-11b.jar \
		java_cup.Main \
		-parser Parser \
		-expect 10000 \
		-dump -nopositions < s-expressions.cup > s-expressions.output 2>&1

parser: Parser.java Makefile SExprLexer.class S-Expressions.class SExpr.class
	@rm -f parser
	echo '#!/bin/sh' >> parser
	echo 'java -classpath ${CUPJARS}:`dirname $$0` Main $$*' >> parser
	chmod 755 parser

##
## Lexing stuff
##
JLex/Main.class: JLex/Main.java
	javac JLex/Main.java

SExprLexer.lex.java: JLex/Main.class SExprLexer.lex
	java -classpath . JLex.Main SExprLexer.lex

SExprLexer.class: SExprLexer.lex.java
	javac -d . -cp ${CUPJARS}:. SExprLexer.lex.java

## run_s_expr_lexer: SExprLexer.class Parser.java
##	java SExprLexer

##
## End of lexing stuff
##

S-Expressions.class: S-Expressions.java Makefile
	javac -cp ${CUPJARS}:. S-Expressions.java

SExpr.class: SExpr.java Makefile
	echo making SExpr.class
	javac SExpr.java

clean:
	rm -rf *.class Parser.java sym.* parser s-expressions.output \
	JLex/*.class SExprLexer.lex.java

debug:
	jdb -classpath ${CUPJARS}:. Main
