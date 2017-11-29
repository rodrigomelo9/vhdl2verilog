/*
  vhdl2verilog, VHDL (93) to Verilog (2001) translator
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
#include <stdlib.h>
%}

// The 97 reserved words
%token RW_ABS            RW_ACCESS         RW_AFTER          RW_ALIAS
%token RW_ALL            RW_AND            RW_ARCHITECTURE   RW_ARRAY
%token RW_ASSERT         RW_ATTRIBUTE      RW_BEGIN          RW_BLOCK
%token RW_BODY           RW_BUFFER         RW_BUS            RW_CASE
%token RW_COMPONENT      RW_CONFIGURATION  RW_CONSTANT       RW_DISCONNECT
%token RW_DOWNTO         RW_ELSE           RW_ELSIF          RW_END
%token RW_ENTITY         RW_EXIT           RW_FILE           RW_FOR
%token RW_FUNCTION       RW_GENERATE       RW_GENERIC        RW_GROUP
%token RW_GUARDED        RW_IF             RW_IMPURE         RW_IN
%token RW_INERTIAL       RW_INOUT          RW_IS             RW_LABEL
%token RW_LIBRARY        RW_LINKAGE        RW_LITERAL        RW_LOOP
%token RW_MAP            RW_MOD            RW_NAND           RW_NEW
%token RW_NEXT           RW_NOR            RW_NOT            RW_NULL
%token RW_OF             RW_ON             RW_OPEN           RW_OR
%token RW_OTHERS         RW_OUT            RW_PACKAGE        RW_PORT
%token RW_POSTPONED      RW_PROCEDURE      RW_PROCESS        RW_PURE
%token RW_RANGE          RW_RECORD         RW_REGISTER       RW_REJECT
%token RW_REM            RW_REPORT         RW_RETURN         RW_ROL
%token RW_ROR            RW_SELECT         RW_SEVERITY       RW_SHARED
%token RW_SIGNAL         RW_SLA            RW_SLL            RW_SRA
%token RW_SRL            RW_SUBTYPE        RW_THEN           RW_TO
%token RW_TRANSPORT      RW_TYPE           RW_UNAFFECTED     RW_UNITS
%token RW_UNTIL          RW_USE            RW_VARIABLE       RW_WAIT
%token RW_WHEN           RW_WHILE          RW_WITH           RW_XNOR
%token RW_XOR

// Compound delimiters
%token ARROW "=>" VASSIGN ":=" LE "<=" GE ">=" BOX "<>" NE "/=" POW "**"

// Other lexical elements
%token IDENTIFIER ABSTRACT_LITERAL CHARACTER_LITERAL STRING_LITERAL BIT_STRING_LITERAL

%start design_file

%%

entity_declaration :
       RW_ENTITY IDENTIFIER RW_IS entity_header entity_declarative_part entity_declaration_opt1 RW_END entity_declaration_opt2 identifier_opt1 ';'

entity_declaration_opt1 :
       /* empty */
     | RW_BEGIN entity_statement_part

entity_declaration_opt2 :
       /* empty */
     | RW_ENTITY

identifier_opt1 :
       /* empty */
     | IDENTIFIER

identifier_opt2 :
       /* empty */
     | IDENTIFIER ':'

entity_header :
       entity_header_opt1 entity_header_opt2

entity_header_opt1 :
       /* empty */
     | RW_GENERIC '(' interface_list ')' ';'

entity_header_opt2 :
       /* empty */
     | RW_PORT '(' interface_list ')' ';'

entity_declarative_part :
       /* empty */
     | entity_declarative_part entity_declarative_item

entity_declarative_item :
       subprogram_declaration
     | subprogram_body
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | signal_declaration
     | variable_declaration
     | file_declaration
     | alias_declaration
     | attribute_declaration
     | attribute_specification
     | disconnection_specification
     | use_clause
     | group_template_declaration
     | group_declaration

entity_statement_part :
       /* empty */
     | entity_statement_part entity_statement

entity_statement :
       concurrent_assertion_statement
     | concurrent_procedure_call_statement
     | process_statement

architecture_body :
       RW_ARCHITECTURE IDENTIFIER RW_OF name RW_IS architecture_declarative_part RW_BEGIN architecture_statement_part RW_END architecture_body_opt1 identifier_opt1 ';'

