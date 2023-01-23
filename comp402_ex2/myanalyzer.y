/* Prologue ------------------------------------------------------------------------------------ */

%{
  #include <stdlib.h>
  #include <stdarg.h>
  #include <stdio.h>
  #include <string.h>   
  #include "cgen.h"
  #include "pilib.h"
  
  extern int yylex(void);
  extern int line_num;
%}

/* Bison Declarations -------------------------------------------------------------------------- */

%union
{
  char* str;
}

%token <str> TK_IDENTIFIER
%token <str> TK_CONST_INT
%token <str> TK_CONST_REAL
%token <str> TK_CONST_STRING

%token TK_KW_INT
%token TK_KW_REAL
%token TK_KW_STRING
%token TK_KW_BOOL
%token TK_KW_TRUE
%token TK_KW_FALSE
%token TK_KW_VAR
%token TK_KW_CONST
%token TK_KW_IF
%token TK_KW_ELSE
%token TK_KW_FOR
%token TK_KW_WHILE
%token TK_KW_BREAK
%token TK_KW_CONTINUE
%token TK_KW_FUNC
%token TK_KW_NIL
%token TK_KW_RETURN
%token TK_KW_BEGIN
%token TK_OP_ASSIGNMENT
%token TK_OP_PLUS
%token TK_OP_MINUS
%token TK_OP_MULTIPLICATION
%token TK_OP_DIVISION
%token TK_OP_MODULO
%token TK_OP_POWER
%token TK_OP_EQUAL
%token TK_OP_LESS
%token TK_OP_GREATER
%token TK_OP_LESS_EQUAL
%token TK_OP_GREATER_EQUAL
%token TK_OP_NOT_EQUAL
%token TK_OP_AND
%token TK_OP_OR
%token TK_OP_NOT    
%token TK_DL_SEMICOLON
%token TK_DL_LEFT_PARENTHESIS
%token TK_DL_RIGHT_PARENTHESIS
%token TK_DL_COMMA
%token TK_DL_LEFT_SQUARE_BRACKET
%token TK_DL_RIGHT_SQUARE_BRACKET
%token TK_DL_LEFT_CURLY_BRACKET
%token TK_DL_RIGHT_CURLY_BRACKET
%token TK_DL_COLON

%token TK_FN_READSTRING
%token TK_FN_READINT
%token TK_FN_READREAL
%token TK_FN_WRITESTRING
%token TK_FN_WRITEINT
%token TK_FN_WRITEREAL

%right TK_OP_ASSIGNMENT

%left OP_SUB OP_ADD
%left TK_OP_MINUS TK_OP_PLUS
%left TK_OP_MULTIPLICATION TK_OP_DIVISION TK_OP_MODULO 
%right TK_OP_POWER

%left TK_OP_LESS TK_OP_GREATER TK_OP_EQUAL TK_OP_NOT_EQUAL TK_OP_LESS_EQUAL TK_OP_GREATER_EQUAL 
%left TK_OP_AND TK_OP_OR

%left TK_DL_LEFT_PARENTHESIS TK_DL_RIGHT_PARENTHESIS
%left TK_DL_LEFT_SQUARE_BRACKET TK_DL_RIGHT_SQUARE_BRACKET

%right OP_POS OP_NEG
%right TK_OP_NOT

%start program

%type <str> main_body
%type <str> declaration

%type <str> data_declaration
%type <str> const_declaration
%type <str> var_declaration
%type <str> const_option
%type <str> var_option
%type <str> data_type

%type <str> func_declaration
%type <str> func_parameter
%type <str> return_type
%type <str> func_body
%type <str> func_call
%type <str> func_argument

%type <str> command_declaration
%type <str> command_assign
%type <str> command_return
%type <str> command_if
%type <str> command_else
%type <str> command_for
%type <str> command_while
%type <str> command_break
%type <str> command_continue
%type <str> command_pi

%type <str> line_single
%type <str> line_multiple
%type <str> arg1
%type <str> arg2

%type <str> expr

%% /* Grammar Rules ---------------------------------------------------------------------------- */

/* initialization */

