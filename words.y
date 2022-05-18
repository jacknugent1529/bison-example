%code requires {
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "words.h"

extern int yylex();
extern int yyparse();

void yyerror(char* s);

}
// TODO: (at some point) should look into how bison handles memory

// declare the types to be used by bison
%union {
  char *word;
  word_ll *word_list;
}

/* tokens */
%token GO 
%token TO 
%token<word> WORD // WORD is of type word (i.e. char*)
%token EOL

/* phrase is of type word_list (i.e. linked list of words) */
%type<word_list> phrase 

/* go_cmd is also of type word_list. Note that this will not include "GO" because
 * when we call the appropriate function for the GO command it should be clear from
 * context that this is the GO command */
%type<word_list> go_cmd 

%%

/* For now, we only will properly parse the go command */
line
  : 
  | line go_cmd EOL { handle_go_cmd($2); }
  ;

/* First match the "GO" token and then return the value of the phrase that 
 * follows */
go_cmd
  : GO TO phrase { $$ = $3; }
  | GO phrase { $$ = $2; }
  ;
  

/* Parse a phrase recursively by "peeling off" the word on the right end 
 * repeatedly. When a singleton word list is reached (only one word left), 
 * instantiate a linked list. For all following words, append them to the 
 * linked list. */
phrase
  : WORD  { $$ = start_phrase($1); }
  | phrase WORD { $$ = append_to_phrase($1, $2); }
  ;

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