architecture_body_opt1 :
       /* empty */
     | RW_ARCHITECTURE

architecture_declarative_part :
       /* empty */
     | architecture_declarative_part block_declarative_item

block_declarative_item :
       subprogram_declaration
     | subprogram_body
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | signal_declaration
     | variable_declaration
     | file_declaration
     | alias_declaration
     | component_declaration
     | attribute_declaration
     | attribute_specification
     | configuration_specification
     | disconnection_specification
     | use_clause
     | group_template_declaration
     | group_declaration

architecture_statement_part :
       /* empty */
     | architecture_statement_part concurrent_statement

configuration_declaration :
       RW_CONFIGURATION IDENTIFIER RW_OF name RW_IS configuration_declarative_part block_configuration RW_END configuration_declaration_opt1 identifier_opt1 ';'

configuration_declaration_opt1 :
       /* empty */
     | RW_CONFIGURATION

configuration_declarative_part :
       /* empty */
     | configuration_declarative_part configuration_declarative_item

configuration_declarative_item :
       use_clause
     | attribute_specification
     | group_declaration

block_configuration :
       RW_FOR block_specification block_configuration_opt1 block_configuration_opt3 RW_END RW_FOR ';'

block_configuration_opt1 :
       /* empty */
     | block_configuration_opt1 use_clause

block_configuration_opt3 :
       /* empty */
     | block_configuration_opt3 configuration_item

block_specification :
       name
     | IDENTIFIER
     | IDENTIFIER '(' index_specification ')'

index_specification :
       discrete_range
     | expression

configuration_item :
       block_configuration
     | component_configuration

component_configuration :
       RW_FOR component_specification component_configuration_opt1 component_configuration_opt2 RW_END RW_FOR ';'

component_configuration_opt1 :
       /* empty */
     | binding_indication ';'

component_configuration_opt2 :
       /* empty */
     | block_configuration

subprogram_declaration :
       subprogram_specification ';'

subprogram_specification :
       RW_PROCEDURE designator subprogram_specification_opt1
     | subprogram_specification_opt2 RW_FUNCTION designator subprogram_specification_opt3 RW_RETURN name

subprogram_specification_opt1 :
       /* empty */
     | '(' interface_list ')'

subprogram_specification_opt2 :
       /* empty */
     | RW_PURE
     | RW_IMPURE

subprogram_specification_opt3 :
       /* empty */
     | '(' interface_list ')'

designator :
       IDENTIFIER
     | STRING_LITERAL

subprogram_body :
       subprogram_specification RW_IS subprogram_declarative_part RW_BEGIN subprogram_statement_part RW_END subprogram_body_opt1 subprogram_body_opt2 ';'

subprogram_body_opt1 :
       /* empty */
     | subprogram_kind

subprogram_body_opt2 :
       /* empty */
     | designator

subprogram_declarative_part :
       /* empty */
     | subprogram_declarative_part subprogram_declarative_item

subprogram_declarative_item :
       subprogram_declaration
     | subprogram_body
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | variable_declaration
     | file_declaration
     | alias_declaration
     | attribute_declaration
     | attribute_specification
     | use_clause
     | group_template_declaration
     | group_declaration

subprogram_statement_part :
       /* empty */
     | subprogram_statement_part sequential_statement

subprogram_kind :
       RW_PROCEDURE
     | RW_FUNCTION

signature :
       '[' signature_opt1 signature_opt2 ']'

signature_opt1 :
       /* empty */
     | name signature_opt3

signature_opt2 :
       /* empty */
     | RW_RETURN name

signature_opt3 :
       /* empty */
     | signature_opt3 ',' name

package_declaration :
       RW_PACKAGE IDENTIFIER RW_IS package_declarative_part RW_END package_declaration_opt1 identifier_opt1 ';'

package_declaration_opt1 :
       /* empty */
     | RW_PACKAGE

package_declarative_part :
       /* empty */
     | package_declarative_part package_declarative_item

package_declarative_item :
       subprogram_declaration
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | signal_declaration
     | variable_declaration
     | file_declaration
     | alias_declaration
     | component_declaration
     | attribute_declaration
     | attribute_specification
     | disconnection_specification
     | use_clause
     | group_template_declaration
     | group_declaration

