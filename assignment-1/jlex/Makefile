all: run_sample

JLex/Main.class: JLex/Main.java
	javac JLex/Main.java

sample.lex.java: JLex/Main.class sample.lex
	java -classpath . JLex.Main sample.lex

Sample.class: sample.lex.java
	javac -d . sample.lex.java

run_sample: Sample.class
	java Sample

SExpr.lex.java: JLex/Main.class SExpr.lex
	java -classpath . JLex.Main SExpr.lex

SExpr.class: SExpr.lex.java
	javac -d . SExpr.lex.java

run_s_expr: SExpr.class
	java SExpr

clean:
	rm -rf JLex/*.class sample.lex.java SExpr.lex.java *.class
