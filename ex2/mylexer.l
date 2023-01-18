%option noyywrap

/* Definitions --------------------------------------------------------------------------------- */

%{
    #include <assert.h>
    #include <stdio.h>
    #include <string.h>
    #include <math.h>

	#include "cgen.h"
	#include "myanalyzer.tab.h"

	int line_num = 1; 
%}

IDENTIFIER      		[a-zA-Z][0-9a-zA-Z_]*

CONST_DIGIT   			[0-9]
CONST_INT  				{CONST_DIGIT}{CONST_DIGIT}*

CONST_DECIMAL 			("."{CONST_INT})|({CONST_INT}("."{CONST_INT}?)?)
CONST_REAL    			{CONST_DECIMAL}([eE][+-]?{CONST_INT})?

CONST_ESCAPE_CHAR 		("\""|"\\"|"\r"|"\t"|"\n")
CONST_COMMON_CHAR   	("-"|"+"|"*"|"/"|":"|"_"|"$"|"!"|"#"|"@"|"~"|"^"|"("|")")
CONST_STRING  			("\"")([a-zA-Z0-9]|" "|{CONST_ESCAPE_CHAR}|{CONST_COMMON_CHAR})*("\"")

%x comment

%% /* Rules ------------------------------------------------------------------------------------ */

int 					{ printf("  Line %d: Token (KEYWORLD INT): %s\n", line_num, yytext); 		return TK_KW_INT; }
real					{ printf("  Line %d: Token (KEYWORLD REAL): %s\n", line_num, yytext); 		return TK_KW_REAL; }
string 					{ printf("  Line %d: Token (KEYWORLD STRING): %s\n", line_num, yytext); 	return TK_KW_STRING; }
bool 					{ printf("  Line %d: Token (KEYWORLD BOOL): %s\n", line_num, yytext); 		return TK_KW_BOOL; }
true 					{ printf("  Line %d: Token (KEYWORLD TRUE): %s\n", line_num, yytext); 		return TK_KW_TRUE; }
false 					{ printf("  Line %d: Token (KEYWORLD FALSE): %s\n", line_num, yytext); 		return TK_KW_FALSE; }
var 					{ printf("  Line %d: Token (KEYWORLD VAR): %s\n", line_num, yytext); 		return TK_KW_VAR; }
const 					{ printf("  Line %d: Token (KEYWORLD CONST): %s\n", line_num, yytext); 		return TK_KW_CONST; }
if 						{ printf("  Line %d: Token (KEYWORLD IF): %s\n", line_num, yytext); 		return TK_KW_IF; }
else 					{ printf("  Line %d: Token (KEYWORLD ELSE): %s\n", line_num, yytext); 		return TK_KW_ELSE; }
for 					{ printf("  Line %d: Token (KEYWORLD FOR): %s\n", line_num, yytext); 		return TK_KW_FOR; }
while 					{ printf("  Line %d: Token (KEYWORLD WHILE): %s\n", line_num, yytext); 		return TK_KW_WHILE; }
break 					{ printf("  Line %d: Token (KEYWORLD BREAK): %s\n", line_num, yytext); 		return TK_KW_BREAK; }
continue 				{ printf("  Line %d: Token (KEYWORLD CONTINUE): %s\n", line_num, yytext); 	return TK_KW_CONTINUE; }
func					{ printf("  Line %d: Token (KEYWORLD FUNC): %s\n", line_num, yytext); 		return TK_KW_FUNC; }
nil						{ printf("  Line %d: Token (KEYWORLD NIL): %s\n", line_num, yytext); 		return TK_KW_NIL; }
return 					{ printf("  Line %d: Token (KEYWORLD RETURN): %s\n", line_num, yytext); 	return TK_KW_RETURN; }
begin 					{ printf("  Line %d: Token (KEYWORLD BEGIN): %s\n", line_num, yytext); 		return TK_KW_BEGIN; }

"="						{ printf("  Line %d: Token (OP ASSIGNMENT): %s\n", line_num, yytext); 		return TK_OP_ASSIGNMENT; }
"+"	    				{ printf("  Line %d: Token (OP PLUS): %s\n", line_num, yytext); 			return TK_OP_PLUS; }
"-"	    				{ printf("  Line %d: Token (OP MINUS): %s\n", line_num, yytext); 			return TK_OP_MINUS; }
"*"	    				{ printf("  Line %d: Token (OP MULTIPLICATION): %s\n", line_num, yytext); 	return TK_OP_MULTIPLICATION; }
"/"	    				{ printf("  Line %d: Token (OP DIVISION): %s\n", line_num, yytext); 		return TK_OP_DIVISION; }
"%"	    				{ printf("  Line %d: Token (OP MODULO): %s\n", line_num, yytext); 			return TK_OP_MODULO; }
"**"					{ printf("  Line %d: Token (OP POWER): %s\n", line_num, yytext); 		    return TK_OP_POWER; } 
"=="					{ printf("  Line %d: Token (OP EQUAL): %s\n", line_num, yytext); 			return TK_OP_EQUAL; }
"<"						{ printf("  Line %d: Token (OP LESS): %s\n", line_num, yytext); 			return TK_OP_LESS; }
">"						{ printf("  Line %d: Token (OP GREATER): %s\n", line_num, yytext); 			return TK_OP_GREATER; }
"<="					{ printf("  Line %d: Token (OP LESS EQUAL): %s\n", line_num, yytext); 		return TK_OP_LESS_EQUAL; }
">="					{ printf("  Line %d: Token (OP GREATER EQUAL): %s\n", line_num, yytext); 	return TK_OP_GREATER_EQUAL; }
"!="					{ printf("  Line %d: Token (OP NOT EQUAL): %s\n", line_num, yytext); 		return TK_OP_NOT_EQUAL; }