package_body :
       RW_PACKAGE RW_BODY IDENTIFIER RW_IS package_body_declarative_part RW_END package_body_opt1 identifier_opt1 ';'

package_body_opt1 :
       /* empty */
     | RW_PACKAGE RW_BODY

package_body_declarative_part :
       /* empty */
     | package_body_declarative_part package_body_declarative_item

package_body_declarative_item :
       subprogram_declaration
     | subprogram_body
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | variable_declaration
     | file_declaration
     | alias_declaration
     | use_clause
     | group_template_declaration
     | group_declaration

scalar_type_definition :
       enumeration_type_definition
     | RW_RANGE range
     | physical_type_definition

range :
       attribute_name
     | simple_expression direction simple_expression

direction :
       RW_TO
     | RW_DOWNTO

enumeration_type_definition :
       '(' enumeration_literal enumeration_type_definition_opt1 ')'

enumeration_type_definition_opt1 :
       /* empty */
     | enumeration_type_definition_opt1 ',' enumeration_literal

enumeration_literal :
       IDENTIFIER
     | CHARACTER_LITERAL

physical_type_definition :
       RW_RANGE range RW_UNITS IDENTIFIER physical_type_definition_opt2 RW_END RW_UNITS identifier_opt1

physical_type_definition_opt2 :
       /* empty */
     | physical_type_definition_opt2 IDENTIFIER '=' physical_literal ';'

physical_literal :
       physical_literal_opt1 name

physical_literal_opt1 :
       /* empty */
     | ABSTRACT_LITERAL

composite_type_definition :
       array_type_definition
     | record_type_definition

array_type_definition :
       unconstrained_array_definition
     | constrained_array_definition

unconstrained_array_definition :
       RW_ARRAY '(' name RW_RANGE "<>" unconstrained_array_definition_opt1 ')' RW_OF subtype_indication

unconstrained_array_definition_opt1 :
       /* empty */
     | unconstrained_array_definition_opt1 ',' name RW_RANGE "<>"

constrained_array_definition :
       RW_ARRAY index_constraint RW_OF subtype_indication

index_constraint :
       '(' discrete_range index_constraint_opt1 ')'

index_constraint_opt1 :
       /* empty */
     | index_constraint_opt1 ',' discrete_range

discrete_range :
       subtype_indication
     | range

record_type_definition :
       RW_RECORD element_declaration record_type_definition_opt2 RW_END RW_RECORD identifier_opt1

record_type_definition_opt2 :
       /* empty */
     | record_type_definition_opt2 element_declaration

element_declaration :
       identifier_list ':' subtype_indication ';'

identifier_list :
       IDENTIFIER identifier_list_opt1

identifier_list_opt1 :
       /* empty */
     | identifier_list_opt1 ',' IDENTIFIER

type_declaration :
       RW_TYPE IDENTIFIER RW_IS type_definition ';'
     | RW_TYPE IDENTIFIER ';'

type_definition :
       scalar_type_definition
     | composite_type_definition
     | RW_ACCESS subtype_indication
     | RW_FILE RW_OF name

subtype_declaration :
       RW_SUBTYPE IDENTIFIER RW_IS subtype_indication ';'

subtype_indication :
       name subtype_indication_opt2
     | name name subtype_indication_opt2

subtype_indication_opt2 :
       /* empty */
     | constraint

constraint :
       RW_RANGE range
     | index_constraint

constant_declaration :
       RW_CONSTANT identifier_list ':' subtype_indication constant_declaration_opt1 ';'

constant_declaration_opt1 :
       /* empty */
     | ":=" expression

signal_declaration :
       RW_SIGNAL identifier_list ':' subtype_indication signal_declaration_opt1 signal_declaration_opt2 ';'

signal_declaration_opt1 :
       /* empty */
     | signal_kind

signal_declaration_opt2 :
       /* empty */
     | ":=" expression

signal_kind :
       RW_REGISTER
     | RW_BUS

variable_declaration :
       variable_declaration_opt1 RW_VARIABLE identifier_list ':' subtype_indication variable_declaration_opt2 ';'

