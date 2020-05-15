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
"function"      {currpos+=yyleng; return(FUNCTION);}
"beginparams"   {currpos+=yyleng; return(BEGIN_PARAMS);}
"endparams"     {currpos+=yyleng; return(END_PARAMS);}
"beginlocals"   {currpos+=yyleng; return(BEGIN_LOCALS);}
"endlocals"     {currpos+=yyleng; return(END_LOCALS);}
"beginbody"     {currpos+=yyleng; return(BEGIN_BODY);}
"endbody"       {currpos+=yyleng; return(END_BODY);}
"integer"       {currpos+=yyleng; return(INTEGER);}
"array"         {currpos+=yyleng; return(ARRAY);}
"of"            {currpos+=yyleng; return(OF);}
"if"            {currpos+=yyleng; return(IF);}
"then"          {currpos+=yyleng; return(THEN);}
"endif"         {currpos+=yyleng; return(ENDIF);}
"else"          {currpos+=yyleng; return(ELSE);}
"while"         {currpos+=yyleng; return(WHILE);}
"do"            {currpos+=yyleng; return(DO);}
"for"           {currpos+=yyleng; return(FOR);}
"beginloop"     {currpos+=yyleng; return(BEGINLOOP);}
"endloop"       {currpos+=yyleng; return(ENDLOOP);}
"continue"      {currpos+=yyleng; return(CONTINUE);}
"read"          {currpos+=yyleng; return(READ);}
"write"         {currpos+=yyleng; return(WRITE);}
"and"           {currpos+=yyleng; return(AND);}
"or"            {currpos+=yyleng; return(OR);}
"not"           {currpos+=yyleng; return(NOT);}
"true"          {currpos+=yyleng; return(TRUE);}
"false"         {currpos+=yyleng; return(FALSE);}
"return"        {currpos+=yyleng; return(RETURN);}

"-"             {currpos+=yyleng; return(SUB);}
"+"             {currpos+=yyleng; return(ADD);}
"*"             {currpos+=yyleng; return(MULT);}
"/"             {currpos+=yyleng; return(DIV);}
"%"             {currpos+=yyleng; return(MOD);}


"=="            {currpos+=yyleng; return(EQ);}
"<>"            {currpos+=yyleng; return(NEQ);}
"<"             {currpos+=yyleng; return(LT);}
">"             {currpos+=yyleng; return(GT);}
"<="            {currpos+=yyleng; return(LTE);}
">="            {currpos+=yyleng; return(GTE);}

";"             {currpos+=yyleng; return(SEMICOLON);}
":"             {currpos+=yyleng; return(COLON);}
","             {currpos+=yyleng; return(COMMA);}
"("             {currpos+=yyleng; return(L_PAREN);}
")"             {currpos+=yyleng; return(R_PAREN);}
"["             {currpos+=yyleng; return(L_SQUARE_BRACKET);}
"]"             {currpos+=yyleng; return(R_SQUARE_BRACKET);}
":="            {currpos+=yyleng; return(ASSIGN);}

{NUMBER}                {currpos+=yyleng; countNums++; return(NUMBER);}
{IDENT_ERR1}            {printf("identifier \"%s\" must begin with a letter",yytext); currpos+=yyleng;}
{IDENT_ERR2}            {printf("identifier \"%s\" cannot end with an underscore",yytext); currpos+=yyleng;}
{IDENT}                 {currpos+=yyleng; return(IDENT);}

\n                      {currline++;currpos=1;}
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


