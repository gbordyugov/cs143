/*
 *  The scanner definition for COOL.
 */

import java_cup.runtime.Symbol;

%%

%{

 /*  Stuff enclosed in %{ %} is copied verbatim to the lexer class
  *  definition, all the extra variables/functions you want to use in the
  *  lexer actions should go here.  Don't remove or modify anything that
  *  was there initially.
  */

  // Max size of string constants
  static int MAX_STR_CONST = 1025;

  // For assembling string constants
  StringBuffer string_buf = new StringBuffer();

  private int curr_lineno = 1;

  int get_curr_lineno() {
      return curr_lineno;
  }

  // is used to track only (* ... *) comments,
  // double-dash comments are not taken into account by it
  private int comment_level = 0;

  private AbstractSymbol filename;

  void set_filename(String fname) {
    filename = AbstractTable.stringtable.addString(fname);
  }

  AbstractSymbol curr_filename() {
    return filename;
  }
%}

%init{

 /*  Stuff enclosed in %init{ %init} is copied verbatim to the lexer
  *  class constructor, all the extra initialization you want to do should
  *  go here.  Don't remove or modify anything that was there initially.
  */

    // empty for now
%init}

%eofval{

/*  Stuff enclosed in %eofval{ %eofval} specifies java code that is
 *  executed when end-of-file is reached.  If you use multiple lexical
 *  states and want to do something special if an EOF is encountered in
 *  one of those states, place your code in the switch statement.
 *  Ultimately, you should return the EOF symbol, or your lexer won't
 *  work.
 */
    switch(yy_lexical_state) {
    case YYINITIAL:
	/* nothing special to do in the initial state */
        break;
    case DASH_COMMENT:
        break;
    case COMMENT:
        yybegin(YYINITIAL);
        return new Symbol(TokenConstants.ERROR, "EOF in comment");
    case STRING:
        yybegin(YYINITIAL);
        return new Symbol(TokenConstants.ERROR, "EOF in string");
    }
    return new Symbol(TokenConstants.EOF);
%eofval}

%class CoolLexer
%state COMMENT, DASH_COMMENT, STRING
%cup