variable_declaration_opt1 :
       /* empty */
     | RW_SHARED

variable_declaration_opt2 :
       /* empty */
     | ":=" expression

file_declaration :
       RW_FILE identifier_list ':' subtype_indication file_declaration_opt1 ';'

file_declaration_opt1 :
       /* empty */
     | file_open_information

file_open_information :
       file_open_information_opt1 RW_IS expression

file_open_information_opt1 :
       /* empty */
     | RW_OPEN expression

interface_declaration :
       interface_constant_declaration
     | interface_signal_declaration
     | interface_variable_declaration
     | interface_file_declaration

interface_constant_declaration :
       identifier_list ':' interface_constant_declaration_opt2 subtype_indication interface_constant_declaration_opt3
     | RW_CONSTANT identifier_list ':' interface_constant_declaration_opt2 subtype_indication interface_constant_declaration_opt3

interface_constant_declaration_opt2 :
       /* empty */
     | RW_IN

interface_constant_declaration_opt3 :
       /* empty */
     | ":=" expression

interface_signal_declaration :
       identifier_list ':' interface_signal_declaration_opt2 subtype_indication interface_signal_declaration_opt3 interface_signal_declaration_opt4
     | RW_SIGNAL identifier_list ':' interface_signal_declaration_opt2 subtype_indication interface_signal_declaration_opt3 interface_signal_declaration_opt4

interface_signal_declaration_opt2 :
       /* empty */
     | mode

interface_signal_declaration_opt3 :
       /* empty */
     | RW_BUS

interface_signal_declaration_opt4 :
       /* empty */
     | ":=" expression

interface_variable_declaration :
       identifier_list ':' interface_variable_declaration_opt2 subtype_indication interface_variable_declaration_opt3
     | RW_VARIABLE identifier_list ':' interface_variable_declaration_opt2 subtype_indication interface_variable_declaration_opt3

interface_variable_declaration_opt2 :
       /* empty */
     | mode

interface_variable_declaration_opt3 :
       /* empty */
     | ":=" expression

interface_file_declaration :
       RW_FILE identifier_list subtype_indication

mode :
       RW_IN
     | RW_OUT
     | RW_INOUT
     | RW_BUFFER
     | RW_LINKAGE

interface_list :
       interface_declaration interface_list_opt1

interface_list_opt1 :
       /* empty */
     | interface_list_opt1 ';' interface_declaration

association_list :
       association_element association_list_opt1

association_list_opt1 :
       /* empty */
     | association_list_opt1 ',' association_element

association_element :
       association_element_opt1 actual_part

association_element_opt1 :
       /* empty */
     | formal_part "=>"

formal_part :
       name
     | name '(' name ')'

actual_part :
       actual_designator
     | name '(' actual_designator ')'

actual_designator :
       expression
     | name
     | RW_OPEN

alias_declaration :
       RW_ALIAS alias_designator alias_declaration_opt1 RW_IS name alias_declaration_opt2 ';'

alias_declaration_opt1 :
       /* empty */
     | ':' subtype_indication

alias_declaration_opt2 :
       /* empty */
     | signature

alias_designator :
       IDENTIFIER
     | CHARACTER_LITERAL
     | STRING_LITERAL

attribute_declaration :
       RW_ATTRIBUTE IDENTIFIER ':' name ';'

component_declaration :
       RW_COMPONENT IDENTIFIER component_declaration_opt1 component_declaration_opt2 component_declaration_opt3 RW_END RW_COMPONENT identifier_opt1 ';'

component_declaration_opt1 :
       /* empty */
     | RW_IS

component_declaration_opt2 :
       /* empty */
     | RW_GENERIC '(' interface_list ')' ';'

component_declaration_opt3 :
       /* empty */
     | RW_PORT '(' interface_list ')' ';'

group_template_declaration :
       RW_GROUP IDENTIFIER RW_IS '(' entity_class_entry_list ')' ';'

entity_class_entry_list :
       entity_class_entry entity_class_entry_list_opt1

entity_class_entry_list_opt1 :
       /* empty */
     | entity_class_entry_list_opt1 ',' entity_class_entry

entity_class_entry :
       entity_class entity_class_entry_opt1

