%{
#include "y.tab.h"
#include <stdio.h>
float string2float(char* str);
int countNums = 0;
int countOperators = 0;
int countParens = 0;
int countEquals = 0;
int currpos = 1;
int currline = 1;

%}

COMMENT ##.*
LETTER  [a-zA-Z]
DIGIT           [0-9]
INT             {DIGIT}+
FLOAT           {INT}?\.{INT}
NUMBER  {FLOAT}|{INT}
IDENT           {LETTER}+({LETTER}|{DIGIT}|[_])*({LETTER}|{DIGIT})*
IDENT_ERR1      ({DIGIT}|[_])({LETTER}|{DIGIT}|[_])*({LETTER}|{DIGIT})
IDENT_ERR2      {LETTER}+({LETTER}|{DIGIT}|[_])*[_]
%%

{COMMENT}
[ \t]+          {currpos+=yyleng;}
"function"      {return(FUNCTION);currpos+=yyleng;}
"beginparams"   {return(BEGIN_PARAMS);currpos+=yyleng;}
"endparams"     {return(END_PARAMS);currpos+=yyleng;}
"beginlocals"   {return(BEGIN_LOCALS);currpos+=yyleng;}
"endlocals"     {return(END_LOCALS);currpos+=yyleng;}
"beginbody"     {return(BEGIN_BODY);currpos+=yyleng;}
"endbody"       {return(END_BODY);currpos+=yyleng;}
"integer"       {return(INTEGER);currpos+=yyleng;}
"array"         {return(ARRAY);currpos+=yyleng;}
"of"            {return(OF);currpos+=yyleng;}
"if"            {return(IF);currpos+=yyleng;}
"then"          {return(THEN);currpos+=yyleng;}
"endif"         {return(ENDIF);currpos+=yyleng;}
"else"          {return(ELSE);currpos+=yyleng;}
"while"         {return(WHILE);currpos+=yyleng;}
"do"            {return(DO);currpos+=yyleng;}
"for"           {return(FOR);currpos+=yyleng;}
"beginloop"     {return(BEGINLOOP);currpos+=yyleng;}
"endloop"       {return(ENDLOOP);currpos+=yyleng;}
"continue"      {return(CONTINUE);currpos+=yyleng;}
"read"          {return(READ);currpos+=yyleng;}
"write"         {return(WRITE);currpos+=yyleng;}
"and"           {return(AND);currpos+=yyleng;}
"or"            {return(OR);currpos+=yyleng;}
"not"           {return(NOT);currpos+=yyleng;}
"true"          {return(TRUE);currpos+=yyleng;}
"false"         {return(FALSE);currpos+=yyleng;}
"return"        {return(RETURN);currpos+=yyleng;}

"-"             {return(SUB);currpos+=yyleng;}
"+"             {return(ADD);currpos+=yyleng;}
"*"             {return(MULT);currpos+=yyleng;}
"/"             {return(DIV);currpos+=yyleng;}
"%"             {return(MOD);currpos+=yyleng;}


"=="            {return(EQ);currpos+=yyleng;}
"<>"            {return(NEQ);currpos+=yyleng;}
"<"             {return(LT);currpos+=yyleng;}
">"             {return(GT);currpos+=yyleng;}
"<="            {return(LTE);currpos+=yyleng;}
">="            {return(GTE);currpos+=yyleng;}

";"             {return(SEMICOLON);currpos+=yyleng;}
":"             {return(COLON);currpos+=yyleng;}
","             {return(COMMA);currpos+=yyleng;}
"("             {return(L_PAREN);currpos+=yyleng;}
")"             {return(R_PAREN);currpos+=yyleng;}
"["             {return(L_SQUARE_BRACKET);currpos+=yyleng;}
"]"             {return(R_SQUARE_BRACKET);currpos+=yyleng;}
":="            {return(ASSIGN);currpos+=yyleng;}

{NUMBER}                {return(NUMBER); currpos+=yyleng;countNums++;}
{IDENT_ERR1}            {printf("identifier \"%s\" must begin with a letter",yytext); currpos+=yyleng;}
{IDENT_ERR2}            {printf("identifier \"%s\" cannot end with an underscore",yytext); currpos+=yyleng;}
{IDENT}                 {return(IDENT); currpos+=yyleng;}

\n                      {printf("|\n"); currline++;currpos=1;}
.               {printf("unrecognized character\n");currpos+=yyleng;return 1;}

%%

float string2float(char* str) {
        return 0.0f;
}

/*
int main(int argc, char *argv[]) {
        yyin = fopen(argv[1],"r");
        yylex();
        return 0;
}
*/