and 					{ printf("  Line %d: Token (OP AND): %s\n", line_num, yytext); 				return TK_OP_AND; }
or 						{ printf("  Line %d: Token (OP OR): %s\n", line_num, yytext); 				return TK_OP_OR; }
not 					{ printf("  Line %d: Token (OP NOT): %s\n", line_num, yytext); 				return TK_OP_NOT; }

";"	   					{ printf("  Line %d: Token (SEMICOLON): %s\n", line_num, yytext); 			return TK_DL_SEMICOLON; } 
"("	    				{ printf("  Line %d: Token (LEFT PARENTHESIS): %s\n", line_num, yytext); 	return TK_DL_LEFT_PARENTHESIS; } 
")"	    				{ printf("  Line %d: Token (RIGHT PARENTHESIS): %s\n", line_num, yytext); 	return TK_DL_RIGHT_PARENTHESIS; } 
","	    				{ printf("  Line %d: Token (COMMA): %s\n", line_num, yytext); 				return TK_DL_COMMA; } 
"["	    				{ printf("  Line %d: Token (LEFT SQR BRACKET): %s\n", line_num, yytext); 	return TK_DL_LEFT_SQUARE_BRACKET; } 
"]"	    				{ printf("  Line %d: Token (RIGHT SQR BRACKET): %s\n", line_num, yytext);	return TK_DL_RIGHT_SQUARE_BRACKET; } 
"{"	    				{ printf("  Line %d: Token (LEFT CRL BRACKET): %s\n", line_num, yytext); 	return TK_DL_LEFT_CURLY_BRACKET; } 
"}"	    				{ printf("  Line %d: Token (RIGHT CRL BRACKET): %s\n", line_num, yytext); 	return TK_DL_RIGHT_CURLY_BRACKET; } 
":"						{ printf("  Line %d: Token (COLON): %s\n", line_num, yytext); 				return TK_DL_COLON; }

readString  			{ printf("  Line %d: Token (readString): %s\n", line_num, yytext); 			return TK_FN_READSTRING; }
readInt  				{ printf("  Line %d: Token (readInt): %s\n", line_num, yytext); 			return TK_FN_READINT; }
readReal				{ printf("  Line %d: Token (readReal): %s\n", line_num, yytext); 			return TK_FN_READREAL; }
writeString				{ printf("  Line %d: Token (writeString): %s\n", line_num, yytext); 		return TK_FN_WRITESTRING; }
writeInt 				{ printf("  Line %d: Token (writeInt): %s\n", line_num, yytext); 			return TK_FN_WRITEINT; }
writeReal				{ printf("  Line %d: Token (writeReal): %s\n", line_num, yytext); 			return TK_FN_WRITEREAL; }

{IDENTIFIER}			{ printf("  Line %d: Token (IDENTIFIER): %s\n", line_num, yytext); 			yylval.str = strdup(yytext);	return TK_IDENTIFIER; }
{CONST_INT}				{ printf("  Line %d: Token (CONSTANT INT): %s\n", line_num, yytext); 		yylval.str = strdup(yytext);	return TK_CONST_INT; }
{CONST_REAL}			{ printf("  Line %d: Token (CONSTANT REAL): %s\n", line_num, yytext); 		yylval.str = strdup(yytext);	return TK_CONST_REAL; }
{CONST_STRING}			{ printf("  Line %d: Token (CONSTANT STRING): %s\n", line_num, yytext); 	yylval.str = strdup(yytext);	return TK_CONST_STRING; }

"//"[^\n]*				/* eat line comments */

"/*"					BEGIN(comment);
<comment>[^*\n]*        /* eat anything that's not a '*' */
<comment>"*"+[^*/\n]*	/* eat up '*'s not followed by ')'s */
<comment>\n             ++line_num;
<comment>"*"+"/"        BEGIN(INITIAL);

[ \r\t]					/* skip whitespace */
\n 						++line_num;

<<EOF>> 				return EOF;

.             			{ printf("~ Line %d: Token (unrecognized): %s - Lexical Error\n", line_num, yytext); }

%% /* User Code -------------------------------------------------------------------------------- */