entity_class_entry_opt1 :
       /* empty */
     | "<>"

group_declaration :
       RW_GROUP IDENTIFIER ':' name '(' group_constituent_list ')' ';'

group_constituent_list :
       group_constituent group_constituent_list_opt1

group_constituent_list_opt1 :
       /* empty */
     | group_constituent_list_opt1 ',' group_constituent

group_constituent :
       name
     | CHARACTER_LITERAL

attribute_specification :
       RW_ATTRIBUTE IDENTIFIER RW_OF entity_name_list ':' entity_class RW_IS expression ';'

entity_class :
       RW_ENTITY
     | RW_ARCHITECTURE
     | RW_CONFIGURATION
     | RW_PROCEDURE
     | RW_FUNCTION
     | RW_PACKAGE
     | RW_TYPE
     | RW_SUBTYPE
     | RW_CONSTANT
     | RW_SIGNAL
     | RW_VARIABLE
     | RW_COMPONENT
     | RW_LABEL
     | RW_LITERAL
     | RW_UNITS
     | RW_GROUP
     | RW_FILE

entity_name_list :
       entity_designator entity_name_list_opt1
     | RW_OTHERS
     | RW_ALL

entity_name_list_opt1 :
       /* empty */
     | entity_name_list_opt1 ',' entity_designator

entity_designator :
       entity_tag entity_designator_opt1

entity_designator_opt1 :
       /* empty */
     | signature

entity_tag :
       IDENTIFIER
     | CHARACTER_LITERAL
     | STRING_LITERAL

configuration_specification :
       RW_FOR component_specification binding_indication ';'

component_specification :
       instantiation_list ':' name

instantiation_list :
       IDENTIFIER instantiation_list_opt1
     | RW_OTHERS
     | RW_ALL

instantiation_list_opt1 :
       /* empty */
     | instantiation_list_opt1 ',' IDENTIFIER

binding_indication :
       binding_indication_opt1 binding_indication_opt2 binding_indication_opt3

binding_indication_opt1 :
       /* empty */
     | RW_USE entity_aspect

binding_indication_opt2 :
       /* empty */
     | RW_GENERIC RW_MAP '(' association_list ')'

binding_indication_opt3 :
       /* empty */
     | RW_PORT RW_MAP '(' association_list ')'

entity_aspect :
       RW_ENTITY name entity_aspect_opt1
     | RW_CONFIGURATION name
     | RW_OPEN

entity_aspect_opt1 :
       /* empty */
     | '(' IDENTIFIER ')'

disconnection_specification :
       RW_DISCONNECT signal_list ':' name RW_AFTER expression ';'

signal_list :
       name signal_list_opt1
     | RW_OTHERS
     | RW_ALL

signal_list_opt1 :
       /* empty */
     | signal_list_opt1 ',' name

name :
       IDENTIFIER
     | STRING_LITERAL
     | selected_name
     | indexed_name
     | prefix '(' discrete_range ')'
     | attribute_name

prefix :
       name
     | name '(' association_list ')'

selected_name :
       prefix '.' suffix

suffix :
       IDENTIFIER
     | CHARACTER_LITERAL
     | STRING_LITERAL
     | RW_ALL

indexed_name :
       prefix '(' expression indexed_name_opt1 ')'

indexed_name_opt1 :
       /* empty */
     | indexed_name_opt1 ',' expression

attribute_name :
       prefix attribute_name_opt1 '\'' IDENTIFIER attribute_name_opt2

attribute_name_opt1 :
       /* empty */
     | signature

attribute_name_opt2 :
       /* empty */
     | '(' expression ')'

expression :
       relation expression_opt3
     | relation expression_opt5
     | relation expression_opt7
     | relation
     | relation RW_NAND relation
     | relation RW_NOR relation
     | relation expression_opt9

expression_opt3 :
       /* empty */
     | expression_opt3 RW_AND relation

expression_opt5 :
       /* empty */
     | expression_opt5 RW_OR relation

expression_opt7 :
       /* empty */
     | expression_opt7 RW_XOR relation

expression_opt9 :
       /* empty */
     | expression_opt9 RW_XNOR relation

relation :
       shift_expression relation_opt1

relation_opt1 :
       /* empty */
     | relational_operator shift_expression

