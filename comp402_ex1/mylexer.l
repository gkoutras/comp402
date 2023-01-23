%option noyywrap

/* Definitions --------------------------------------------------------------------------------- */

%{
	#include <stdio.h>
	#include <string.h>
	#include <math.h>
	#include <assert.h>

	#define TK_IDENTIFIER 258
	#define TK_CONST_INT 259
	#define TK_CONST_REAL 260
	#define TK_CONST_STRING 261
	#define TK_KW_INT 262
	#define TK_KW_REAL 263
	#define TK_KW_STRING 264
	#define TK_KW_BOOL 265
	#define TK_KW_TRUE 266
	#define TK_KW_FALSE 267
	#define TK_KW_VAR 268
	#define TK_KW_CONST 269
	#define TK_KW_IF 270
	#define TK_KW_ELSE 271
	#define TK_KW_FOR 272
	#define TK_KW_WHILE 273
	#define TK_KW_BREAK 274
	#define TK_KW_CONTINUE 275
	#define TK_KW_FUNC 276
	#define TK_KW_NIL 277
	#define TK_KW_RETURN 278
	#define TK_KW_BEGIN 279
	#define TK_OP_ASSIGNMENT 280
	#define TK_OP_PLUS 281
	#define TK_OP_MINUS 282
	#define TK_OP_MULTIPLICATION 283
	#define TK_OP_DIVISION 284
	#define TK_OP_MODULO 285
	#define TK_OP_POWER 286
	#define TK_OP_EQUAL 287
	#define TK_OP_LESS 288
	#define TK_OP_GREATER 289
	#define TK_OP_LESS_EQUAL 290
	#define TK_OP_GREATER_EQUAL 291
	#define TK_OP_NOT_EQUAL 292
	#define TK_OP_AND 293
	#define TK_OP_OR 294
	#define TK_OP_NOT 295    
	#define TK_DL_SEMICOLON 296
	#define TK_DL_LEFT_PARENTHESIS 297
	#define TK_DL_RIGHT_PARENTHESIS 298
	#define TK_DL_COMMA 299
	#define TK_DL_LEFT_SQUARE_BRACKET 300
	#define TK_DL_RIGHT_SQUARE_BRACKET 301
	#define TK_DL_LEFT_CURLY_BRACKET 302
	#define TK_DL_RIGHT_CURLY_BRACKET 303
	#define TK_DL_COLON 304

	#define TK_FN_READSTRING 305
	#define TK_FN_READINT 306
	#define TK_FN_READREAL 307
	#define TK_FN_WRITESTRING 308
	#define TK_FN_WRITEINT 309
	#define TK_FN_WRITEREAL 310

	int line_num = 1; 
%}

IDENTIFIER      	[a-zA-Z][0-9a-zA-Z_]*

CONST_DIGIT   		[0-9]
CONST_INT  		{CONST_DIGIT}{CONST_DIGIT}*

CONST_DECIMAL 		("."{CONST_INT})|({CONST_INT}("."{CONST_INT}?)?)
CONST_REAL    		{CONST_DECIMAL}([eE][+-]?{CONST_INT})?

CONST_ESCAPE_CHAR 	("\""|"\\"|"\r"|"\t"|"\n")
CONST_COMMON_CHAR   	("-"|"+"|"*"|"/"|":"|"_"|"$"|"!"|"#"|"@"|"~"|"^"|"("|")")
CONST_STRING  		("\"")([a-zA-Z0-9]|" "|{CONST_ESCAPE_CHAR}|{CONST_COMMON_CHAR})*("\"")	

%x comment

%% /* Rules ------------------------------------------------------------------------------------ */

int 			{ printf("(KEYWORLD INT)\t\t"); 	return TK_KW_INT; }
real			{ printf("(KEYWORLD REAL)\t\t"); 	return TK_KW_REAL; }
string 			{ printf("(KEYWORLD STRING)\t"); 	return TK_KW_STRING; }
bool 			{ printf("(KEYWORLD BOOL)\t\t"); 	return TK_KW_BOOL; }
true 			{ printf("(KEYWORLD TRUE)\t\t"); 	return TK_KW_TRUE; }
false 			{ printf("(KEYWORLD FALSE)\t"); 	return TK_KW_FALSE; }
var 			{ printf("(KEYWORLD VAR)\t\t"); 	return TK_KW_VAR; }
const 			{ printf("(KEYWORLD CONST)\t"); 	return TK_KW_CONST; }
if 			{ printf("(KEYWORLD IF)\t\t"); 		return TK_KW_IF; }
else 			{ printf("(KEYWORLD ELSE)\t\t"); 	return TK_KW_ELSE; }
for 			{ printf("(KEYWORLD FOR)\t\t"); 	return TK_KW_FOR; }
while 			{ printf("(KEYWORLD WHILE)\t"); 	return TK_KW_WHILE; }
break 			{ printf("(KEYWORLD BREAK)\t"); 	return TK_KW_BREAK; }
continue 		{ printf("(KEYWORLD CONTINUE)\t"); 	return TK_KW_CONTINUE; }
func			{ printf("(KEYWORLD FUNC)\t\t"); 	return TK_KW_FUNC; }
nil			{ printf("(KEYWORLD NIL)\t\t"); 	return TK_KW_NIL; }
return 			{ printf("(KEYWORLD RETURN)\t"); 	return TK_KW_RETURN; }
begin 			{ printf("(KEYWORLD BEGIN)\t"); 	return TK_KW_BEGIN; }

