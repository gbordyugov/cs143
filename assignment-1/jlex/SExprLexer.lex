import java.lang.System;

class SExprLexer {
    public static void main(String argv[]) throws java.io.IOException {
        Yylex yy = new Yylex(System.in);
        Yytoken t;
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

class Yytoken {
    Yytoken (int index, String text, int line, int charBegin, int charEnd) {
        m_index = index;
        m_text = new String(text);
        m_line = line;
        m_charBegin = charBegin;
        m_charEnd = charEnd;
    }

    public int m_index;
    public String m_text;
    public int m_line;
    public int m_charBegin;
    public int m_charEnd;

    public String toString() {
        return "Token #"+m_index+": "+m_text+" (line "+m_line+")";
    }
}

%%

%{
  private int comment_count = 0;
%}
%line
%char
%state COMMENT

ALPHA=[A-Za-z]
DIGIT=[0-9]
NONNEWLINE_WHITE_SPACE_CHAR=[\ \t\b\012]
WHITE_SPACE_CHAR=[\n\ \t\b\012]
STRING_TEXT=(\\\"|[^\n\"]|\\{WHITE_SPACE_CHAR}+\\)*
COMMENT_TEXT=([^/*\n]|[^*\n]"/"[^*\n]|[^/\n]"*"[^/\n]|"*"[^/\n]|"/"[^*\n])*


%%

<YYINITIAL> "(" { return (new SExprOpeningParen()); }
