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

interface SExprToken {
    public String toString();
}


class SExprQuote implements SExprToken {
    public String toString() {
        return "SExprQuote";
    }
}


class SExprOpeningParen implements SExprToken {
    public String toString() {
        return "SExprOpeningParen";
    }
}


class SExprClosingParen implements SExprToken {
    public String toString() {
        return "SExprClosingParen";
    }
}


class SExprInt implements SExprToken {
    private int value;

    SExprInt(int v) {
        value = v;
    }

    public String toString() {
        return "SExprInt(" + value + ")";
    }
}


class SExprDouble implements SExprToken {
    private double value;

    SExprDouble(double v) {
        value = v;
    }

    public String toString() {
        return "SExprDouble(" + value + ")";
    }
}

class SExprSymbol implements SExprToken {
    private String value;

    SExprSymbol(String v) {
        value = v;
    }

    public String toString() {
        return "SExprSymbol(" + value + ")";
    }
}


class SExprString implements SExprToken {
    private String value;
    SExprString(String v) {
        value = v;
    }

    public String toString() {
        return "SExprString(" + value + ")";
    }
}

%%

%{

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

<YYINITIAL> {SYMBOL_CHAR}* { return (new SExprSymbol(yytext())); }

<YYINITIAL> [+-]?{DIGIT}*"."{DIGIT}+([eE][+-]?{DIGIT}+)? {
  return (new SExprDouble(Double.parseDouble(yytext())));
}

<YYINITIAL> [+-]?{DIGIT}+ {
  return (new SExprInt(Integer.parseInt(yytext())));
}

<YYINITIAL> \"{STRING_TEXT}\" {
  String str = yytext().substring(1, yytext().length() - 1);
  assert str.length() == yytext().length() - 2;
  return (new SExprSymbol(str));
}

<YYINITIAL> "(" { return (new SExprOpeningParen()); }

<YYINITIAL> ")" { return (new SExprClosingParen()); }

<YYINITIAL> "'" { return (new SExprQuote()); }

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