DIGIT = [0-9]
MULT = \*
STR_CONST = \"[^\n]*\"
TYPEID = [A-Z][a-zA-Z0-9_]*
OBJECTID = [a-z][a-zA-Z0-9_]*
WHITE_SPACE_CHARS=([\ \t\b\f\r\x0b])+
COMMENT_CHAR=.|\r
DASH_COMMENT_TEXT=([^\n])*
STRING_SIMPLE_CHAR=[^\n\"\\]
NORMAL_AFTER_BACKSLASH=[^btnf]
NULL_CHAR=\x00
%%

<YYINITIAL> \" {
  /*
   * Closing quotes.
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

<STRING> \n {
  yybegin(YYINITIAL);
  return new Symbol(TokenConstants.ERROR, "Unescaped EOL in string");
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
    return new Symbol(TokenConstants.ERROR, "Null character in string");

  if (string_buf.length() > 1024)
    return new Symbol(TokenConstants.ERROR, "String literal longer than 1024 characters");

  return new Symbol(TokenConstants.STR_CONST,
                    AbstractTable.stringtable.addString(string_buf.toString()));
}


<YYINITIAL> "--" {
  yybegin(DASH_COMMENT);
}

"(*" {
  yybegin(COMMENT);
  comment_level++;
}

"*)" {
  if (comment_level <= 0)
    return new Symbol(TokenConstants.ERROR, yytext());

  comment_level--;

  if (0 == comment_level)
    yybegin(YYINITIAL);
}

<COMMENT> {COMMENT_CHAR} {
}

<DASH_COMMENT> {DASH_COMMENT_TEXT} {
}

<YYINITIAL> {MULT} {
  return new Symbol(TokenConstants.MULT);
}

<YYINITIAL> [iI][nN][hH][eE][rR][iI][tT][sS] {
  return new Symbol(TokenConstants.INHERITS);
}

<YYINITIAL> [pP][oO][oO][lL] {
  return new Symbol(TokenConstants.POOL);
}

<YYINITIAL> [cC][aA][sS][eE] {
  return new Symbol(TokenConstants.CASE);
}

<YYINITIAL> "(" {
  return new Symbol(TokenConstants.LPAREN);
}

<YYINITIAL> ";" {
  return new Symbol(TokenConstants.SEMI);
}

<YYINITIAL> "-" {
  return new Symbol(TokenConstants.MINUS);
}

<YYINITIAL> ")" {
  return new Symbol(TokenConstants.RPAREN);
}

<YYINITIAL> "~" {
  return new Symbol(TokenConstants.NEG);
}

<YYINITIAL> [nN][oO][tT] {
  return new Symbol(TokenConstants.NOT);
}

<YYINITIAL> "<" {
  return new Symbol(TokenConstants.LT);
}

<YYINITIAL> [iI][nN] {
  return new Symbol(TokenConstants.IN);
}

<YYINITIAL> "," {
  return new Symbol(TokenConstants.COMMA);
}

<YYINITIAL> [cC][lL][aA][sS][sS] {
  return new Symbol(TokenConstants.CLASS);
}

<YYINITIAL> [fF][iI] {
  return new Symbol(TokenConstants.FI);
}

<YYINITIAL> "/" {
  return new Symbol(TokenConstants.DIV);
}

<YYINITIAL> [lL][oO][oO][pP] {
  return new Symbol(TokenConstants.LOOP);
}

<YYINITIAL> "+" {
  return new Symbol(TokenConstants.PLUS);
}

<YYINITIAL> "<-" {
  return new Symbol(TokenConstants.ASSIGN);
}

<YYINITIAL> [iI][fF] {
  return new Symbol(TokenConstants.IF);
}

<YYINITIAL> "." {
  return new Symbol(TokenConstants.DOT);
}

<YYINITIAL> "<=" {
  return new Symbol(TokenConstants.LE);
}

<YYINITIAL> [oO][fF] {
  return new Symbol(TokenConstants.OF);
}

<YYINITIAL> [0-9]+ {
  return new Symbol(TokenConstants.INT_CONST,
                    AbstractTable.inttable.addString(yytext()));
}

<YYINITIAL> [nN][eE][wW] {
  return new Symbol(TokenConstants.NEW);
}

<YYINITIAL> [iI][sS][vV][oO][iI][dD] {
  return new Symbol(TokenConstants.ISVOID);
}

<YYINITIAL> "=" {
  return new Symbol(TokenConstants.EQ);
}

<YYINITIAL> "Error" {
  return new Symbol(TokenConstants.ERROR);
}

<YYINITIAL> ":" {
  return new Symbol(TokenConstants.COLON);
}

<YYINITIAL> "-" {
  return new Symbol(TokenConstants.NEG);
}

<YYINITIAL> "{" {
  return new Symbol(TokenConstants.LBRACE);
}

<YYINITIAL> [eE][lL][sS][eE] {
  return new Symbol(TokenConstants.ELSE);
}

<YYINITIAL> "=>" {
  return new Symbol(TokenConstants.DARROW);
}

<YYINITIAL> [wW][hH][iI][lL][eE] {
  return new Symbol(TokenConstants.WHILE);
}

<YYINITIAL> [eE][sS][aA][cC] {
  return new Symbol(TokenConstants.ESAC);
}

<YYINITIAL> [lL][eE][tT] {
  return new Symbol(TokenConstants.LET);
}

<YYINITIAL> "}" {
  return new Symbol(TokenConstants.RBRACE);
}

<YYINITIAL> [lL][eE][tT] {
  return new Symbol(TokenConstants.LET_STMT);
}

<YYINITIAL> [tT][hH][eE][nN] {
  return new Symbol(TokenConstants.THEN);
}

<YYINITIAL> f[aA][lL][sS][eE] {
  return new Symbol(TokenConstants.BOOL_CONST, false);
}

<YYINITIAL> t[rR][uU][eE] {
  return new Symbol(TokenConstants.BOOL_CONST, true);
}

<YYINITIAL> "@" {
  return new Symbol(TokenConstants.AT);
}

<YYINITIAL> {TYPEID} {
  return new Symbol(TokenConstants.TYPEID,
                    AbstractTable.idtable.addString(yytext()));
}

<YYINITIAL> {OBJECTID} {
  return new Symbol(TokenConstants.OBJECTID,
                    AbstractTable.idtable.addString(yytext()));
}


<YYINITIAL> {WHITE_SPACE_CHARS} {
}



<DASH_COMMENT> \n {
  curr_lineno++;
  yybegin(YYINITIAL);

}

<COMMENT, YYINITIAL> \n {
  curr_lineno++;
}

<STRING> \n {
  curr_lineno++;
  yybegin(YYINITIAL);
  return new Symbol(TokenConstants.ERROR, "EOL in string");
}

. {
   /* This rule should be the very last in your lexical specification
      and will match match everything not matched by other lexical rules.
   */
   return new Symbol(TokenConstants.ERROR,  yytext());
}
