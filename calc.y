%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "calculate.h"

extern int yylex();
extern int yyparse();

void yyerror(char* s);

%}

/* tokens */
%token NUM
%token FIB
%token L_PAREN R_PAREN
%token ADD SUB MUL DIV EXP
%token EOL

%%

line:
    | line addsub EOL { printf("%d\n", $2); }
    ;


addsub: multdiv
      | addsub ADD multdiv { $$ = add($1, $3); }
      | addsub SUB multdiv { $$ = sub($1, $3); }
      ;

multdiv: neg
       | multdiv DIV neg { $$ = divide($1, $3); }
       | multdiv MUL neg { $$ = mul($1, $3); }
       ;

neg: fib
   | SUB fib { $$ = neg($2); }
   
fib : exp
    | FIB exp { $$ = fib($2); }

exp: paren
   | paren EXP exp   { $$ = pow($1, $3); }

paren: NUM
     | L_PAREN addsub R_PAREN { $$ = $2; }


%%

int main(int argc, char **argv)
{
  yyparse();

  return 0;
}

void yyerror(char *s)
{
  fprintf(stderr, "parse error: %s\n", s);
  exit(1);
}
