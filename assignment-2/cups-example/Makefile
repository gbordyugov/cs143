CUPJAR = ${HOME}/cs143/lib/java-cup-11a.jar
CUP := ${HOME}/cs143/bin/java_cup

Parser.java: calc.cup Makefile
	${CUP} -parser Parser -expect 10000 -dump -nopositions < calc.cup > calc.output 2>&1

parser: Parser.java Makefile
	@rm -f parser
	echo '#!/bin/sh' >> parser
	echo 'java -classpath ${CLASSPATH}:`dirname $$0` Parser $$*' >> parser
	chmod 755 parser


Calc.class: Calc.java
	javac -cp ${CUPJAR} Calc.java