shift_expression :
       simple_expression shift_expression_opt1

shift_expression_opt1 :
       /* empty */
     | shift_operator simple_expression

simple_expression :
       simple_expression_opt1 term simple_expression_opt2

simple_expression_opt1 :
       /* empty */
     | sign

simple_expression_opt2 :
       /* empty */
     | simple_expression_opt2 adding_operator term

term :
       factor term_opt1

term_opt1 :
       /* empty */
     | term_opt1 multiplying_operator factor

factor :
       primary factor_opt1
     | RW_ABS primary
     | RW_NOT primary

factor_opt1 :
       /* empty */
     | "**" primary

primary :
       name
     | literal
     | aggregate
     | name '(' association_list ')'
     | qualified_expression
     | name '(' expression ')'
     | allocator
     | '(' expression ')'

relational_operator :
       '='
     | "/="
     | '<'
     | "<="
     | '>'
     | ">="

shift_operator :
       RW_SLL
     | RW_SRL
     | RW_SLA
     | RW_SRA
     | RW_ROL
     | RW_ROR

adding_operator :
       '+'
     | '-'
     | '&'

sign :
       '+'
     | '-'

multiplying_operator :
       '*'
     | '/'
     | RW_MOD
     | RW_REM

literal :
       ABSTRACT_LITERAL
     | physical_literal
     | enumeration_literal
     | STRING_LITERAL
     | BIT_STRING_LITERAL
     | RW_NULL

aggregate :
       '(' element_association aggregate_opt1 ')'

aggregate_opt1 :
       /* empty */
     | aggregate_opt1 ',' element_association

element_association :
       expression
     | choices expression

choices :
       choice choices_opt1

choices_opt1 :
       /* empty */
     | choices_opt1 choice

choice :
       simple_expression
     | discrete_range
     | IDENTIFIER
     | RW_OTHERS

qualified_expression :
       name '\'' '(' expression ')'
     | name '\'' aggregate

allocator :
       RW_NEW subtype_indication
     | RW_NEW qualified_expression

sequence_of_statements :
     | sequence_of_statements sequential_statement

sequential_statement :
       wait_statement
     | assertion_statement
     | report_statement
     | signal_assignment_statement
     | variable_assignment_statement
     | procedure_call_statement
     | if_statement
     | case_statement
     | loop_statement
     | next_statement
     | exit_statement
     | return_statement
     | null_statement

wait_statement :
       identifier_opt1 RW_WAIT wait_statement_opt2 wait_statement_opt3 wait_statement_opt4';'

wait_statement_opt2 :
       /* empty */
     | RW_ON sensitivity_list

wait_statement_opt3 :
       /* empty */
     | RW_UNTIL condition

wait_statement_opt4 :
       /* empty */
     | RW_FOR expression

sensitivity_list :
       /* empty */
     | sensitivity_list ',' name

condition :
       expression

assertion_statement :
       identifier_opt1 assertion ';'

assertion :
       RW_ASSERT condition assertion_opt1 assertion_opt2

assertion_opt1 :
       /* empty */
     | RW_REPORT expression

assertion_opt2 :
       /* empty */
     | RW_SEVERITY expression

report_statement :
       identifier_opt2 RW_REPORT expression report_statement_opt2 ';'

report_statement_opt2 :
       /* empty */
     | RW_SEVERITY expression

signal_assignment_statement :
       target "<=" signal_assignment_statement_opt2 waveform ';'
     | IDENTIFIER ':' target "<=" signal_assignment_statement_opt2 waveform ';'

signal_assignment_statement_opt2 :
       /* empty */
     | delay_mechanism

delay_mechanism :
       RW_TRANSPORT
     | delay_mechanism_opt1 RW_INERTIAL

delay_mechanism_opt1 :
       /* empty */
     | RW_REJECT expression

target :
       name
     | aggregate

waveform :
       waveform_element waveform_opt1
     | RW_UNAFFECTED

waveform_opt1 :
       /* empty */
     | waveform_opt1 ',' waveform_element

waveform_element :
       expression waveform_element_opt1
     | RW_NULL waveform_element_opt2

waveform_element_opt1 :
       /* empty */
     | RW_AFTER expression

