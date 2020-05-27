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
    // Max size of string constants
    static int MAX_STR_CONST = 1024*1024;

    StringBuffer string_buf = new StringBuffer();

    private Symbol symbol(int type) {
        return new Symbol(type);
    }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, value);
    }
%}

%line
%char
%state COMMENT, STRING

%cup

%type Symbol

ALPHA=[A-Za-z]
SYMBOL_CHAR=[0-9A-Za-z+\-*/_=:><]
DIGIT=[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
WHITE_SPACE_CHAR=[\n\ \t\b\012]
COMMENT_TEXT=[^\n]*
STRING_SIMPLE_CHAR=[^\"\\]
NORMAL_AFTER_BACKSLASH=[^btnf]


%%

<YYINITIAL> {NONNEWLINE_WHITE_SPACE_CHAR}+ { }



<YYINITIAL> \" {
  /*
   * Opening quotes.
   */
  string_buf = new StringBuffer();
  yybegin(STRING);
}

<STRING> {STRING_SIMPLE_CHAR}* {
  string_buf.append(yytext());
}

<STRING> "\b" {
  string_buf.append("\b");
}

<STRING> "\t" {
  string_buf.append("\t");
}

<STRING> "\n" {
  string_buf.append("\n");
}

<STRING> "\f" {
  string_buf.append("\f");
}


<STRING> \\{NORMAL_AFTER_BACKSLASH} {
  string_buf.append(yytext().substring(1));
}


<STRING> \" {
  /*
   * Closing quotes.
   */
  yybegin(YYINITIAL);

  if (string_buf.indexOf("\u0000") >= 0)
    return new Symbol(sym.ERROR, "Null character in string");

  if (string_buf.length() >= MAX_STR_CONST)
    return new Symbol(sym.ERROR, "String literal longer than 1024 characters");

  return symbol(sym.STRING, string_buf.toString());
}



<YYINITIAL> {SYMBOL_CHAR}* { return symbol(sym.SYMBOL, yytext()); }

<YYINITIAL> [+-]?{DIGIT}*"."{DIGIT}+([eE][+-]?{DIGIT}+)? {
  return symbol(sym.DOUBLE, Double.parseDouble(yytext()));
}

<YYINITIAL> [+-]?{DIGIT}+ {
  return symbol(sym.INTEGER, Integer.parseInt(yytext()));
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
