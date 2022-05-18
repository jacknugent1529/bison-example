%option noyywrap noinput nounput
%{
#include <stdio.h>
#include "words.tab.h"
#include "sds/sds.h"

%}

%%
    /* it's weird, but comments must be indented */

    /* create a token only at the beginning of the line (using the ^) */
^GO   { return GO; }

    /* create a token TO (note that this might be problematic in certain cases) */
TO   { return TO; }

    /* match groups of alphabetic characters and allocate a string on the stack */
[a-zA-Z]+    { 
    /* the yylval.word is an item from the union defined in the .y file */
    yylval.word = sdsnew(yytext); 
    return WORD;
}
\n     { return EOL; }
[ \t]  { /* ignore whitespace */ }

%%
