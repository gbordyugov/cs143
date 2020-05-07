#!/bin/sh

java -jar ~/cs143/lib/java-cup-11b.jar -interface -parser Parser calc.cup
javac -cp ~/cs143/lib/java-cup-11b-runtime.jar:. *.java