waveform_element_opt2 :
       /* empty */
     | RW_AFTER expression

variable_assignment_statement :
       target ":=" expression ';'
     | IDENTIFIER ':' target ":=" expression ';'

procedure_call_statement :
       procedure_call ';'
     | IDENTIFIER ':' procedure_call ';'

procedure_call :
       name
     | name '(' association_list ')'

if_statement :
       identifier_opt2 RW_IF condition RW_THEN sequence_of_statements if_statement_opt4 if_statement_opt2 RW_END RW_IF identifier_opt1 ';'

if_statement_opt2 :
       /* empty */
     | RW_ELSE sequence_of_statements

if_statement_opt4 :
       /* empty */
     | if_statement_opt4 RW_ELSIF condition RW_THEN sequence_of_statements

case_statement :
       identifier_opt2 RW_CASE expression RW_IS case_statement_alternative case_statement_opt3 RW_END RW_CASE identifier_opt1 ';'

case_statement_opt3 :
       /* empty */
     | case_statement_opt3 case_statement_alternative

case_statement_alternative :
       RW_WHEN choices "=>" sequence_of_statements

loop_statement :
       identifier_opt2 loop_statement_opt2 RW_LOOP sequence_of_statements RW_END RW_LOOP identifier_opt1 ';'

loop_statement_opt2 :
       /* empty */
     | iteration_scheme

iteration_scheme :
       RW_WHILE condition
     | RW_FOR parameter_specification

parameter_specification :
       IDENTIFIER RW_IN discrete_range

next_statement :
       identifier_opt2 RW_NEXT identifier_opt1 next_statement_opt3 ';'

next_statement_opt3 :
       /* empty */
     | RW_WHEN condition

exit_statement :
       identifier_opt2 RW_EXIT identifier_opt1 exit_statement_opt3 ';'

exit_statement_opt3 :
       /* empty */
     | RW_WHEN condition

return_statement :
       identifier_opt2 RW_RETURN return_statement_opt2 ';'

return_statement_opt2 :
       /* empty */
     | expression

null_statement :
       identifier_opt2 RW_NULL ';'

concurrent_statement :
       block_statement
     | process_statement
     | concurrent_procedure_call_statement
     | concurrent_assertion_statement
     | concurrent_signal_assignment_statement
     | component_instantiation_statement
     | generate_statement

block_statement :
       IDENTIFIER ':' RW_BLOCK block_statement_opt1 block_statement_opt2 block_header block_declarative_part RW_BEGIN block_statement_part RW_END RW_BLOCK identifier_opt1 ';'

block_statement_opt1 :
       /* empty */
     | '(' expression ')'

block_statement_opt2 :
       /* empty */
     | RW_IS

block_header :
       block_header_opt1 block_header_opt2

block_header_opt1 :
       /* empty */
     | RW_GENERIC '(' interface_list ')' ';' block_header_opt3

block_header_opt2 :
       /* empty */
     | RW_PORT '(' interface_list ')' ';' block_header_opt4

block_header_opt3 :
       /* empty */
     | RW_GENERIC RW_MAP '(' association_list ')' ';'

block_header_opt4 :
       /* empty */
     | RW_PORT RW_MAP '(' association_list ')' ';'

block_declarative_part :
       /* empty */
     | block_declarative_part block_declarative_item

block_statement_part :
       /* empty */
     | block_statement_part concurrent_statement

process_statement :
       identifier_opt2 process_statement_opt2 RW_PROCESS process_statement_opt3 process_statement_opt4 process_declarative_part RW_BEGIN process_statement_part RW_END process_statement_opt5 RW_PROCESS identifier_opt1 ';'

process_statement_opt2 :
       /* empty */
     | RW_POSTPONED

process_statement_opt3 :
       /* empty */
     | '(' sensitivity_list ')'

process_statement_opt4 :
       /* empty */
     | RW_IS

process_statement_opt5 :
       /* empty */
     | RW_POSTPONED

process_declarative_part :
       /* empty */
     | process_declarative_part process_declarative_part_opt2

process_declarative_part_opt2 :
       process_declarative_item

