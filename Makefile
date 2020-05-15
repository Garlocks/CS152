parser:		mini_l.lex
		flex mini_l.lex
		gcc -o lexer lex.yy.c -lfl

clean:
		rm -f lex.yy.c lexer *.tab.c *.tab.h *.output parser

fibonacci:
		flex mini_l.lex
		gcc -o lexer lex.yy.c -lfl
		cat fibonacci.min | ./lexer

mytest:
		flex mini_l.lex
		gcc -o lexer lex.yy.c -lfl
		cat mytest.min | ./lexer

primes:
		flex mini_l.lex
		gcc -o lexer lex.yy.c -lfl
		cat primes.min | ./lexer

bison:
		bison -d -v --file-prefix=y  mini_l.y
		flex mini_l.lex
		gcc -o parser y.tab.c lex.yy.c -lfl

test:
		cat primes.min | parser
