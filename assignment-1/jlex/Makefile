all: lexer

Main.class: Main.java
	javac Main.java

sample: Main.class
	java -classpath . JLex.Main example.lex

clean:
	rm -rf *.class
