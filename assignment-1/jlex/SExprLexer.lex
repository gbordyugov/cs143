import java.lang.System;

class SExprLexer {
    public static void main(String argv[]) throws java.io.IOException {
        Yylex yy = new Yylex(System.in);
        SExprToken t;
        while ((t = yy.yylex()) != null)
            System.out.println(t);
    }
}

class Utility {
    public static void ASSERT (boolean expr) {
        if (false == expr) {
            throw (new Error("Error: Assertion failed."));
        }
    }

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
}


class SExprQuote implements SExprToken {
}


class SExprOpeningParen implements SExprToken {
}


class SExprClosingParen implements SExprToken {
}


class SExprNumber implements SExprToken {
    private double value;
    SExprNumber(double v) {
        value = v;
    }
}


class SExprSymbol implements SExprToken {
    private String value;
    SExprSymbol(String v) {
        value = v;
    }
}


class SExprString implements SExprToken {
    private String value;
    SExprString(String v) {
        value = v;
    }
}

%%

%{
  private int comment_count = 0;
%}
%line
%char
%state COMMENT
%type SExprToken

ALPHA=[A-Za-z]
DIGIT=[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
WHITE_SPACE_CHAR=[\n\ \t\b\012]
STRING_TEXT=(\\\"|[^\n\"]|\\{WHITE_SPACE_CHAR}+\\)*
COMMENT_TEXT=([^/*\n]|[^*\n]"/"[^*\n]|[^/\n]"*"[^/\n]|"*"[^/\n]|"/"[^*\n])*


%%

<YYINITIAL> "(" { return (new SExprOpeningParen()); }

<YYINITIAL,COMMENT> \n { }

<YYINITIAL,COMMENT> . {
        System.out.println("Illegal character: <" + yytext() + ">");
	Utility.error(Utility.E_UNMATCHED);
}