program: 
  declaration TK_KW_FUNC TK_KW_BEGIN TK_DL_LEFT_PARENTHESIS TK_DL_RIGHT_PARENTHESIS TK_DL_LEFT_CURLY_BRACKET main_body TK_DL_RIGHT_CURLY_BRACKET
{
  if (yyerror_count == 0) {
    printf("\n#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n#include <math.h>\n#include \"pilib.h\"\n\n");
    printf("%s\n\n", $1);
    printf("int main() {\n%s\n}\n\n", $7);
  } 
}
|  declaration TK_KW_FUNC TK_KW_BEGIN TK_DL_LEFT_PARENTHESIS TK_DL_RIGHT_PARENTHESIS TK_DL_LEFT_CURLY_BRACKET main_body TK_DL_RIGHT_CURLY_BRACKET declaration
{
  if (yyerror_count == 0) {
    printf("\n#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n#include <math.h>\n#include \"pilib.h\"\n\n");
    printf("%s\n\n", $1);
    printf("int main() {\n%s\n}\n\n", $7);
    printf("%s\n\n", $9);
  } 
}
| TK_KW_FUNC TK_KW_BEGIN TK_DL_LEFT_PARENTHESIS TK_DL_RIGHT_PARENTHESIS TK_DL_LEFT_CURLY_BRACKET main_body TK_DL_RIGHT_CURLY_BRACKET declaration
{
  if (yyerror_count == 0) {
    printf("\n#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n#include <math.h>\n#include \"pilib.h\"\n\n");
    printf("int main() {\n%s\n}\n\n", $6);
    printf("%s\n\n", $8);
  } 
}
| TK_KW_FUNC TK_KW_BEGIN TK_DL_LEFT_PARENTHESIS TK_DL_RIGHT_PARENTHESIS TK_DL_LEFT_CURLY_BRACKET main_body TK_DL_RIGHT_CURLY_BRACKET 
{
  if (yyerror_count == 0) {
    printf("\n#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n#include <math.h>\n#include \"pilib.h\"\n\n");
    printf("int main() {\n%s\n}\n\n", $6);
  }
}
;

main_body:
  command_declaration { $$ = $1; }
| main_body command_declaration { $$ = template("%s\n%s", $1, $2); }
| data_declaration { $$ = $1; }
| main_body data_declaration { $$ = template("%s\n%s", $1, $2); }
;

declaration:
  func_declaration { $$ = $1; }
| data_declaration { $$ = $1; }
;

/* pi language declarations */

data_declaration:
  const_declaration TK_DL_SEMICOLON { $$ = $1; }
| var_declaration TK_DL_SEMICOLON { $$ = $1; }
;

const_declaration:
  TK_KW_CONST const_option data_type { $$ = template("const %s %s;", $3, $2); }
;

var_declaration:
  TK_KW_VAR var_option data_type { $$ = template("%s %s;", $3, $2); }
;

const_option:
  TK_IDENTIFIER TK_OP_ASSIGNMENT expr { $$ = template("%s = %s", $1, $3); }
| TK_IDENTIFIER TK_OP_ASSIGNMENT expr TK_DL_COMMA const_option { $$ = template("%s = %s, %s", $1, $3, $5); }
| TK_IDENTIFIER TK_DL_LEFT_SQUARE_BRACKET TK_CONST_INT TK_DL_RIGHT_SQUARE_BRACKET TK_OP_ASSIGNMENT TK_CONST_STRING { $$ = template("%s[%s] = %s", $1, $3, $6); }
| TK_IDENTIFIER TK_DL_LEFT_SQUARE_BRACKET TK_CONST_INT TK_DL_RIGHT_SQUARE_BRACKET TK_OP_ASSIGNMENT TK_CONST_STRING TK_DL_COMMA const_option { $$ = template("%s[%s] = %s, %s", $1, $3, $6, $8); }
;

var_option:
  TK_IDENTIFIER { $$ = $1; }
| TK_IDENTIFIER TK_DL_COMMA var_option { $$ = template("%s, %s", $1, $3); }
| TK_IDENTIFIER TK_DL_LEFT_SQUARE_BRACKET TK_CONST_INT TK_DL_RIGHT_SQUARE_BRACKET { $$ = template("%s[%s]", $1, $3); }
| TK_IDENTIFIER TK_DL_LEFT_SQUARE_BRACKET TK_CONST_INT TK_DL_RIGHT_SQUARE_BRACKET TK_DL_COMMA var_option { $$ = template("%s[%s], %s", $1, $3, $6); }
| command_assign { $$ = template("%s", $1); }
| command_assign TK_DL_COMMA var_option { $$ = template("%s, %s", $1, $3); }
;

