%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <unistd.h>
	//#define YY_NO_UNPUT
	int yyparse();	
	extern FILE * yyin;
	extern int Cline;
	int yyerror(char * s);
	int yylex(void);
%}


%union {
	char * cVal;
	int iVal;
}



%error-verbose

%start program

%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY 
%token INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO FOR BEGINLOOP ENDLOOP 
%token CONTINUE READ WRITE AND OR  TRUE FALSE RETURN
%right NOT
%token NUMBER IDENT

%left SUB ADD MULT DIV MOD
%left EQ  LT GT LTE GTE
%right NEQ
%left SEMICOLON COLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET 
%right ASSIGN
%token <iVal> NUMBERS 
%token <cVal> IDENTS


%%

program:			function program
					{printf("program > function program \n");}
					|
					{printf("program > epsilon \n");};

function:			FUNCTION IDENT SEMICOLON BEGIN_PARAMS declare_loop END_PARAMS BEGIN_LOCALS declare_loop END_LOCALS BEGIN_BODY state_loop END_BODY
					{printf("function > FUNCTION IDENT SEMICOLON BEGIN_PARAMS declare_loop END_PARAMS BEGIN_LOCALS declare_loop END_LOCALS BEGIN_BODY state_loop END_BODY \n");};

declare_loop:		 declaration SEMICOLON declare_loop 
					{printf("declare_loop > declare_loop declaration SEMICOLON \n");}
					|
					{printf("declare_loop > epsilon \n");};

state_loop:			statement SEMICOLON state_loop2
					{printf("state_loop > statement SEMICOLON state_loop2 \n");};					
					
state_loop2:		statement SEMICOLON state_loop2
					{printf("declare_loop > statement SEMICOLON state_loop2 \n");}
					|
					{printf("state_loop2 > epsilon \n");};

declaration:		ident_loop COLON declare_detour INTEGER
					{printf("declaration > ident_loop COLON declare_detour INTEGER \n");};

declare_detour:		ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET declare_detour2 OF
					{printf("declare_detour > ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET declare_detour2 OF \n");}
					|
					{printf("declare_detour > epsilon\n");};

declare_detour2:	L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET
					{printf("declare_detour2 > L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET \n");}
					|
					{printf("declare_detour2 > epsilon \n");};

ident_loop:			IDENT COMMA ident_loop
					{printf("ident_loop > IDENT COMMA ident_loop \n");}
					|
					IDENT
					{printf("ident_loop > IDENT \n");};

statement:			s1
					{printf("statement > s1 \n");}
					|
					s2
					{printf("statement > s2 \n");}
					|
					s3
					{printf("statement > s3 \n");}
					|
					s4
					{printf("statement > s4 \n");}
					|
					s5
					{printf("statement > s5 \n");}
					|
					s6789
					{printf("statement > s6789 \n");};

s1:					var ASSIGN expression
					{printf("s1 > var ASSIGN expression \n");};

s2:					IF bool_expr THEN state_loop s2_1
					{printf("s2 > IF bool_expr THEN state_loop s2_1 \n");};
					
s2_1:				ENDIF 
					{printf("s2_1 > ENDIF \n");}
					|
					s2_2
					{printf("s2_1 > s2_2 \n");};

s2_2:				ELSE state_loop ENDIF
					{printf("s2_2 > ELSE state_loop ENDIF \n");};

s3:					WHILE bool_expr BEGINLOOP state_loop ENDLOOP
					{printf("s3 > WHILE bool_expr BEGINLOOP state_loop ENDLOOP \n");};

s4:					DO BEGINLOOP state_loop ENDLOOP WHILE bool_expr
					{printf("s4 > DO BEGINLOOP state_loop ENDLOOP WHILE bool_expr \n");};

s5:					FOR var ASSIGN NUMBER SEMICOLON bool_expr SEMICOLON var ASSIGN expression BEGINLOOP state_loop ENDLOOP
					{printf("s5 > FOR var ASSIGN NUMBER SEMICOLON bool_expr SEMICOLON var ASSIGN expression BEGINLOOP state_loop ENDLOOP \n");};

s6789:				READ var_loop
					{printf("s6789 > READ var_loop \n");}
					|
					WRITE var_loop
					{printf("s6789 > WRITE var_loop \n");}
					|
					CONTINUE
					{printf("s6789 > CONTINUE \n");}
					|
					RETURN expression
					{printf("s6789 > RETURN expression \n");};

