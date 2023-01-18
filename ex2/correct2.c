  Line 3: Token (KEYWORLD CONST): const
  Line 3: Token (IDENTIFIER): message
  Line 3: Token (OP ASSIGNMENT): =
  Line 3: Token (CONSTANT STRING): "Type the number of the Fibonacci numbers: "
  Line 3: Token (KEYWORLD STRING): string
  Line 3: Token (SEMICOLON): ;
  Line 5: Token (KEYWORLD FUNC): func
  Line 5: Token (KEYWORLD BEGIN): begin
  Line 5: Token (LEFT PARENTHESIS): (
  Line 5: Token (RIGHT PARENTHESIS): )
  Line 5: Token (LEFT CRL BRACKET): {
  Line 6: Token (KEYWORLD VAR): var
  Line 6: Token (IDENTIFIER): i
  Line 6: Token (COMMA): ,
  Line 6: Token (IDENTIFIER): f0
  Line 6: Token (OP ASSIGNMENT): =
  Line 6: Token (CONSTANT INT): 0
  Line 6: Token (COMMA): ,
  Line 6: Token (IDENTIFIER): f1
  Line 6: Token (OP ASSIGNMENT): =
  Line 6: Token (CONSTANT INT): 1
  Line 6: Token (COMMA): ,
  Line 6: Token (IDENTIFIER): f
  Line 6: Token (COMMA): ,
  Line 6: Token (IDENTIFIER): n
  Line 6: Token (KEYWORLD INT): int
  Line 6: Token (SEMICOLON): ;
  Line 8: Token (writeString): writeString
  Line 8: Token (LEFT PARENTHESIS): (
  Line 8: Token (IDENTIFIER): message
  Line 8: Token (RIGHT PARENTHESIS): )
  Line 8: Token (SEMICOLON): ;
  Line 9: Token (IDENTIFIER): n
  Line 9: Token (OP ASSIGNMENT): =
  Line 9: Token (readInt): readInt
  Line 9: Token (LEFT PARENTHESIS): (
  Line 9: Token (RIGHT PARENTHESIS): )
  Line 9: Token (SEMICOLON): ;
  Line 11: Token (KEYWORLD FOR): for
  Line 11: Token (LEFT PARENTHESIS): (
  Line 11: Token (IDENTIFIER): i
  Line 11: Token (OP ASSIGNMENT): =
  Line 11: Token (CONSTANT INT): 1
  Line 11: Token (SEMICOLON): ;
  Line 11: Token (CONSTANT INT): 1
  Line 11: Token (OP LESS EQUAL): <=
  Line 11: Token (IDENTIFIER): n
  Line 11: Token (SEMICOLON): ;
  Line 11: Token (IDENTIFIER): i
  Line 11: Token (OP ASSIGNMENT): =
  Line 11: Token (IDENTIFIER): i
  Line 11: Token (OP PLUS): +
  Line 11: Token (CONSTANT INT): 1
  Line 11: Token (RIGHT PARENTHESIS): )
  Line 11: Token (LEFT CRL BRACKET): {
  Line 12: Token (IDENTIFIER): f
  Line 12: Token (OP ASSIGNMENT): =
  Line 12: Token (IDENTIFIER): f0
  Line 12: Token (OP PLUS): +
  Line 12: Token (IDENTIFIER): f1
  Line 12: Token (SEMICOLON): ;
  Line 13: Token (writeInt): writeInt
  Line 13: Token (LEFT PARENTHESIS): (
  Line 13: Token (IDENTIFIER): f
  Line 13: Token (RIGHT PARENTHESIS): )
  Line 13: Token (SEMICOLON): ;
  Line 14: Token (IDENTIFIER): f1
  Line 14: Token (OP ASSIGNMENT): =
  Line 14: Token (IDENTIFIER): f0
  Line 14: Token (SEMICOLON): ;
  Line 15: Token (IDENTIFIER): f0
  Line 15: Token (OP ASSIGNMENT): =
  Line 15: Token (IDENTIFIER): f1
  Line 15: Token (SEMICOLON): ;
  Line 16: Token (RIGHT CRL BRACKET): }
  Line 18: Token (KEYWORLD RETURN): return
  Line 18: Token (CONSTANT INT): 0
  Line 18: Token (SEMICOLON): ;
  Line 19: Token (RIGHT CRL BRACKET): }

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "pilib.h"

const char* message = "Type the number of the Fibonacci numbers: ";

int main() {
int i, f0 = 0, f1 = 1, f, n;
writeString(message);
n = readInt();
for(i = 1; 1 <= n; i = i + 1)
{
f = f0 + f1;
writeInt(f);
f1 = f0;
f0 = f1;
}

return 0;
}

/* Your program is syntactically correct! */