data_type:
  TK_KW_INT { $$ = template("int"); }
| TK_KW_REAL { $$ = template("double"); }
| TK_KW_BOOL { $$ = template("int"); }
| TK_KW_STRING { $$ = template("char*"); }
;

/* pi language functions */

func_declaration:
  TK_KW_FUNC TK_IDENTIFIER TK_DL_LEFT_PARENTHESIS func_parameter TK_DL_RIGHT_PARENTHESIS return_type TK_DL_LEFT_CURLY_BRACKET func_body TK_DL_RIGHT_CURLY_BRACKET { $$ = template("%s %s(%s) {\n%s\n}", $6, $2, $4, $8); }
;

func_parameter: 
  { $$ = template(""); }
| TK_IDENTIFIER data_type { $$ = template("%s %s", $2, $1); }
| TK_IDENTIFIER data_type TK_DL_COMMA func_parameter { $$ = template("%s %s, %s ", $2, $1, $4); }   
| TK_IDENTIFIER TK_DL_LEFT_SQUARE_BRACKET TK_DL_RIGHT_SQUARE_BRACKET data_type { $$ = template("%s* %s", $4, $1); }   
| TK_IDENTIFIER TK_DL_LEFT_SQUARE_BRACKET TK_DL_RIGHT_SQUARE_BRACKET data_type TK_DL_COMMA func_parameter { $$ = template("%s* %s, %s", $4, $1, $6); }  
;

return_type:
  { $$ = template("void"); }
| data_type { $$ = $1; }
| TK_DL_LEFT_SQUARE_BRACKET TK_DL_RIGHT_SQUARE_BRACKET data_type { $$ = template("%s*", $3); }
;

func_body:
  data_declaration { $$ = $1; }
| data_declaration func_body { $$ = template("%s\n%s ", $1, $2); }
| command_declaration { $$ = $1; }
| command_declaration command_return { $$ = template("%s\n%s ", $1, $2); }
| command_declaration func_body { $$ = template("%s\n%s ", $1, $2); }
;

func_call:
  TK_IDENTIFIER TK_DL_LEFT_PARENTHESIS func_argument TK_DL_RIGHT_PARENTHESIS { $$ = template("%s(%s)", $1, $3); }
;

func_argument:
  { $$ = template(""); }
| expr { $$ = template("%s", $1); }
| func_argument TK_DL_COMMA expr { $$ = template("%s, %s", $1, $3); }
;

/* pi language commands */

command_declaration:
  command_assign TK_DL_SEMICOLON { $$ = template("%s;", $1); }
| command_return TK_DL_SEMICOLON { $$ = template("%s;", $1); }
| command_if { $$ = $1; }
| command_for { $$ = $1; }
| command_while { $$ = $1; }
| command_break TK_DL_SEMICOLON { $$ = template("%s;", $1); }
| command_continue TK_DL_SEMICOLON { $$ = template("%s;", $1); }
| command_pi TK_DL_SEMICOLON { $$ = template("%s;", $1); }
| func_call TK_DL_SEMICOLON { $$ = template("%s;", $1); }
;

command_assign :
  TK_IDENTIFIER TK_OP_ASSIGNMENT expr { $$ = template("%s = %s", $1, $3); }
;

command_return:
 TK_KW_RETURN expr { $$ = template("return %s", $2); }
;

command_break:
  TK_KW_BREAK { $$ =template("break"); }
;

command_continue:
  TK_KW_CONTINUE { $$ =template("continue"); }
;

command_pi: 
  TK_IDENTIFIER TK_OP_ASSIGNMENT TK_FN_READSTRING TK_DL_LEFT_PARENTHESIS TK_DL_RIGHT_PARENTHESIS { $$ = template("%s = readString()", $1); }