"="			{ printf("(OP ASSIGNMENT)\t\t"); 	return TK_OP_ASSIGNMENT; }
"+"	    		{ printf("(OP PLUS)\t\t"); 		return TK_OP_PLUS; }
"-"	    		{ printf("(OP MINUS)\t\t"); 		return TK_OP_MINUS; }
"*"	    		{ printf("(OP MULTIPLICATION)\t"); 	return TK_OP_MULTIPLICATION; }
"/"	    		{ printf("(OP DIVISION)\t\t"); 		return TK_OP_DIVISION; }
"%"	    		{ printf("(OP MODULO)\t\t"); 		return TK_OP_MODULO; }
"**"			{ printf("(OP POWER)\t\t"); 		return TK_OP_POWER; } 
"=="			{ printf("(OP EQUAL)\t\t"); 		return TK_OP_EQUAL; }
"<"			{ printf("(OP LESS)\t\t"); 		return TK_OP_LESS; }
">"			{ printf("(OP GREATER)\t\t"); 		return TK_OP_GREATER; }
"<="			{ printf("(OP LESS EQUAL)\t\t"); 	return TK_OP_LESS_EQUAL; }
">="			{ printf("(OP GREATER EQUAL)\t"); 	return TK_OP_GREATER_EQUAL; }
"!="			{ printf("(OP NOT EQUAL)\t\t"); 	return TK_OP_NOT_EQUAL; }

and 			{ printf("(OP AND)\t\t\t"); 		return TK_OP_AND; }
or 			{ printf("(OP OR)\t\t\t"); 		return TK_OP_OR; }
not 			{ printf("(OP NOT)\t\t\t"); 		return TK_OP_NOT; }

";"	   		{ printf("(SEMICOLON)\t\t"); 		return TK_DL_SEMICOLON; } 
"("	    		{ printf("(LEFT PARENTHESIS)\t"); 	return TK_DL_LEFT_PARENTHESIS; } 
")"	    		{ printf("(RIGHT PARENTHESIS)\t"); 	return TK_DL_RIGHT_PARENTHESIS; } 
","	    		{ printf("(COMMA)\t\t\t"); 		return TK_DL_COMMA; } 
"["	    		{ printf("(LEFT SQR BRACKET)\t"); 	return TK_DL_LEFT_SQUARE_BRACKET; } 
"]"	    		{ printf("(RIGHT SQR BRACKET)\t"); 	return TK_DL_RIGHT_SQUARE_BRACKET; } 
"{"	    		{ printf("(LEFT CRL BRACKET)\t"); 	return TK_DL_LEFT_CURLY_BRACKET; } 
"}"	    		{ printf("(RIGHT CRL BRACKET)\t"); 	return TK_DL_RIGHT_CURLY_BRACKET; } 
":"			{ printf("(COLON)\t\t\t"); 		return TK_DL_COLON; }

readString  		{ printf("(readString)\t\t"); 		return TK_FN_READSTRING; }
readInt  		{ printf("(readInt)\t\t"); 		return TK_FN_READINT; }
readReal		{ printf("(readReal)\t\t");		return TK_FN_READREAL; }
writeString 		{ printf("(writeString)\t\t"); 		return TK_FN_WRITESTRING; }
writeInt 		{ printf("(writeInt)\t\t");		return TK_FN_WRITEINT; }
writeReal		{ printf("(writeReal)\t\t"); 		return TK_FN_WRITEREAL; }

{IDENTIFIER}		{ printf("(IDENTIFIER)\t\t"); 		return TK_IDENTIFIER; }
{CONST_INT}		{ printf("(CONSTANT INT)\t\t"); 	return TK_CONST_INT; }
{CONST_REAL}		{ printf("(CONSTANT REAL)\t\t"); 	return TK_CONST_REAL; }
{CONST_STRING}		{ printf("(CONSTANT STRING)\t"); 	return TK_CONST_STRING; }

"//"[^\n]*		/* eat line comments */

"/*"			BEGIN(comment);
<comment>[^*\n]*        /* eat anything that's not a '*' */
<comment>"*"+[^*/\n]*	/* eat up '*'s not followed by ')'s */
<comment>\n             ++line_num;
<comment>"*"+"/"        BEGIN(INITIAL);

[ \r\t]			/* skip whitespace */
\n 			++line_num;

<<EOF>> 		return EOF;

.             		{ printf(" unrecognised\t        ~Line %d: Token: %s - Lexical Error\n", line_num, yytext); }

%% /* User Code -------------------------------------------------------------------------------- */

int main() 
{
   int token;   
   while ( (token = yylex()) != EOF )
      printf("Line %d: Token %d: %s\n", line_num, token, yytext);   
}