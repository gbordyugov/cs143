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
	/* If necessary, add code for other states here, e.g:
	   case COMMENT:
	   ...
	   break;
	*/
    }
    return new Symbol(TokenConstants.EOF);
%eofval}

%class CoolLexer
%cup

DIGIT = [0-9]
MULT = \*
STR_CONST = \"[a-zA-Z]*\"
TYPEID = [A-Z][a-zA-Z1-9_]*
OBJECTID = [a-z][a-zA-Z1-9_]*
WHITE_SPACE_CHAR=[\n\ \t\b\012]
%%

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

<YYINITIAL> {STR_CONST} {
  // TODO
  return new Symbol(TokenConstants.STR_CONST);
}

<YYINITIAL> ")" {
  return new Symbol(TokenConstants.RPAREN);
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

<YYINITIAL> [1-9][0-9]* {
  // TODO, pass the value of the constant
  return new Symbol(TokenConstants.INT_CONST);
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

<YYINITIAL> "{" {
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

<YYINITIAL> [aA][tT] {
  return new Symbol(TokenConstants.AT);
}

<YYINITIAL> {TYPEID} {
  // TODO
  return new Symbol(TokenConstants.TYPEID,
                    AbstractTable.idtable.addString(yytext()));
}

<YYINITIAL> {OBJECTID} {
  return new Symbol(TokenConstants.OBJECTID,
                    AbstractTable.idtable.addString(yytext()));
}


<YYINITIAL> {WHITE_SPACE_CHAR} {
}



\n {
  curr_lineno++;
}

. {
   /* This rule should be the very last
      in your lexical specification and
      will match match everything not
      matched by other lexical rules.
   */
   System.err.println("LEXER BUG - UNMATCHED: " + yytext());
}
