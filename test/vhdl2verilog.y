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

%%

start: %empty | start tokens

tokens:
       RW_ABS             { printf("RESERVED WORD\n"); }
     | RW_ACCESS          { printf("RESERVED WORD\n"); }
     | RW_AFTER           { printf("RESERVED WORD\n"); }
     | RW_ALIAS           { printf("RESERVED WORD\n"); }
     | RW_ALL             { printf("RESERVED WORD\n"); }
     | RW_AND             { printf("RESERVED WORD\n"); }
     | RW_ARCHITECTURE    { printf("RESERVED WORD\n"); }
     | RW_ARRAY           { printf("RESERVED WORD\n"); }
     | RW_ASSERT          { printf("RESERVED WORD\n"); }
     | RW_ATTRIBUTE       { printf("RESERVED WORD\n"); }
     | RW_BEGIN           { printf("RESERVED WORD\n"); }
     | RW_BLOCK           { printf("RESERVED WORD\n"); }
     | RW_BODY            { printf("RESERVED WORD\n"); }
     | RW_BUFFER          { printf("RESERVED WORD\n"); }
     | RW_BUS             { printf("RESERVED WORD\n"); }
     | RW_CASE            { printf("RESERVED WORD\n"); }
     | RW_COMPONENT       { printf("RESERVED WORD\n"); }
     | RW_CONFIGURATION   { printf("RESERVED WORD\n"); }
     | RW_CONSTANT        { printf("RESERVED WORD\n"); }
     | RW_DISCONNECT      { printf("RESERVED WORD\n"); }
     | RW_DOWNTO          { printf("RESERVED WORD\n"); }
     | RW_ELSE            { printf("RESERVED WORD\n"); }
     | RW_ELSIF           { printf("RESERVED WORD\n"); }
     | RW_END             { printf("RESERVED WORD\n"); }
     | RW_ENTITY          { printf("RESERVED WORD\n"); }
     | RW_EXIT            { printf("RESERVED WORD\n"); }
     | RW_FILE            { printf("RESERVED WORD\n"); }
     | RW_FOR             { printf("RESERVED WORD\n"); }
     | RW_FUNCTION        { printf("RESERVED WORD\n"); }
     | RW_GENERATE        { printf("RESERVED WORD\n"); }
     | RW_GENERIC         { printf("RESERVED WORD\n"); }
     | RW_GROUP           { printf("RESERVED WORD\n"); }
     | RW_GUARDED         { printf("RESERVED WORD\n"); }
     | RW_IF              { printf("RESERVED WORD\n"); }
     | RW_IMPURE          { printf("RESERVED WORD\n"); }
     | RW_IN              { printf("RESERVED WORD\n"); }
     | RW_INERTIAL        { printf("RESERVED WORD\n"); }
     | RW_INOUT           { printf("RESERVED WORD\n"); }
     | RW_IS              { printf("RESERVED WORD\n"); }
     | RW_LABEL           { printf("RESERVED WORD\n"); }
     | RW_LIBRARY         { printf("RESERVED WORD\n"); }
     | RW_LINKAGE         { printf("RESERVED WORD\n"); }
     | RW_LITERAL         { printf("RESERVED WORD\n"); }
     | RW_LOOP            { printf("RESERVED WORD\n"); }
     | RW_MAP             { printf("RESERVED WORD\n"); }
     | RW_MOD             { printf("RESERVED WORD\n"); }
     | RW_NAND            { printf("RESERVED WORD\n"); }
     | RW_NEW             { printf("RESERVED WORD\n"); }
     | RW_NEXT            { printf("RESERVED WORD\n"); }
     | RW_NOR             { printf("RESERVED WORD\n"); }
     | RW_NOT             { printf("RESERVED WORD\n"); }
     | RW_NULL            { printf("RESERVED WORD\n"); }
     | RW_OF              { printf("RESERVED WORD\n"); }
     | RW_ON              { printf("RESERVED WORD\n"); }
     | RW_OPEN            { printf("RESERVED WORD\n"); }
     | RW_OR              { printf("RESERVED WORD\n"); }
     | RW_OTHERS          { printf("RESERVED WORD\n"); }
     | RW_OUT             { printf("RESERVED WORD\n"); }
     | RW_PACKAGE         { printf("RESERVED WORD\n"); }
     | RW_PORT            { printf("RESERVED WORD\n"); }
     | RW_POSTPONED       { printf("RESERVED WORD\n"); }
     | RW_PROCEDURE       { printf("RESERVED WORD\n"); }
     | RW_PROCESS         { printf("RESERVED WORD\n"); }
     | RW_PURE            { printf("RESERVED WORD\n"); }
     | RW_RANGE           { printf("RESERVED WORD\n"); }
     | RW_RECORD          { printf("RESERVED WORD\n"); }
     | RW_REGISTER        { printf("RESERVED WORD\n"); }
     | RW_REJECT          { printf("RESERVED WORD\n"); }
     | RW_REM             { printf("RESERVED WORD\n"); }
     | RW_REPORT          { printf("RESERVED WORD\n"); }
     | RW_RETURN          { printf("RESERVED WORD\n"); }
     | RW_ROL             { printf("RESERVED WORD\n"); }
     | RW_ROR             { printf("RESERVED WORD\n"); }
     | RW_SELECT          { printf("RESERVED WORD\n"); }
     | RW_SEVERITY        { printf("RESERVED WORD\n"); }
     | RW_SHARED          { printf("RESERVED WORD\n"); }
     | RW_SIGNAL          { printf("RESERVED WORD\n"); }
     | RW_SLA             { printf("RESERVED WORD\n"); }
     | RW_SLL             { printf("RESERVED WORD\n"); }
     | RW_SRA             { printf("RESERVED WORD\n"); }
     | RW_SRL             { printf("RESERVED WORD\n"); }
     | RW_SUBTYPE         { printf("RESERVED WORD\n"); }
     | RW_THEN            { printf("RESERVED WORD\n"); }
     | RW_TO              { printf("RESERVED WORD\n"); }
     | RW_TRANSPORT       { printf("RESERVED WORD\n"); }
     | RW_TYPE            { printf("RESERVED WORD\n"); }
     | RW_UNAFFECTED      { printf("RESERVED WORD\n"); }
     | RW_UNITS           { printf("RESERVED WORD\n"); }
     | RW_UNTIL           { printf("RESERVED WORD\n"); }
     | RW_USE             { printf("RESERVED WORD\n"); }
     | RW_VARIABLE        { printf("RESERVED WORD\n"); }
     | RW_WAIT            { printf("RESERVED WORD\n"); }
     | RW_WHEN            { printf("RESERVED WORD\n"); }
     | RW_WHILE           { printf("RESERVED WORD\n"); }
     | RW_WITH            { printf("RESERVED WORD\n"); }
     | RW_XNOR            { printf("RESERVED WORD\n"); }
     | RW_XOR             { printf("RESERVED WORD\n"); }
     | IDENTIFIER         { printf("IDENTIFIER\n"); }
     | NUMBER             { printf("NUMBER\n"); }
     | CHARACTER          { printf("CHARACTER\n"); }
     | STRING             { printf("STRING\n"); }
     | BITSTRING          { printf("BITSTRING\n"); }
     | '+'                { printf("Simple Operand\n"); }
     | '-'                { printf("Simple Operand\n"); }
     | '*'                { printf("Simple Operand\n"); }
     | '/'                { printf("Simple Operand\n"); }
     | "**"               { printf("Double Operand\n"); }
     | "<="               { printf("Double Operand\n"); }
     | "=>"               { printf("Double Operand\n"); }

%%

main(int argc, char **argv) {
   yyparse();
}

yyerror(char *s) {
   fprintf(stderr, "error: %s\n", s);
}

