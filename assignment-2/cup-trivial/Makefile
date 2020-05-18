JARLIB = ${HOME}/src/foreign/cup/target/dist

CUPJARS = ${JARLIB}/java-cup-11b.jar:${JARLIB}/java-cup-11b-runtime.jar
CUP := ${HOME}/cs143/bin/java_cup_11b

Parser.java: trivial.cup Makefile
	java -cp \
		${JARLIB}/java-cup-11b.jar \
		java_cup.Main \
		-parser Parser \
		-expect 10000 \
		-dump -nopositions < trivial.cup > trivial.output 2>&1

parser: Parser.java Trivial.class Makefile
	@rm -f parser
	echo '#!/bin/sh' >> parser
	echo 'java -classpath ${CUPJARS}:`dirname $$0` Main $$*' >> parser
	chmod 755 parser


Trivial.class: Trivial.java Makefile
	javac -cp ${CUPJARS}:. *.java

clean:
	rm -rf *.class Parser.java sym.* parser trivial.output

debug:
	jdb -classpath ${CUPJARS}:. Main