| TK_IDENTIFIER TK_OP_ASSIGNMENT TK_FN_READINT TK_DL_LEFT_PARENTHESIS TK_DL_RIGHT_PARENTHESIS { $$ = template("%s = readInt()", $1); }
| TK_IDENTIFIER TK_OP_ASSIGNMENT TK_FN_READREAL TK_DL_LEFT_PARENTHESIS TK_DL_RIGHT_PARENTHESIS { $$ = template("%s = readReal()", $1); }
| TK_FN_WRITESTRING TK_DL_LEFT_PARENTHESIS expr TK_DL_RIGHT_PARENTHESIS { $$ = template("writeString(%s)", $3); }
| TK_FN_WRITEINT TK_DL_LEFT_PARENTHESIS expr TK_DL_RIGHT_PARENTHESIS { $$ = template("writeInt(%s)", $3); }
| TK_FN_WRITEREAL TK_DL_LEFT_PARENTHESIS expr TK_DL_RIGHT_PARENTHESIS { $$ = template("writeReal(%s)", $3); }
;

command_for: 
  TK_KW_FOR TK_DL_LEFT_PARENTHESIS arg1 TK_DL_SEMICOLON expr TK_DL_SEMICOLON arg2 TK_DL_RIGHT_PARENTHESIS line_single { $$ = template("for(%s; %s; %s)\n%s\n", $3, $5, $7, $9); }
| TK_KW_FOR TK_DL_LEFT_PARENTHESIS arg1 TK_DL_SEMICOLON expr TK_DL_SEMICOLON arg2 TK_DL_RIGHT_PARENTHESIS TK_DL_LEFT_CURLY_BRACKET line_multiple TK_DL_RIGHT_CURLY_BRACKET { $$ = template("for(%s; %s; %s)\n{\n%s\n}\n", $3, $5, $7, $10); }
;

command_if:  
  TK_KW_IF TK_DL_LEFT_PARENTHESIS expr TK_DL_RIGHT_PARENTHESIS line_single { $$ = template("if(%s)\n%s\n", $3, $5); }
| TK_KW_IF TK_DL_LEFT_PARENTHESIS expr TK_DL_RIGHT_PARENTHESIS TK_DL_LEFT_CURLY_BRACKET line_multiple TK_DL_RIGHT_CURLY_BRACKET { $$ = template("if(%s)\n{\n%s\n}\n", $3, $6); }
| TK_KW_IF TK_DL_LEFT_PARENTHESIS expr TK_DL_RIGHT_PARENTHESIS line_single command_else { $$ = template("if(%s)\n%s\n%s", $3, $5, $6); }
| TK_KW_IF TK_DL_LEFT_PARENTHESIS expr TK_DL_RIGHT_PARENTHESIS TK_DL_LEFT_CURLY_BRACKET line_multiple TK_DL_RIGHT_CURLY_BRACKET command_else { $$ = template("if(%s)\n{\n%s\n}\n%s", $3, $6, $8); }
;

command_else:
  TK_KW_ELSE line_single { $$ = template("else\n%s", $2); }
| TK_KW_ELSE command_if { $$ = template("else %s", $2); }
| TK_KW_ELSE TK_DL_LEFT_CURLY_BRACKET line_multiple TK_DL_RIGHT_CURLY_BRACKET { $$ = template("else\n{\n%s\n}\n", $3); }
;

command_while:
  TK_KW_WHILE TK_DL_LEFT_PARENTHESIS expr TK_DL_RIGHT_PARENTHESIS line_single { $$ = template("while(%s)\n%s", $3, $5); }
| TK_KW_WHILE TK_DL_LEFT_PARENTHESIS expr TK_DL_RIGHT_PARENTHESIS TK_DL_LEFT_CURLY_BRACKET line_multiple TK_DL_RIGHT_CURLY_BRACKET { $$ = template("while(%s)\n{\n%s\n}", $3, $6); }
;

arg1:
  TK_IDENTIFIER TK_OP_ASSIGNMENT expr { $$ = template("%s = %s", $1, $3); }
| TK_IDENTIFIER TK_DL_LEFT_SQUARE_BRACKET TK_CONST_INT TK_DL_RIGHT_SQUARE_BRACKET TK_OP_ASSIGNMENT expr { $$ = template("%s[%s] = %s;", $1, $3, $6); }
;
arg2:
  TK_IDENTIFIER TK_OP_ASSIGNMENT expr { $$ = template("%s = %s", $1, $3); }
| TK_IDENTIFIER TK_DL_LEFT_SQUARE_BRACKET TK_CONST_INT TK_DL_RIGHT_SQUARE_BRACKET TK_OP_ASSIGNMENT expr { $$ = template("%s[%s] = %s;", $1, $3, $6); }
; 

