/*
  Test of tokens for vhdl2verilog
  Copyright (C) 2017, Rodrigo A. Melo

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
 
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
 
  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

%{
#include <stdio.h>

#define YYSTYPE char *
%}

%token RW_ABS RW_ACCESS RW_AFTER RW_ALIAS RW_ALL RW_AND RW_ARCHITECTURE
%token RW_ARRAY RW_ASSERT RW_ATTRIBUTE RW_BEGIN RW_BLOCK RW_BODY RW_BUFFER
%token RW_BUS RW_CASE RW_COMPONENT RW_CONFIGURATION RW_CONSTANT RW_DISCONNECT
%token RW_DOWNTO RW_ELSE RW_ELSIF RW_END RW_ENTITY RW_EXIT RW_FILE RW_FOR
%token RW_FUNCTION RW_GENERATE RW_GENERIC RW_GROUP RW_GUARDED RW_IF RW_IMPURE
%token RW_IN RW_INERTIAL RW_INOUT RW_IS RW_LABEL RW_LIBRARY RW_LINKAGE
%token RW_LITERAL RW_LOOP RW_MAP RW_MOD RW_NAND RW_NEW RW_NEXT RW_NOR RW_NOT
%token RW_NULL RW_OF RW_ON RW_OPEN RW_OR RW_OTHERS RW_OUT RW_PACKAGE RW_PORT
%token RW_POSTPONED RW_PROCEDURE RW_PROCESS RW_PURE RW_RANGE RW_RECORD
%token RW_REGISTER RW_REJECT RW_REM RW_REPORT RW_RETURN RW_ROL RW_ROR RW_SELECT
%token RW_SEVERITY RW_SHARED RW_SIGNAL RW_SLA RW_SLL RW_SRA RW_SRL RW_SUBTYPE
%token RW_THEN RW_TO RW_TRANSPORT RW_TYPE RW_UNAFFECTED RW_UNITS RW_UNTIL
%token RW_USE RW_VARIABLE RW_WAIT RW_WHEN RW_WHILE RW_WITH RW_XNOR RW_XOR
%token IDENTIFIER NUMBER CHARACTER STRING BITSTRING
%token ARROW "=>" VASSIGN ":=" LE "<=" GE ">=" BOX "<>" NE "/=" EXP "**"

%%

start: %empty | start tokens

tokens:
       RW_ABS             { printf("Reserved Word\n");     }
     | RW_ACCESS          { printf("Reserved Word\n");     }
     | RW_AFTER           { printf("Reserved Word\n");     }
     | RW_ALIAS           { printf("Reserved Word\n");     }
     | RW_ALL             { printf("Reserved Word\n");     }
     | RW_AND             { printf("Reserved Word\n");     }
     | RW_ARCHITECTURE    { printf("Reserved Word\n");     }
     | RW_ARRAY           { printf("Reserved Word\n");     }
     | RW_ASSERT          { printf("Reserved Word\n");     }
     | RW_ATTRIBUTE       { printf("Reserved Word\n");     }
     | RW_BEGIN           { printf("Reserved Word\n");     }
     | RW_BLOCK           { printf("Reserved Word\n");     }
     | RW_BODY            { printf("Reserved Word\n");     }
     | RW_BUFFER          { printf("Reserved Word\n");     }
     | RW_BUS             { printf("Reserved Word\n");     }
     | RW_CASE            { printf("Reserved Word\n");     }
     | RW_COMPONENT       { printf("Reserved Word\n");     }
     | RW_CONFIGURATION   { printf("Reserved Word\n");     }
     | RW_CONSTANT        { printf("Reserved Word\n");     }
     | RW_DISCONNECT      { printf("Reserved Word\n");     }
     | RW_DOWNTO          { printf("Reserved Word\n");     }
     | RW_ELSE            { printf("Reserved Word\n");     }
     | RW_ELSIF           { printf("Reserved Word\n");     }
     | RW_END             { printf("Reserved Word\n");     }
     | RW_ENTITY          { printf("Reserved Word\n");     }
     | RW_EXIT            { printf("Reserved Word\n");     }
     | RW_FILE            { printf("Reserved Word\n");     }
     | RW_FOR             { printf("Reserved Word\n");     }
     | RW_FUNCTION        { printf("Reserved Word\n");     }
     | RW_GENERATE        { printf("Reserved Word\n");     }
     | RW_GENERIC         { printf("Reserved Word\n");     }
     | RW_GROUP           { printf("Reserved Word\n");     }
     | RW_GUARDED         { printf("Reserved Word\n");     }
     | RW_IF              { printf("Reserved Word\n");     }
     | RW_IMPURE          { printf("Reserved Word\n");     }
     | RW_IN              { printf("Reserved Word\n");     }
     | RW_INERTIAL        { printf("Reserved Word\n");     }
     | RW_INOUT           { printf("Reserved Word\n");     }
     | RW_IS              { printf("Reserved Word\n");     }
     | RW_LABEL           { printf("Reserved Word\n");     }
     | RW_LIBRARY         { printf("Reserved Word\n");     }
     | RW_LINKAGE         { printf("Reserved Word\n");     }
     | RW_LITERAL         { printf("Reserved Word\n");     }
     | RW_LOOP            { printf("Reserved Word\n");     }
     | RW_MAP             { printf("Reserved Word\n");     }
     | RW_MOD             { printf("Reserved Word\n");     }
     | RW_NAND            { printf("Reserved Word\n");     }
     | RW_NEW             { printf("Reserved Word\n");     }
     | RW_NEXT            { printf("Reserved Word\n");     }
     | RW_NOR             { printf("Reserved Word\n");     }
     | RW_NOT             { printf("Reserved Word\n");     }
     | RW_NULL            { printf("Reserved Word\n");     }
     | RW_OF              { printf("Reserved Word\n");     }
     | RW_ON              { printf("Reserved Word\n");     }
     | RW_OPEN            { printf("Reserved Word\n");     }
     | RW_OR              { printf("Reserved Word\n");     }
     | RW_OTHERS          { printf("Reserved Word\n");     }
     | RW_OUT             { printf("Reserved Word\n");     }
     | RW_PACKAGE         { printf("Reserved Word\n");     }
     | RW_PORT            { printf("Reserved Word\n");     }
     | RW_POSTPONED       { printf("Reserved Word\n");     }
     | RW_PROCEDURE       { printf("Reserved Word\n");     }
     | RW_PROCESS         { printf("Reserved Word\n");     }
     | RW_PURE            { printf("Reserved Word\n");     }
     | RW_RANGE           { printf("Reserved Word\n");     }
     | RW_RECORD          { printf("Reserved Word\n");     }
     | RW_REGISTER        { printf("Reserved Word\n");     }
     | RW_REJECT          { printf("Reserved Word\n");     }
     | RW_REM             { printf("Reserved Word\n");     }
     | RW_REPORT          { printf("Reserved Word\n");     }
     | RW_RETURN          { printf("Reserved Word\n");     }
     | RW_ROL             { printf("Reserved Word\n");     }
     | RW_ROR             { printf("Reserved Word\n");     }
     | RW_SELECT          { printf("Reserved Word\n");     }
     | RW_SEVERITY        { printf("Reserved Word\n");     }
     | RW_SHARED          { printf("Reserved Word\n");     }
     | RW_SIGNAL          { printf("Reserved Word\n");     }
     | RW_SLA             { printf("Reserved Word\n");     }
     | RW_SLL             { printf("Reserved Word\n");     }
     | RW_SRA             { printf("Reserved Word\n");     }
     | RW_SRL             { printf("Reserved Word\n");     }
     | RW_SUBTYPE         { printf("Reserved Word\n");     }
     | RW_THEN            { printf("Reserved Word\n");     }
     | RW_TO              { printf("Reserved Word\n");     }
     | RW_TRANSPORT       { printf("Reserved Word\n");     }
     | RW_TYPE            { printf("Reserved Word\n");     }
     | RW_UNAFFECTED      { printf("Reserved Word\n");     }
     | RW_UNITS           { printf("Reserved Word\n");     }
     | RW_UNTIL           { printf("Reserved Word\n");     }
     | RW_USE             { printf("Reserved Word\n");     }
     | RW_VARIABLE        { printf("Reserved Word\n");     }
     | RW_WAIT            { printf("Reserved Word\n");     }
     | RW_WHEN            { printf("Reserved Word\n");     }
     | RW_WHILE           { printf("Reserved Word\n");     }
     | RW_WITH            { printf("Reserved Word\n");     }
     | RW_XNOR            { printf("Reserved Word\n");     }
     | RW_XOR             { printf("Reserved Word\n");     }
     | IDENTIFIER         { printf("IDENTIFIER\n");        }
     | NUMBER             { printf("NUMBER\n");            }
     | CHARACTER          { printf("CHARACTER\n");         }
     | STRING             { printf("STRING\n");            }
     | BITSTRING          { printf("BITSTRING\n");         }
     | '&'                { printf("Delimiter\n");         }
     | '\''               { printf("Delimiter\n");         }
     | '('                { printf("Delimiter\n");         }
     | ')'                { printf("Delimiter\n");         }
     | '*'                { printf("Delimiter\n");         }
     | '+'                { printf("Delimiter\n");         }
     | ','                { printf("Delimiter\n");         }
     | '-'                { printf("Delimiter\n");         }
     | '.'                { printf("Delimiter\n");         }
     | '/'                { printf("Delimiter\n");         }
     | ':'                { printf("Delimiter\n");         }
     | ';'                { printf("Delimiter\n");         }
     | '<'                { printf("Delimiter\n");         }
     | '='                { printf("Delimiter\n");         }
     | '>'                { printf("Delimiter\n");         }
     | '|'                { printf("Delimiter\n");         }
     | '['                { printf("Delimiter\n");         }
     | ']'                { printf("Delimiter\n");         }
     | "=>"               { printf("Compund Delimiter\n"); }
     | "**"               { printf("Compund Delimiter\n"); }
     | ":="               { printf("Compund Delimiter\n"); }
     | "/="               { printf("Compund Delimiter\n"); }
     | ">="               { printf("Compund Delimiter\n"); }
     | "<="               { printf("Compund Delimiter\n"); }
     | "<>"               { printf("Compund Delimiter\n"); }

%%

main(int argc, char **argv) {
   yyparse();
}

yyerror(char *s) {
   fprintf(stderr, "error: %s\n", s);
}

