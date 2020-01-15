all: sample

JLex/Main.class: JLex/Main.java
	javac JLex/Main.java

sample: JLex/Main.class
	java -classpath . JLex.Main example.lex

clean:
	rm -rf JLex/*.class example.lex.java
