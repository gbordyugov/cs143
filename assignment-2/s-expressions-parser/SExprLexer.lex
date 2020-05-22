import java.lang.System;
import java_cup.runtime.Scanner;
import java_cup.runtime.Symbol;

class Utility {
    private static final String errorMsg[] = {
        "Error: Unmatched end-of-comment punctuation.",
        "Error: Unmatched start-of-comment punctuation.",
        "Error: Unclosed string.",
        "Error: Illegal character."
    };

    public static final int E_ENDCOMMENT = 0;
    public static final int E_STARTCOMMENT = 1;
    public static final int E_UNCLOSEDSTR = 2;
    public static final int E_UNMATCHED = 3;

    public static void error (int code) {
        System.out.println(errorMsg[code]);
    }
}

%%

%{
    // StringBuffer string = new StringBuffer();

    private Symbol symbol(int type) {
        return new Symbol(type);
    }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, value);
    }
%}

%line
%char
%state COMMENT

%cup

%type Symbol

ALPHA=[A-Za-z]
SYMBOL_CHAR=[A-Za-z+-*/_]
DIGIT=[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
WHITE_SPACE_CHAR=[\n\ \t\b\012]
STRING_TEXT=(\\\"|[^\n\"]|\\{WHITE_SPACE_CHAR}+\\)*
COMMENT_TEXT=[^\n]*


%%

<YYINITIAL> {NONNEWLINE_WHITE_SPACE_CHAR}+ { }

<YYINITIAL> {SYMBOL_CHAR}* { return symbol(sym.SYMBOL, (yytext())); }

<YYINITIAL> [+-]?{DIGIT}*"."{DIGIT}+([eE][+-]?{DIGIT}+)? {
  return symbol(sym.DOUBLE, Double.parseDouble(yytext()));
}

<YYINITIAL> [+-]?{DIGIT}+ {
  return symbol(sym.INTEGER, Integer.parseInt(yytext()));
}

<YYINITIAL> \"{STRING_TEXT}\" {
  String str = yytext().substring(1, yytext().length() - 1);
  assert str.length() == yytext().length() - 2;
  return symbol(sym.SYMBOL, str);
}

<YYINITIAL> "(" { return symbol(sym.OPENING_PAREN); }

<YYINITIAL> ")" { return symbol(sym.CLOSING_PAREN); }

<YYINITIAL> "'" { return symbol(sym.QUOTE); }

<YYINITIAL> \n { }

<YYINITIAL> ";" {
  yybegin(COMMENT);
}

<COMMENT> {COMMENT_TEXT} { }

<COMMENT> \n {
  yybegin(YYINITIAL);
}

<YYINITIAL,COMMENT> . {
    System.out.println("Illegal character: <" + yytext() + ">");
	Utility.error(Utility.E_UNMATCHED);
}