var_loop:			var COMMA var_loop
					{printf("var_loop > var COMMA var_loop \n");}
					|
					var
					{printf("var_loop > var \n");};

bool_expr:			r_a_e rae_loop
					{printf("bool_expr > r_a_e rae_loop \n");};

rae_loop:			OR r_a_e rae_loop
					{printf("rae_loop > OR r_a_e rae_loop \n");}
					|
					{printf("rae_loop > epsilon \n");};

r_a_e:				r_e re_loop
					{printf("r_a_e > r_e re_loop \n");};

re_loop:			AND r_e re_loop
					{printf("re_loop > AND r_e re_loop \n");}
					|
					{printf("re_loop > epsilon \n");};

r_e:				NOT re_choice
					{printf("r_e > NOT re_choice \n");}
					|
					re_choice
					{printf("r_e > re_choice \n");};

re_choice:			L_PAREN bool_expr R_PAREN
					{printf("re_choice > L_PAREN bool_expr R_PAREN \n");}
					|
					TRUE
					{printf("re_choice > TRUE \n");}
					|
					FALSE
					{printf("re_choice > FALSE \n");}
					|
					expression comp expression
					{printf("re_choice > expression comp expression \n");};

comp:				EQ
					{printf("comp > EQ \n");}
					|
					NEQ
					{printf("comp > NEQ \n");}
					|
					LT
					{printf("comp > LT \n");}
					|
					GT
					{printf("comp > GT \n");}
					|
					LTE
					{printf("comp > LTE \n");}
					|
					GTE
					{printf("comp > GTE \n");};

expression:			mult_expr mult_expr_loop
					{printf("expression > mult_expr mult_expr_loop \n");};

mult_expr_loop:		ADD mult_expr mult_expr_loop
					{printf("mult_expr_loop > ADD mult_expr mult_expr_loop \n");}
					|
					SUB mult_expr mult_expr_loop
					{printf("mult_expr_loop > SUB mult_expr mult_expr_loop \n");}
					|
					{printf("mult_expr_loop > epsilon \n");};

mult_expr:			term term_loop
					{printf("mult_expr > term term_loop \n");};

term_loop:			MULT mult_expr
					{printf("term_loop > MULT mult_expr \n");}
					|
					DIV mult_expr
					{printf("term_loop > DIV mult_expr \n");}
					|
					MOD mult_expr
					{printf("term_loop > MOD mult_expr \n");}
					|
					{printf("term_loop > epsilon \n");};

term:				term1
					{printf("term > term1 \n");}
					|
					SUB term1
					{printf("term > SUB term1 \n");}
					|
					term2
					{printf("term > term2 \n");};

term1:				var
					{printf("term1 > var \n");}
					|
					NUMBER
					{printf("term1 > NUMBER \n");}
					|
					L_PAREN expression R_PAREN
					{printf("term1 > L_PAREN expression R_PAREN \n");};

term2:				IDENT L_PAREN term2_1 R_PAREN
					{printf("term2 > IDENT L_PAREN term2_1 R_PAREN \n");};

term2_1:			expression term2_2
					{printf("term2_1 > expression term2_2 \n");}
					|
					{printf("term2_1 > epsilon \n");};

term2_2:			COMMA term2_1
					{printf("term2_2 > COMMA term2_1 \n");}
					|
					{printf("term2_2 > epsilon \n");};

var:				IDENT
					{printf("var > IDENT \n");}
					|
					IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET var_detour
					{printf("var > IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET var_detour \n");};

var_detour:			L_SQUARE_BRACKET expression R_SQUARE_BRACKET
					{printf("var_detour > L_SQUARE_BRACKET expression R_SQUARE_BRACKET \n");};
					|
					{printf("var_detour > epsilon \n");};

%%

int main (int argc, char ** argv) {
	if(argc >= 2) {
		yyin = fopen(argv[1], "r");
		if (yyin == NULL) {
			yyin = stdin;
		}
	} else {
		yyin = stdin;
	}
	yyparse();
	sleep(1); 
}


int yyerror(char *s)
{
extern int currline;
extern int currpos;
    printf(">>> Line %d, position %d: %s\n",currline,currpos,s);
}

