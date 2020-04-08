JARLIB = ${HOME}/cs143/lib

CUPJARS = ${JARLIB}java-cup-11a.jar:${JARLIB}/java-cup-11a-runtime.jar
CUP := ${HOME}/cs143/bin/java_cup_11a

CUPJARS = ${JARLIB}java-cup-11b.jar:${JARLIB}/java-cup-11b-runtime.jar
CUP := ${HOME}/cs143/bin/java_cup_11b

Parser.java: calc.cup Makefile
	${CUP} -parser Parser -expect 10000 -dump -nopositions < calc.cup > calc.output 2>&1

parser: Parser.java Calc.class Makefile
	@rm -f parser
	echo '#!/bin/sh' >> parser
	echo 'java -classpath ${CUPJARS}:`dirname $$0` Main $$*' >> parser
	chmod 755 parser


Calc.class: Calc.java Makefile
	javac -cp ${CUPJARS}:. *.java

clean:
	rm -rf *.class Parser.java sym.* parser calc.output

debug:
	jdb -classpath ${CUPJARS}:. Main
