import java_cup.runtime.*;

class Main {
    public static void main(String[] argv) throws Exception {
        System.out.println("Please type your arithmethic expression:");
        // Parser p = new Parser(new scanner());
        Parser p = new Parser(new Yylex(System.in));
        p.parse();
    }
}
