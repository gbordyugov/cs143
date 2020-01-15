pall: sample.lex.java

JLex/Main.class: JLex/Main.java
	javac JLex/Main.java

sample.lex.java: JLex/Main.class sample.lex
	java -classpath . JLex.Main sample.lex

Sample.class: sample.lex.java
	javac -d . sample.lex.java

run_sample: Sample.class
	java Sample

clean:
	rm -rf JLex/*.class sample.lex.java *.class
