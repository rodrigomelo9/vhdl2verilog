%option noyywrap nodefault

%{
#include <string.h>
#include "example.tab.h"
%}

%%

[ \t\n] {;}
"<="    {return LEFT;}
"=>"    {return RIGHT;}
[0-9]+ { yylval=strdup(yytext); return NUMBER; }
. { return yytext[0]; }

%%
