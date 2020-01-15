all: lexer

Main.class: Main.java
	javac Main.java

JLex:
	ln -s . JLex

sample: Main.class JLex
	java -classpath . JLex.Main example.lex

clean:
	rm -rf *.class JLex
