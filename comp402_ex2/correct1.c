  Line 3: Token (KEYWORLD CONST): const
  Line 3: Token (IDENTIFIER): message
  Line 3: Token (OP ASSIGNMENT): =
  Line 3: Token (CONSTANT STRING): "Type two positive integers: "
  Line 3: Token (KEYWORLD STRING): string
  Line 3: Token (SEMICOLON): ;
  Line 5: Token (KEYWORLD FUNC): func
  Line 5: Token (KEYWORLD BEGIN): begin
  Line 5: Token (LEFT PARENTHESIS): (
  Line 5: Token (RIGHT PARENTHESIS): )
  Line 5: Token (LEFT CRL BRACKET): {
  Line 6: Token (KEYWORLD VAR): var
  Line 6: Token (IDENTIFIER): a
  Line 6: Token (COMMA): ,
  Line 6: Token (IDENTIFIER): b
  Line 6: Token (COMMA): ,
  Line 6: Token (IDENTIFIER): c
  Line 6: Token (KEYWORLD INT): int
  Line 6: Token (SEMICOLON): ;
  Line 8: Token (writeString): writeString
  Line 8: Token (LEFT PARENTHESIS): (
  Line 8: Token (IDENTIFIER): message
  Line 8: Token (RIGHT PARENTHESIS): )
  Line 8: Token (SEMICOLON): ;
  Line 9: Token (IDENTIFIER): a
  Line 9: Token (OP ASSIGNMENT): =
  Line 9: Token (readInt): readInt
  Line 9: Token (LEFT PARENTHESIS): (
  Line 9: Token (RIGHT PARENTHESIS): )
  Line 9: Token (SEMICOLON): ;
  Line 10: Token (IDENTIFIER): b
  Line 10: Token (OP ASSIGNMENT): =
  Line 10: Token (readInt): readInt
  Line 10: Token (LEFT PARENTHESIS): (
  Line 10: Token (RIGHT PARENTHESIS): )
  Line 10: Token (SEMICOLON): ;
  Line 12: Token (IDENTIFIER): c
  Line 12: Token (OP ASSIGNMENT): =
  Line 12: Token (IDENTIFIER): findDifferene
  Line 12: Token (LEFT PARENTHESIS): (
  Line 12: Token (IDENTIFIER): a
  Line 12: Token (COMMA): ,
  Line 12: Token (IDENTIFIER): b
  Line 12: Token (RIGHT PARENTHESIS): )
  Line 12: Token (SEMICOLON): ;
  Line 14: Token (writeInt): writeInt
  Line 14: Token (LEFT PARENTHESIS): (
  Line 14: Token (IDENTIFIER): c
  Line 14: Token (RIGHT PARENTHESIS): )
  Line 14: Token (SEMICOLON): ;
  Line 16: Token (KEYWORLD RETURN): return
  Line 16: Token (CONSTANT INT): 0
  Line 16: Token (SEMICOLON): ;
  Line 17: Token (RIGHT CRL BRACKET): }
  Line 19: Token (KEYWORLD FUNC): func
  Line 19: Token (IDENTIFIER): findDifferene
  Line 19: Token (LEFT PARENTHESIS): (
  Line 19: Token (IDENTIFIER): a
  Line 19: Token (KEYWORLD INT): int
  Line 19: Token (COMMA): ,
  Line 19: Token (IDENTIFIER): b
  Line 19: Token (KEYWORLD INT): int
  Line 19: Token (RIGHT PARENTHESIS): )
  Line 19: Token (KEYWORLD INT): int
  Line 19: Token (LEFT CRL BRACKET): {
  Line 21: Token (KEYWORLD WHILE): while
  Line 21: Token (LEFT PARENTHESIS): (
  Line 21: Token (IDENTIFIER): a
  Line 21: Token (OP NOT EQUAL): !=
  Line 21: Token (IDENTIFIER): b
  Line 21: Token (RIGHT PARENTHESIS): )
  Line 21: Token (LEFT CRL BRACKET): {
  Line 22: Token (KEYWORLD IF): if
  Line 22: Token (LEFT PARENTHESIS): (
  Line 22: Token (IDENTIFIER): a
  Line 22: Token (OP GREATER): >
  Line 22: Token (IDENTIFIER): b
  Line 22: Token (RIGHT PARENTHESIS): )
  Line 23: Token (IDENTIFIER): a
  Line 23: Token (OP ASSIGNMENT): =
  Line 23: Token (IDENTIFIER): a
  Line 23: Token (OP MINUS): -
  Line 23: Token (IDENTIFIER): b
  Line 23: Token (SEMICOLON): ;
  Line 24: Token (KEYWORLD ELSE): else
  Line 25: Token (IDENTIFIER): a
  Line 25: Token (OP ASSIGNMENT): =
  Line 25: Token (IDENTIFIER): b
  Line 25: Token (OP MINUS): -
  Line 25: Token (IDENTIFIER): a
  Line 25: Token (SEMICOLON): ;
  Line 26: Token (RIGHT CRL BRACKET): }
  Line 27: Token (KEYWORLD RETURN): return
  Line 27: Token (IDENTIFIER): a
  Line 27: Token (SEMICOLON): ;
  Line 28: Token (RIGHT CRL BRACKET): }

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "pilib.h"

const char* message = "Type two positive integers: ";

int main() {
int a, b, c;
writeString(message);
a = readInt();
b = readInt();
c = findDifferene(a, b);
writeInt(c);
return 0;
}

int findDifferene(int a, int b ) {
while(a != b)
{
if(a > b)
a = a - b;
else
a = b - a;
}
return a; 
}

/* Your program is syntactically correct! */
