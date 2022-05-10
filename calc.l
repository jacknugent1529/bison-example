%{
#include <stdio.h>
#include "calc.tab.h"
%}

%%

[0-9]+ { yylval = atoi(yytext); return NUM; }
"fib"  { return FIB; }
"("    { return L_PAREN; }
")"    { return R_PAREN; }
"+"    { return ADD; }
"-"    { return SUB; }
"*"    { return MUL; }
"/"    { return DIV; }
"^"    { return EXP; }
\n     { return EOL; }
[ \t]  { /* ignore whitespace */ }
.      { printf("Unknown character: %c\n", *yytext); }

%%