line_single:
  command_assign TK_DL_SEMICOLON { $$ = template("%s;", $1); }
| command_return TK_DL_SEMICOLON { $$ = template("%s;", $1); }
| command_break TK_DL_SEMICOLON { $$ = template("%s;", $1); }
| command_continue TK_DL_SEMICOLON { $$ = template("%s;", $1); }
| command_pi TK_DL_SEMICOLON { $$ = template("%s;", $1); }
| func_call TK_DL_SEMICOLON { $$ = template("%s;", $1); }
| data_declaration TK_DL_SEMICOLON { $$ = template("%s;", $1); }
;

line_multiple:
  line_single { $$ = $1; }
| command_for { $$ = template("%s", $1); } 
| command_if { $$ = template("%s", $1); } 
| command_while { $$ = template("%s", $1); } 
| line_multiple command_assign TK_DL_SEMICOLON { $$ = template("%s\n%s;", $1, $2); }
| line_multiple command_return TK_DL_SEMICOLON { $$ = template("%s\n%s;", $1, $2); }
| line_multiple command_break TK_DL_SEMICOLON { $$ = template("%s\n%s;", $1, $2); }
| line_multiple command_continue TK_DL_SEMICOLON { $$ = template("%s\n%s;", $1, $2); }
| line_multiple command_pi TK_DL_SEMICOLON { $$ = template("%s\n%s;", $1, $2); } 
| line_multiple func_call TK_DL_SEMICOLON { $$ = template("%s\n%s;", $1, $2); }  
| line_multiple data_declaration { $$ = template("%s\n%s", $1, $2); }
| line_multiple command_for { $$ = template("%s\n%s", $1, $2); }
| line_multiple command_if { $$ = template("%s\n%s", $1,$2); }
| line_multiple command_while { $$ = template("%s\n%s", $1, $2); }
;

/* pi language expressions */

expr:
  TK_IDENTIFIER { $$ = $1; }       
| TK_CONST_INT { $$ = $1; }
| TK_CONST_REAL { $$ = $1; }
| TK_CONST_STRING { $$ = $1; }
| TK_KW_TRUE { $$ = template("%d", 1); }
| TK_KW_FALSE { $$ = template("%d", 0); }
| TK_KW_NIL { $$ = "NULL"; }
| TK_DL_LEFT_PARENTHESIS expr TK_DL_RIGHT_PARENTHESIS { $$ = template("(%s)", $2); }
| TK_OP_PLUS expr %prec OP_POS { $$ = template("+%s", $2); }
| TK_OP_MINUS expr %prec OP_NEG { $$ = template("-%s", $2); }
| expr TK_OP_AND expr { $$ = template("%s && %s", $1, $3); }
| expr TK_OP_OR expr { $$ = template("%s || %s", $1, $3); }
| TK_OP_NOT expr { $$ = template("!%s", $2); }
| expr TK_OP_PLUS expr %prec OP_ADD { $$ = template("%s + %s", $1, $3); }
| expr TK_OP_MINUS expr %prec OP_SUB { $$ = template("%s - %s", $1, $3); }
| expr TK_OP_MULTIPLICATION expr { $$ = template("%s * %s", $1, $3); }
| expr TK_OP_DIVISION expr { $$ = template("%s / %s", $1, $3); }
| expr TK_OP_POWER expr { $$ = template("%s ** %s", $1, $3); }
| expr TK_OP_MODULO expr { $$ = template("%s % %s", $1, $3); }
| expr TK_OP_LESS expr { $$ = template("%s < %s", $1, $3); }
| expr TK_OP_GREATER expr { $$ = template("%s > %s", $1, $3); }
| expr TK_OP_EQUAL expr { $$ = template("%s == %s", $1, $3); }
| expr TK_OP_NOT_EQUAL expr { $$ = template("%s != %s", $1, $3); }
| expr TK_OP_LESS_EQUAL expr { $$ = template("%s <= %s", $1, $3); }  
| expr TK_OP_GREATER_EQUAL expr { $$ = template("%s >= %s", $1, $3); }
| func_call { $$ = template("%s", $1); }
;

%% /* Epilogue --------------------------------------------------------------------------------- */

int main() 
{
  if ( yyparse() == 0 )
    printf("/* Your program is syntactically correct! */\n");
  else
    printf("\n/* Syntax error in line: %d */\n", line_num);
}
