all: run_sample

JLex/Main.class: JLex/Main.java
	javac JLex/Main.java

sample.lex.java: JLex/Main.class sample.lex
	java -classpath . JLex.Main sample.lex

Sample.class: sample.lex.java
	javac -d . sample.lex.java

run_sample: Sample.class
	java Sample

SExprLexer.lex.java: JLex/Main.class SExprLexer.lex
	java -classpath . JLex.Main SExprLexer.lex

SExprLexer.class: SExprLexer.lex.java
	javac -d . SExprLexer.lex.java

run_s_expr: SExprLexer.class
	java SExprLexer

clean:
	rm -rf JLex/*.class sample.lex.java SExprLexer.lex.java *.class
