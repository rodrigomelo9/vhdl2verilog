%{
#include <stdio.h>
%}

%define api.value.type {char *}

%token NUMBER
%token LEFT "<=" RIGHT "=>"

%%

start: %empty | start tokens

tokens:
       NUMBER "<=" NUMBER { 
          printf("%s <= %s\n",$1,$3);
          free($1);
          free($3);
       }
     | NUMBER "=>" NUMBER {
          printf("%s => %s\n",$1,$3);
          free($1);
          free($3);
       }
     | NUMBER '>' NUMBER  {
          printf("%s > %s\n",$1,$3);
          free($1);
          free($3);
       }
     | NUMBER '<' NUMBER  {
          printf("%s < %s\n",$1,$3);
          free($1);
          free($3);
       }

%%

main(int argc, char **argv) { yyparse(); }
yyerror(char *s) { fprintf(stderr, "error: %s\n", s); }