process_declarative_item :
       subprogram_declaration
     | subprogram_body
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | variable_declaration
     | file_declaration
     | alias_declaration
     | attribute_declaration
     | attribute_specification
     | use_clause
     | group_template_declaration
     | group_declaration

process_statement_part :
       /* empty */
     | process_statement_part sequential_statement

concurrent_procedure_call_statement :
       identifier_opt2 concurrent_procedure_call_statement_opt2 procedure_call ';'

concurrent_procedure_call_statement_opt2 :
       /* empty */
     | RW_POSTPONED

concurrent_assertion_statement :
       identifier_opt2 concurrent_assertion_statement_opt2 assertion ';'

concurrent_assertion_statement_opt2 :
       /* empty */
     | RW_POSTPONED

concurrent_signal_assignment_statement :
       identifier_opt2 concurrent_signal_assignment_statement_opt2 conditional_signal_assignment
     | identifier_opt2 concurrent_signal_assignment_statement_opt4 selected_signal_assignment

concurrent_signal_assignment_statement_opt2 :
       /* empty */
     | RW_POSTPONED

concurrent_signal_assignment_statement_opt4 :
       /* empty */
     | RW_POSTPONED

options :
       options_opt1 options_opt2

options_opt1 :
       /* empty */
     | RW_GUARDED

options_opt2 :
       /* empty */
     | delay_mechanism

conditional_signal_assignment :
       target "<=" options conditional_waveforms ';'

conditional_waveforms :
       conditional_waveforms_opt2 waveform conditional_waveforms_opt1

conditional_waveforms_opt1 :
       /* empty */
     | RW_WHEN condition

conditional_waveforms_opt2 :
       /* empty */
     | conditional_waveforms_opt2 waveform RW_WHEN condition RW_ELSE

selected_signal_assignment :
       RW_WITH expression RW_SELECT target "<=" options selected_waveforms ';'

selected_waveforms :
       selected_waveforms_opt1 waveform RW_WHEN choices

selected_waveforms_opt1 :
       /* empty */
     | selected_waveforms_opt1 waveform RW_WHEN choices ','

component_instantiation_statement :
       IDENTIFIER ':' instantiated_unit component_instantiation_statement_opt1 component_instantiation_statement_opt2 ';'

component_instantiation_statement_opt1 :
       /* empty */
     | RW_GENERIC RW_MAP '(' association_list ')'

component_instantiation_statement_opt2 :
       /* empty */
     | RW_PORT RW_MAP '(' association_list ')'

instantiated_unit :
       name
     | RW_COMPONENT name
     | RW_ENTITY name instantiated_unit_opt2
     | RW_CONFIGURATION name

instantiated_unit_opt2 :
       /* empty */
     | '(' IDENTIFIER ')'

generate_statement :
       IDENTIFIER ':' generation_scheme RW_GENERATE generate_statement_opt1 generate_statement_opt3 RW_END RW_GENERATE identifier_opt1 ';'

generate_statement_opt1 :
       /* empty */
     | generate_statement_opt5 RW_BEGIN

generate_statement_opt3 :
       /* empty */
     | generate_statement_opt3 concurrent_statement

generate_statement_opt5 :
       /* empty */
     | generate_statement_opt5 block_declarative_item

generation_scheme :
       RW_FOR parameter_specification
     | RW_IF condition

use_clause :
       RW_USE selected_name use_clause_opt1 ';'

use_clause_opt1 :
       /* empty */
     | use_clause_opt1 ',' selected_name

design_file :
       design_unit design_file_opt1

design_file_opt1 :
       /* empty */
     | design_file_opt1 design_unit

design_unit :
       context_clause library_unit

library_unit :
       primary_unit
     | secondary_unit

primary_unit :
       entity_declaration
     | configuration_declaration
     | package_declaration

secondary_unit :
       architecture_body
     | package_body

logical_name_list :
       IDENTIFIER logical_name_list_opt1

logical_name_list_opt1 :
       /* empty */
     | logical_name_list_opt1 ',' IDENTIFIER

context_clause :
       /* empty */
     | context_clause context_item

context_item :
       RW_LIBRARY logical_name_list ';'
     | use_clause

%%

main(int argc, char **argv) {
   yyparse();
}

yyerror(char *s) {
   fprintf(stderr, "error: %s\n", s);
}
