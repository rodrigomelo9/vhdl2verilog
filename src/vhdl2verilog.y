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

%token ARROW "=>" VASSIGN ":=" LE "<=" GE ">=" BOX "<>" NE "/=" POW "**"

%token digit upper_case_letter lower_case_letter space_character
%token underline special_character other_special_character

%start design_file

%%

entity_declaration :
       RW_ENTITY identifier RW_IS entity_header entity_declarative_part entity_declaration_opt1 RW_END entity_declaration_opt2 entity_declaration_opt3 ';'

entity_declaration_opt1 :
       /* empty */
     | RW_BEGIN entity_statement_part

entity_declaration_opt2 :
       /* empty */
     | RW_ENTITY

entity_declaration_opt3 :
       /* empty */
     | /*__entity__*/ simple_name

entity_header :
       entity_header_opt1 entity_header_opt2

entity_header_opt1 :
       /* empty */
     | /*__formal__*/ generic_clause

entity_header_opt2 :
       /* empty */
     | /*__formal__*/ port_clause

generic_clause :
       RW_GENERIC '(' generic_list ')' ';'

port_clause :
       RW_PORT '(' port_list ')' ';'

generic_list :
       /*__generic__*/ interface_list

port_list :
       /*__port__*/ interface_list

entity_declarative_part :
       entity_declarative_part_opt1

entity_declarative_part_opt1 :
       /* empty */
     | entity_declarative_part_opt1 entity_declarative_part_opt2

entity_declarative_part_opt2 :
       entity_declarative_item

entity_declarative_item :
       subprogram_declaration
     | subprogram_body
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | signal_declaration
     | /*__shared__*/ variable_declaration
     | file_declaration
     | alias_declaration
     | attribute_declaration
     | attribute_specification
     | disconnection_specification
     | use_clause
     | group_template_declaration
     | group_declaration

entity_statement_part :
       entity_statement_part_opt1

entity_statement_part_opt1 :
       /* empty */
     | entity_statement_part_opt1 entity_statement_part_opt2

entity_statement_part_opt2 :
       entity_statement

entity_statement :
       concurrent_assertion_statement
     | /*__passive__*/ concurrent_procedure_call_statement
     | /*__passive__*/ process_statement

architecture_body :
       RW_ARCHITECTURE identifier RW_OF /*__entity__*/ name RW_IS architecture_declarative_part RW_BEGIN architecture_statement_part RW_END architecture_body_opt1 architecture_body_opt2 ';'

architecture_body_opt1 :
       /* empty */
     | RW_ARCHITECTURE

architecture_body_opt2 :
       /* empty */
     | /*__architecture__*/ simple_name

architecture_declarative_part :
       architecture_declarative_part_opt1

architecture_declarative_part_opt1 :
       /* empty */
     | architecture_declarative_part_opt1 architecture_declarative_part_opt2

architecture_declarative_part_opt2 :
       block_declarative_item

block_declarative_item :
       subprogram_declaration
     | subprogram_body
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | signal_declaration
     | /*__shared__*/ variable_declaration
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
       architecture_statement_part_opt1

architecture_statement_part_opt1 :
       /* empty */
     | architecture_statement_part_opt1 architecture_statement_part_opt2

architecture_statement_part_opt2 :
       concurrent_statement

configuration_declaration :
       RW_CONFIGURATION identifier RW_OF /*__entity__*/ name RW_IS configuration_declarative_part block_configuration RW_END configuration_declaration_opt1 configuration_declaration_opt2 ';'

configuration_declaration_opt1 :
       /* empty */
     | RW_CONFIGURATION

configuration_declaration_opt2 :
       /* empty */
     | /*__configuration__*/ simple_name

configuration_declarative_part :
       configuration_declarative_part_opt1

configuration_declarative_part_opt1 :
       /* empty */
     | configuration_declarative_part_opt1 configuration_declarative_part_opt2

configuration_declarative_part_opt2 :
       configuration_declarative_item

configuration_declarative_item :
       use_clause
     | attribute_specification
     | group_declaration

block_configuration :
       RW_FOR block_specification block_configuration_opt1 block_configuration_opt3 RW_END RW_FOR ';'

block_configuration_opt1 :
       /* empty */
     | block_configuration_opt1 block_configuration_opt2

block_configuration_opt2 :
       use_clause

block_configuration_opt3 :
       /* empty */
     | block_configuration_opt3 block_configuration_opt4

block_configuration_opt4 :
       configuration_item

block_specification :
       /*__architecture__*/ name
     | /*__block_statement__*/ label
     | /*__generate_statement__*/ label block_specification_opt1

block_specification_opt1 :
//To fix block_specification
//     /* empty */
//   | '(' index_specification ')'
       '(' index_specification ')'

index_specification :
       discrete_range
     | /*__static__*/ expression

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
     | subprogram_specification_opt2 RW_FUNCTION designator subprogram_specification_opt3 RW_RETURN type_mark

subprogram_specification_opt1 :
       /* empty */
     | '(' formal_parameter_list ')'

subprogram_specification_opt2 :
       /* empty */
     | RW_PURE
     | RW_IMPURE

subprogram_specification_opt3 :
       /* empty */
     | '(' formal_parameter_list ')'

designator :
       identifier
     | operator_symbol

operator_symbol :
       string_literal

formal_parameter_list :
       /*__parameter__*/ interface_list

subprogram_body :
       subprogram_specification RW_IS subprogram_declarative_part RW_BEGIN subprogram_statement_part RW_END subprogram_body_opt1 subprogram_body_opt2 ';'

subprogram_body_opt1 :
       /* empty */
     | subprogram_kind

subprogram_body_opt2 :
       /* empty */
     | designator

subprogram_declarative_part :
       subprogram_declarative_part_opt1

subprogram_declarative_part_opt1 :
       /* empty */
     | subprogram_declarative_part_opt1 subprogram_declarative_part_opt2

subprogram_declarative_part_opt2 :
       subprogram_declarative_item

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
       subprogram_statement_part_opt1

subprogram_statement_part_opt1 :
       /* empty */
     | subprogram_statement_part_opt1 subprogram_statement_part_opt2

subprogram_statement_part_opt2 :
       sequential_statement

subprogram_kind :
       RW_PROCEDURE
     | RW_FUNCTION

signature :
       '[' signature_opt1 signature_opt2 ']'

signature_opt1 :
       /* empty */
     | type_mark signature_opt3

signature_opt2 :
       /* empty */
     | RW_RETURN type_mark

signature_opt3 :
       /* empty */
     | signature_opt3 signature_opt4

signature_opt4 :
       ',' type_mark

package_declaration :
       RW_PACKAGE identifier RW_IS package_declarative_part RW_END package_declaration_opt1 package_declaration_opt2 ';'

package_declaration_opt1 :
       /* empty */
     | RW_PACKAGE

package_declaration_opt2 :
       /* empty */
     | /*__package__*/ simple_name

package_declarative_part :
       package_declarative_part_opt1

package_declarative_part_opt1 :
       /* empty */
     | package_declarative_part_opt1 package_declarative_part_opt2

package_declarative_part_opt2 :
       package_declarative_item

package_declarative_item :
       subprogram_declaration
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | signal_declaration
     | /*__shared__*/ variable_declaration
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
       RW_PACKAGE RW_BODY /*__package__*/ simple_name RW_IS package_body_declarative_part RW_END package_body_opt1 package_body_opt2 ';'

package_body_opt1 :
       /* empty */
     | RW_PACKAGE RW_BODY

package_body_opt2 :
       /* empty */
     | /*__package__*/ simple_name

package_body_declarative_part :
       package_body_declarative_part_opt1

package_body_declarative_part_opt1 :
       /* empty */
     | package_body_declarative_part_opt1 package_body_declarative_part_opt2

package_body_declarative_part_opt2 :
       package_body_declarative_item

package_body_declarative_item :
       subprogram_declaration
     | subprogram_body
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | /*__shared__*/ variable_declaration
     | file_declaration
     | alias_declaration
     | use_clause
     | group_template_declaration
     | group_declaration

scalar_type_definition :
       enumeration_type_definition
     | range_constraint
     | physical_type_definition

range_constraint :
       RW_RANGE range

range :
       /*__range__*/ attribute_name
     | simple_expression direction simple_expression

direction :
       RW_TO
     | RW_DOWNTO

enumeration_type_definition :
       '(' enumeration_literal enumeration_type_definition_opt1 ')'

enumeration_type_definition_opt1 :
       /* empty */
     | enumeration_type_definition_opt1 enumeration_type_definition_opt2

enumeration_type_definition_opt2 :
       ',' enumeration_literal

enumeration_literal :
       identifier
     | character_literal

//Moved to scalar_type_definition
//integer_type_definition :
//       range_constraint

physical_type_definition :
       range_constraint RW_UNITS primary_unit_declaration physical_type_definition_opt2 RW_END RW_UNITS physical_type_definition_opt1

physical_type_definition_opt1 :
       /* empty */
     | /*__physical_type__*/ simple_name

physical_type_definition_opt2 :
       /* empty */
     | physical_type_definition_opt2 physical_type_definition_opt3

physical_type_definition_opt3 :
       secondary_unit_declaration

primary_unit_declaration :
       identifier

secondary_unit_declaration :
       identifier '=' physical_literal ';'

physical_literal :
       physical_literal_opt1 /*__unit__*/ name

physical_literal_opt1 :
       /* empty */
     | abstract_literal

//Moved to scalar_type_definition
//floating_type_definition :
//       range_constraint

composite_type_definition :
       array_type_definition
     | record_type_definition

array_type_definition :
       unconstrained_array_definition
     | constrained_array_definition

unconstrained_array_definition :
       RW_ARRAY '(' index_subtype_definition unconstrained_array_definition_opt1 ')' RW_OF /*__element__*/ subtype_indication

unconstrained_array_definition_opt1 :
       /* empty */
     | unconstrained_array_definition_opt1 unconstrained_array_definition_opt2

unconstrained_array_definition_opt2 :
       ',' index_subtype_definition

constrained_array_definition :
       RW_ARRAY index_constraint RW_OF /*__element__*/ subtype_indication

index_subtype_definition :
       type_mark RW_RANGE "<>"

index_constraint :
       '(' discrete_range index_constraint_opt1 ')'

index_constraint_opt1 :
       /* empty */
     | index_constraint_opt1 index_constraint_opt2

index_constraint_opt2 :
       ',' discrete_range

discrete_range :
       /*__discrete__*/ subtype_indication
     | range

record_type_definition :
       RW_RECORD element_declaration record_type_definition_opt2 RW_END RW_RECORD record_type_definition_opt1

record_type_definition_opt1 :
       /* empty */
     | /*__record_type__*/ simple_name

record_type_definition_opt2 :
       /* empty */
     | record_type_definition_opt2 record_type_definition_opt3

record_type_definition_opt3 :
       element_declaration

element_declaration :
       identifier_list ':' element_subtype_definition ';'

identifier_list :
       identifier identifier_list_opt1

identifier_list_opt1 :
       /* empty */
     | identifier_list_opt1 identifier_list_opt2

identifier_list_opt2 :
       ',' identifier

element_subtype_definition :
       subtype_indication

access_type_definition :
       RW_ACCESS subtype_indication

incomplete_type_declaration :
       RW_TYPE identifier ';'

file_type_definition :
       RW_FILE RW_OF type_mark

//Not used
//declaration :
//       type_declaration
//     | subtype_declaration
//     | object_declaration
//     | interface_declaration
//     | alias_declaration
//     | attribute_declaration
//     | component_declaration
//     | group_template_declaration
//     | group_declaration
//     | entity_declaration
//     | configuration_declaration
//     | subprogram_declaration
//     | package_declaration

type_declaration :
       full_type_declaration
     | incomplete_type_declaration

full_type_declaration :
       RW_TYPE identifier RW_IS type_definition ';'

type_definition :
       scalar_type_definition
     | composite_type_definition
     | access_type_definition
     | file_type_definition

subtype_declaration :
       RW_SUBTYPE identifier RW_IS subtype_indication ';'

subtype_indication :
       type_mark subtype_indication_opt2
     | name type_mark subtype_indication_opt2

//subtype_indication_opt1 :
//       /* empty */
//     | /*__resolution_function__*/ name

subtype_indication_opt2 :
       /* empty */
     | constraint

type_mark :
       name
//Merged
//       /*__type__*/ name
//     | /*__subtype__*/ name

constraint :
       range_constraint
     | index_constraint

//Not used
//object_declaration :
//       constant_declaration
//     | signal_declaration
//     | variable_declaration
//     | file_declaration

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
       file_open_information_opt1 RW_IS file_logical_name

file_open_information_opt1 :
       /* empty */
     | RW_OPEN /*__file_open_kind__*/ expression

file_logical_name :
       /*__string__*/ expression

interface_declaration :
       interface_constant_declaration
     | interface_signal_declaration
     | interface_variable_declaration
     | interface_file_declaration

interface_constant_declaration :
       identifier_list ':' interface_constant_declaration_opt2 subtype_indication interface_constant_declaration_opt3
     | RW_CONSTANT identifier_list ':' interface_constant_declaration_opt2 subtype_indication interface_constant_declaration_opt3

//interface_constant_declaration_opt1 :
//       /* empty */
//     | RW_CONSTANT

interface_constant_declaration_opt2 :
       /* empty */
     | RW_IN

interface_constant_declaration_opt3 :
       /* empty */
     | ":=" /*__static__*/ expression

interface_signal_declaration :
       identifier_list ':' interface_signal_declaration_opt2 subtype_indication interface_signal_declaration_opt3 interface_signal_declaration_opt4
     | RW_SIGNAL identifier_list ':' interface_signal_declaration_opt2 subtype_indication interface_signal_declaration_opt3 interface_signal_declaration_opt4

//interface_signal_declaration_opt1 :
//       /* empty */
//     | RW_SIGNAL

interface_signal_declaration_opt2 :
       /* empty */
     | mode

interface_signal_declaration_opt3 :
       /* empty */
     | RW_BUS

interface_signal_declaration_opt4 :
       /* empty */
     | ":=" /*__static__*/ expression

interface_variable_declaration :
       identifier_list ':' interface_variable_declaration_opt2 subtype_indication interface_variable_declaration_opt3
     | RW_VARIABLE identifier_list ':' interface_variable_declaration_opt2 subtype_indication interface_variable_declaration_opt3

//interface_variable_declaration_opt1 :
//       /* empty */
//     | RW_VARIABLE

interface_variable_declaration_opt2 :
       /* empty */
     | mode

interface_variable_declaration_opt3 :
       /* empty */
     | ":=" /*__static__*/ expression

interface_file_declaration :
       RW_FILE identifier_list subtype_indication

mode :
       RW_IN
     | RW_OUT
     | RW_INOUT
     | RW_BUFFER
     | RW_LINKAGE

interface_list :
       interface_element interface_list_opt1

interface_list_opt1 :
       /* empty */
     | interface_list_opt1 interface_list_opt2

interface_list_opt2 :
       ';' interface_element

interface_element :
       interface_declaration

association_list :
       association_element association_list_opt1

association_list_opt1 :
       /* empty */
     | association_list_opt1 association_list_opt2

association_list_opt2 :
       ',' association_element

association_element :
       association_element_opt1 actual_part

association_element_opt1 :
       /* empty */
     | formal_part "=>"

formal_part :
       formal_designator
     | /*__function__*/ name '(' formal_designator ')'
     | type_mark '(' formal_designator ')'

formal_designator :
       name
//Merged
//       /*__generic__*/ name
//     | /*__port__*/ name
//     | /*__parameter__*/ name

actual_part :
       actual_designator
     | /*__function__*/ name '(' actual_designator ')'
     | type_mark '(' actual_designator ')'

actual_designator :
       expression
     | name
//Merged
//     | /*__signal__*/ name
//     | /*__variable__*/ name
//     | /*__file__*/ name
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
       identifier
     | character_literal
     | operator_symbol

attribute_declaration :
       RW_ATTRIBUTE identifier ':' type_mark ';'

component_declaration :
       RW_COMPONENT identifier component_declaration_opt1 component_declaration_opt2 component_declaration_opt3 RW_END RW_COMPONENT component_declaration_opt4 ';'

component_declaration_opt1 :
       /* empty */
     | RW_IS

component_declaration_opt2 :
       /* empty */
     | /*__local__*/ generic_clause

component_declaration_opt3 :
       /* empty */
     | /*__local__*/ port_clause

component_declaration_opt4 :
       /* empty */
     | /*__component__*/ simple_name

group_template_declaration :
       RW_GROUP identifier RW_IS '(' entity_class_entry_list ')' ';'

entity_class_entry_list :
       entity_class_entry entity_class_entry_list_opt1

entity_class_entry_list_opt1 :
       /* empty */
     | entity_class_entry_list_opt1 entity_class_entry_list_opt2

entity_class_entry_list_opt2 :
       ',' entity_class_entry

entity_class_entry :
       entity_class entity_class_entry_opt1

entity_class_entry_opt1 :
       /* empty */
     | "<>"

group_declaration :
       RW_GROUP identifier ':' /*__group_template__*/ name '(' group_constituent_list ')' ';'

group_constituent_list :
       group_constituent group_constituent_list_opt1

group_constituent_list_opt1 :
       /* empty */
     | group_constituent_list_opt1 group_constituent_list_opt2

group_constituent_list_opt2 :
       ',' group_constituent

group_constituent :
       name
     | character_literal

attribute_specification :
       RW_ATTRIBUTE attribute_designator RW_OF entity_specification RW_IS expression ';'

entity_specification :
       entity_name_list ':' entity_class

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
     | entity_name_list_opt1 entity_name_list_opt2

entity_name_list_opt2 :
       ',' entity_designator

entity_designator :
       entity_tag entity_designator_opt1

entity_designator_opt1 :
       /* empty */
     | signature

entity_tag :
       simple_name
     | character_literal
     | operator_symbol

configuration_specification :
       RW_FOR component_specification binding_indication ';'

component_specification :
       instantiation_list ':' /*__component__*/ name

instantiation_list :
       /*__instantiation__*/ label instantiation_list_opt1
     | RW_OTHERS
     | RW_ALL

instantiation_list_opt1 :
       /* empty */
     | instantiation_list_opt1 instantiation_list_opt2

instantiation_list_opt2 :
       ',' /*__instantiation__*/ label

binding_indication :
       binding_indication_opt1 binding_indication_opt2 binding_indication_opt3

binding_indication_opt1 :
       /* empty */
     | RW_USE entity_aspect

binding_indication_opt2 :
       /* empty */
     | generic_map_aspect

binding_indication_opt3 :
       /* empty */
     | port_map_aspect

entity_aspect :
       RW_ENTITY /*__entity__*/ name entity_aspect_opt1
     | RW_CONFIGURATION /*__configuration__*/ name
     | RW_OPEN

entity_aspect_opt1 :
       /* empty */
     | '(' /*__architecture__*/ identifier ')'

generic_map_aspect :
       RW_GENERIC RW_MAP '(' /*__generic__*/ association_list ')'

port_map_aspect :
       RW_PORT RW_MAP '(' /*__port__*/ association_list ')'

disconnection_specification :
       RW_DISCONNECT guarded_signal_specification RW_AFTER /*__time__*/ expression ';'

guarded_signal_specification :
       /*__guarded__*/ signal_list ':' type_mark

signal_list :
       /*__signal__*/ name signal_list_opt1
     | RW_OTHERS
     | RW_ALL

signal_list_opt1 :
       /* empty */
     | signal_list_opt1 signal_list_opt2

signal_list_opt2 :
       ',' /*__signal__*/ name

name :
       simple_name
     | operator_symbol
     | selected_name
     | indexed_name
     | slice_name
     | attribute_name

prefix :
       name
     | function_call

simple_name :
       identifier

selected_name :
       prefix '.' suffix

suffix :
       simple_name
     | character_literal
     | operator_symbol
     | RW_ALL

indexed_name :
       prefix '(' expression indexed_name_opt1 ')'

indexed_name_opt1 :
       /* empty */
     | indexed_name_opt1 indexed_name_opt2

indexed_name_opt2 :
       ',' expression

slice_name :
       prefix '(' discrete_range ')'

attribute_name :
       prefix attribute_name_opt1 '\'' attribute_designator attribute_name_opt2

attribute_name_opt1 :
       /* empty */
     | signature

attribute_name_opt2 :
       /* empty */
     | '(' expression ')'

attribute_designator :
       /*__attribute__*/ simple_name

expression :
       relation expression_opt3
     | relation expression_opt5
     | relation expression_opt7
     | relation
     | relation RW_NAND relation
     | relation RW_NOR relation
     | relation expression_opt9

//expression_opt1 :
//       /* empty */
//     | RW_NAND relation

//expression_opt2 :
//       /* empty */
//     | RW_NOR relation

expression_opt3 :
       /* empty */
     | expression_opt3 expression_opt4

expression_opt4 :
       RW_AND relation

expression_opt5 :
       /* empty */
     | expression_opt5 expression_opt6

expression_opt6 :
       RW_OR relation

expression_opt7 :
       /* empty */
     | expression_opt7 expression_opt8

expression_opt8 :
       RW_XOR relation

expression_opt9 :
       /* empty */
     | expression_opt9 expression_opt10

expression_opt10 :
       RW_XNOR relation

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
     | simple_expression_opt2 simple_expression_opt3

simple_expression_opt3 :
       adding_operator term

term :
       factor term_opt1

term_opt1 :
       /* empty */
     | term_opt1 term_opt2

term_opt2 :
       multiplying_operator factor

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
     | function_call
     | qualified_expression
     | type_conversion
     | allocator
     | '(' expression ')'

//Not used
//logical_operator :
//       RW_AND
//     | RW_OR
//     | RW_NAND
//     | RW_NOR
//     | RW_XOR
//     | RW_XNOR

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

//Not used
//miscellaneous_operator :
//       "**"
//     | RW_ABS
//     | RW_NOT

literal :
       numeric_literal
     | enumeration_literal
     | '"' string_literal_opt1 '"'
     | bit_string_literal
     | RW_NULL

numeric_literal :
       abstract_literal
     | physical_literal

aggregate :
       '(' element_association aggregate_opt1 ')'

aggregate_opt1 :
       /* empty */
     | aggregate_opt1 aggregate_opt2

aggregate_opt2 :
       ',' element_association

element_association :
       expression
     | choices expression

//element_association_opt1 :
//       /* empty */
//     | choices "=>"

choices :
       choice choices_opt1

choices_opt1 :
       /* empty */
     | choices_opt1 choice

//choices_opt2 :
//       /* empty */
//     | choice

choice :
       simple_expression
     | discrete_range
     | /*__element__*/ simple_name
     | RW_OTHERS

function_call :
       /*__function__*/ name
     | /*__function__*/ name '(' actual_parameter_part ')'

//function_call_opt1 :
//       /* empty */
//     | '(' actual_parameter_part ')'

actual_parameter_part :
       /*__parameter__*/ association_list

qualified_expression :
       type_mark '\'' '(' expression ')'
     | type_mark '\'' aggregate

type_conversion :
       type_mark '(' expression ')'

allocator :
       RW_NEW subtype_indication
     | RW_NEW qualified_expression

sequence_of_statements :
       sequence_of_statements_opt1

sequence_of_statements_opt1 :
       /* empty */
     | sequence_of_statements_opt1 sequence_of_statements_opt2

sequence_of_statements_opt2 :
       sequential_statement

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
       wait_statement_opt1 RW_WAIT wait_statement_opt2 wait_statement_opt3 wait_statement_opt4 ';'

wait_statement_opt1 :
       /* empty */
     | label ':'

wait_statement_opt2 :
       /* empty */
     | sensitivity_clause

wait_statement_opt3 :
       /* empty */
     | condition_clause

wait_statement_opt4 :
       /* empty */
     | timeout_clause

sensitivity_clause :
       RW_ON sensitivity_list

sensitivity_list :
       /*__signal__*/ name sensitivity_list_opt1

sensitivity_list_opt1 :
       /* empty */
     | sensitivity_list_opt1 sensitivity_list_opt2

sensitivity_list_opt2 :
       ',' /*__signal__*/ name

condition_clause :
       RW_UNTIL condition

condition :
       /*__boolean__*/ expression

timeout_clause :
       RW_FOR /*__time__*/ expression

assertion_statement :
       assertion_statement_opt1 assertion ';'

assertion_statement_opt1 :
       /* empty */
     | label ':'

assertion :
       RW_ASSERT condition assertion_opt1 assertion_opt2

assertion_opt1 :
       /* empty */
     | RW_REPORT expression

assertion_opt2 :
       /* empty */
     | RW_SEVERITY expression

report_statement :
       report_statement_opt1 RW_REPORT expression report_statement_opt2 ';'

report_statement_opt1 :
       /* empty */
     | label ':'

report_statement_opt2 :
       /* empty */
     | RW_SEVERITY expression

signal_assignment_statement :
       target "<=" signal_assignment_statement_opt2 waveform ';'
     | label ':' target "<=" signal_assignment_statement_opt2 waveform ';'

//signal_assignment_statement_opt1 :
//       /* empty */
//     | label ':'

signal_assignment_statement_opt2 :
       /* empty */
     | delay_mechanism

delay_mechanism :
       RW_TRANSPORT
     | delay_mechanism_opt1 RW_INERTIAL

delay_mechanism_opt1 :
       /* empty */
     | RW_REJECT /*__time__*/ expression

target :
       name
     | aggregate

waveform :
       waveform_element waveform_opt1
     | RW_UNAFFECTED

waveform_opt1 :
       /* empty */
     | waveform_opt1 waveform_opt2

waveform_opt2 :
       ',' waveform_element

waveform_element :
       /*__value__*/ expression waveform_element_opt1
     | RW_NULL waveform_element_opt2

waveform_element_opt1 :
       /* empty */
     | RW_AFTER /*__time__*/ expression

waveform_element_opt2 :
       /* empty */
     | RW_AFTER /*__time__*/ expression

variable_assignment_statement :
       target ":=" expression ';'
     | label ':' target ":=" expression ';'

procedure_call_statement :
       procedure_call ';'
     | label ':' procedure_call ';'

//procedure_call_statement_opt1 :
//       /* empty */
//     | label ':'

procedure_call :
       /*__procedure__*/ name procedure_call_opt1

procedure_call_opt1 :
       /* empty */
     | '(' actual_parameter_part ')'

if_statement :
       if_statement_opt1 RW_IF condition RW_THEN sequence_of_statements if_statement_opt4 if_statement_opt2 RW_END RW_IF if_statement_opt3 ';'

if_statement_opt1 :
       /* empty */
     | /*__if__*/ label ':'

if_statement_opt2 :
       /* empty */
     | RW_ELSE sequence_of_statements

if_statement_opt3 :
       /* empty */
     | /*__if__*/ label

if_statement_opt4 :
       /* empty */
     | if_statement_opt4 if_statement_opt5

if_statement_opt5 :
       RW_ELSIF condition RW_THEN sequence_of_statements

case_statement :
       case_statement_opt1 RW_CASE expression RW_IS case_statement_alternative case_statement_opt3 RW_END RW_CASE case_statement_opt2 ';'

case_statement_opt1 :
       /* empty */
     | /*__case__*/ label ':'

case_statement_opt2 :
       /* empty */
     | /*__case__*/ label

case_statement_opt3 :
       /* empty */
     | case_statement_opt3 case_statement_opt4

case_statement_opt4 :
       case_statement_alternative

case_statement_alternative :
       RW_WHEN choices "=>" sequence_of_statements

loop_statement :
       loop_statement_opt1 loop_statement_opt2 RW_LOOP sequence_of_statements RW_END RW_LOOP loop_statement_opt3 ';'

loop_statement_opt1 :
       /* empty */
     | /*__loop__*/ label ':'

loop_statement_opt2 :
       /* empty */
     | iteration_scheme

loop_statement_opt3 :
       /* empty */
     | /*__loop__*/ label

iteration_scheme :
       RW_WHILE condition
     | RW_FOR /*__loop__*/ parameter_specification

parameter_specification :
       identifier RW_IN discrete_range

next_statement :
       next_statement_opt1 RW_NEXT next_statement_opt2 next_statement_opt3 ';'

next_statement_opt1 :
       /* empty */
     | label ':'

next_statement_opt2 :
       /* empty */
     | /*__loop__*/ label

next_statement_opt3 :
       /* empty */
     | RW_WHEN condition

exit_statement :
       exit_statement_opt1 RW_EXIT exit_statement_opt2 exit_statement_opt3 ';'

exit_statement_opt1 :
       /* empty */
     | label ':'

exit_statement_opt2 :
       /* empty */
     | /*__loop__*/ label

exit_statement_opt3 :
       /* empty */
     | RW_WHEN condition

return_statement :
       return_statement_opt1 RW_RETURN return_statement_opt2 ';'

return_statement_opt1 :
       /* empty */
     | label ':'

return_statement_opt2 :
       /* empty */
     | expression

null_statement :
       null_statement_opt1 RW_NULL ';'

null_statement_opt1 :
       /* empty */
     | label ':'

concurrent_statement :
       block_statement
     | process_statement
     | concurrent_procedure_call_statement
     | concurrent_assertion_statement
     | concurrent_signal_assignment_statement
     | component_instantiation_statement
     | generate_statement

block_statement :
       /*__block__*/ label ':' RW_BLOCK block_statement_opt1 block_statement_opt2 block_header block_declarative_part RW_BEGIN block_statement_part RW_END RW_BLOCK block_statement_opt3 ';'

block_statement_opt1 :
       /* empty */
     | '(' /*__guard__*/ expression ')'

block_statement_opt2 :
       /* empty */
     | RW_IS

block_statement_opt3 :
       /* empty */
     | /*__block__*/ label

block_header :
       block_header_opt1 block_header_opt2

block_header_opt1 :
       /* empty */
     | generic_clause block_header_opt3

block_header_opt2 :
       /* empty */
     | port_clause block_header_opt4

block_header_opt3 :
       /* empty */
     | generic_map_aspect ';'

block_header_opt4 :
       /* empty */
     | port_map_aspect ';'

block_declarative_part :
       block_declarative_part_opt1

block_declarative_part_opt1 :
       /* empty */
     | block_declarative_part_opt1 block_declarative_part_opt2

block_declarative_part_opt2 :
       block_declarative_item

block_statement_part :
       block_statement_part_opt1

block_statement_part_opt1 :
       /* empty */
     | block_statement_part_opt1 block_statement_part_opt2

block_statement_part_opt2 :
       concurrent_statement

process_statement :
       process_statement_opt1 process_statement_opt2 RW_PROCESS process_statement_opt3 process_statement_opt4 process_declarative_part RW_BEGIN process_statement_part RW_END process_statement_opt5 RW_PROCESS process_statement_opt6 ';'

process_statement_opt1 :
       /* empty */
     | /*__process__*/ label ':'

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

process_statement_opt6 :
       /* empty */
     | /*__process__*/ label

process_declarative_part :
       process_declarative_part_opt1

process_declarative_part_opt1 :
       /* empty */
     | process_declarative_part_opt1 process_declarative_part_opt2

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
       process_statement_part_opt1

process_statement_part_opt1 :
       /* empty */
     | process_statement_part_opt1 process_statement_part_opt2

process_statement_part_opt2 :
       sequential_statement

concurrent_procedure_call_statement :
       concurrent_procedure_call_statement_opt1 concurrent_procedure_call_statement_opt2 procedure_call ';'

concurrent_procedure_call_statement_opt1 :
       /* empty */
     | label ':'

concurrent_procedure_call_statement_opt2 :
       /* empty */
     | RW_POSTPONED

concurrent_assertion_statement :
       concurrent_assertion_statement_opt1 concurrent_assertion_statement_opt2 assertion ';'

concurrent_assertion_statement_opt1 :
       /* empty */
     | label ':'

concurrent_assertion_statement_opt2 :
       /* empty */
     | RW_POSTPONED

concurrent_signal_assignment_statement :
       concurrent_signal_assignment_statement_opt1 concurrent_signal_assignment_statement_opt2 conditional_signal_assignment
     | concurrent_signal_assignment_statement_opt3 concurrent_signal_assignment_statement_opt4 selected_signal_assignment

concurrent_signal_assignment_statement_opt1 :
       /* empty */
     | label ':'

concurrent_signal_assignment_statement_opt2 :
       /* empty */
     | RW_POSTPONED

concurrent_signal_assignment_statement_opt3 :
       /* empty */
     | label ':'

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
     | conditional_waveforms_opt2 conditional_waveforms_opt3

conditional_waveforms_opt3 :
       waveform RW_WHEN condition RW_ELSE

selected_signal_assignment :
       RW_WITH expression RW_SELECT target "<=" options selected_waveforms ';'

selected_waveforms :
       selected_waveforms_opt1 waveform RW_WHEN choices

selected_waveforms_opt1 :
       /* empty */
     | selected_waveforms_opt1 selected_waveforms_opt2

selected_waveforms_opt2 :
       waveform RW_WHEN choices ','

component_instantiation_statement :
       /*__instantiation__*/ label ':' instantiated_unit component_instantiation_statement_opt1 component_instantiation_statement_opt2 ';'

component_instantiation_statement_opt1 :
       /* empty */
     | generic_map_aspect

component_instantiation_statement_opt2 :
       /* empty */
     | port_map_aspect

instantiated_unit :
       /*__component__*/ name
     | RW_COMPONENT /*__component__*/ name
     | RW_ENTITY /*__entity__*/ name instantiated_unit_opt2
     | RW_CONFIGURATION /*__configuration__*/ name

//instantiated_unit_opt1 :
//       /* empty */
//     | RW_COMPONENT

instantiated_unit_opt2 :
       /* empty */
     | '(' /*__architecture__*/ identifier ')'

generate_statement :
       /*__generate__*/ label ':' generation_scheme RW_GENERATE generate_statement_opt1 generate_statement_opt3 RW_END RW_GENERATE generate_statement_opt2 ';'

generate_statement_opt1 :
       /* empty */
     | generate_statement_opt5 RW_BEGIN

generate_statement_opt2 :
       /* empty */
     | /*__generate__*/ label

generate_statement_opt3 :
       /* empty */
     | generate_statement_opt3 generate_statement_opt4

generate_statement_opt4 :
       concurrent_statement

generate_statement_opt5 :
       /* empty */
     | generate_statement_opt5 generate_statement_opt6

generate_statement_opt6 :
       block_declarative_item

generation_scheme :
       RW_FOR /*__generate__*/ parameter_specification
     | RW_IF condition

label :
       identifier

use_clause :
       RW_USE selected_name use_clause_opt1 ';'

use_clause_opt1 :
       /* empty */
     | use_clause_opt1 use_clause_opt2

use_clause_opt2 :
       ',' selected_name

design_file :
       design_unit design_file_opt1

design_file_opt1 :
       /* empty */
     | design_file_opt1 design_file_opt2

design_file_opt2 :
       design_unit

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

library_clause :
       RW_LIBRARY logical_name_list ';'

logical_name_list :
       logical_name logical_name_list_opt1

logical_name_list_opt1 :
       /* empty */
     | logical_name_list_opt1 logical_name_list_opt2

logical_name_list_opt2 :
       ',' logical_name

logical_name :
       identifier

context_clause :
       context_clause_opt1

context_clause_opt1 :
       /* empty */
     | context_clause_opt1 context_clause_opt2

context_clause_opt2 :
       context_item

context_item :
       library_clause
     | use_clause

basic_graphic_character :
       upper_case_letter
     | digit
     | special_character
     | space_character

graphic_character :
       basic_graphic_character
     | lower_case_letter
     | other_special_character

//Not used
//basic_character :
//       basic_graphic_character
//     | format_effector

identifier :
       basic_identifier
     | extended_identifier

basic_identifier :
       letter basic_identifier_opt2

//basic_identifier_opt1 :
//       /* empty */
//     | underline

basic_identifier_opt2 :
       /* empty */
     | basic_identifier_opt2 basic_identifier_opt3

basic_identifier_opt3 :
       letter_or_digit
     | underline letter_or_digit

letter_or_digit :
       letter
     | digit

letter :
       upper_case_letter
     | lower_case_letter

extended_identifier :
       '\\' graphic_character extended_identifier_opt1 '\\'

extended_identifier_opt1 :
       /* empty */
     | extended_identifier_opt1 extended_identifier_opt2

extended_identifier_opt2 :
       graphic_character

abstract_literal :
       decimal_literal
     | based_literal

decimal_literal :
       integer decimal_literal_opt1 decimal_literal_opt2

decimal_literal_opt1 :
       /* empty */
     | '.' integer

decimal_literal_opt2 :
       /* empty */
     | exponent

integer :
       digit integer_opt2

//integer_opt1 :
//       /* empty */
//     | underline

integer_opt2 :
       /* empty */
     | integer_opt2 integer_opt3

integer_opt3 :
       digit
     | underline digit

exponent :
       'E' exponent_opt1 integer
     | 'E' '-' integer

exponent_opt1 :
       /* empty */
     | '+'

based_literal :
       base '#' based_integer based_literal_opt1 '#' based_literal_opt2

based_literal_opt1 :
       /* empty */
     | '.' based_integer

based_literal_opt2 :
       /* empty */
     | exponent

base :
       integer

based_integer :
       extended_digit based_integer_opt2

based_integer_opt1 :
       /* empty */
     | underline

based_integer_opt2 :
       /* empty */
     | based_integer_opt2 based_integer_opt3

based_integer_opt3 :
       based_integer_opt1 extended_digit

extended_digit :
       digit
     | letter

character_literal :
       '\'' graphic_character '\''

string_literal :
       '"' string_literal_opt1 '"'

string_literal_opt1 :
       /* empty */
     | string_literal_opt1 string_literal_opt2

string_literal_opt2 :
       graphic_character

bit_string_literal :
       base_specifier '"' bit_string_literal_opt1 '"'

bit_string_literal_opt1 :
       /* empty */
     | bit_value

bit_value :
       extended_digit bit_value_opt2

bit_value_opt1 :
       /* empty */
     | underline

bit_value_opt2 :
       /* empty */
     | bit_value_opt2 bit_value_opt3

bit_value_opt3 :
       bit_value_opt1 extended_digit

base_specifier :
       'B'
     | 'O'
     | 'X'

//Not used
//instance_name :
//       package_based_path
//     | full_instance_based_path

//Not used
//package_based_path :
//       leader /*__library__*/ logical_name leader /*__package__*/ simple_name leader package_based_path_opt1

//Not used
//package_based_path_opt1 :
//       /* empty */
//     | local_item_name

//Not used
//full_instance_based_path :
//       leader full_path_to_instance full_instance_based_path_opt1

//Not used
//full_instance_based_path_opt1 :
//       /* empty */
//     | local_item_name

//Not used
//full_path_to_instance :
//       full_path_to_instance_opt1

//Not used
//full_path_to_instance_opt1 :
//       /* empty */
//     | full_path_to_instance_opt1 full_path_to_instance_opt2

//Not used
//full_path_to_instance_opt2 :
//       full_path_instance_element leader

//Not used
//local_item_name :
//       simple_name character_literal operator_symbol

//Not used
//full_path_instance_element :
//       full_path_instance_element_opt1 /*__entity__*/ simple_name '(' /*__architecture__*/ simple_name ')'
//     | /*__block__*/ label
//     | generate_label
//     | process_label
//     | /*__loop__*/ label
//     | /*__subprogram__*/ simple_name

//Not used
//full_path_instance_element_opt1 :
//       /* empty */
//     | /*__component_instantiation__*/ label '@'

//Not used
//generate_label :
//       /*__generate__*/ label generate_label_opt1

//Not used
//generate_label_opt1 :
//       /* empty */
//     | '(' literal ')'

//Not used
//process_label :
//       process_label_opt1

//Not used
//process_label_opt1 :
//       /* empty */
//     | /*__process__*/ label

//Not used
//leader :
//       ':'

//Not used
//path_name :
//       package_based_path
//     | instance_based_path

//Not used
//instance_based_path :
//       leader path_to_instance instance_based_path_opt1

//Not used
//instance_based_path_opt1 :
//       /* empty */
//     | local_item_name

//Not used
//path_to_instance :
//       path_to_instance_opt1

//Not used
//path_to_instance_opt1 :
//       /* empty */
//     | path_to_instance_opt1 path_to_instance_opt2

//Not used
//path_to_instance_opt2 :
//       path_instance_element leader

//Not used
//path_instance_element :
//       /*__component_instantiation__*/ label
//     | /*__entity__*/ simple_name
//     | /*__block__*/ label
//     | generate_label
//     | process_label
//     | /*__subprogram__*/ simple_name

%%

main(int argc, char **argv) {
   yyparse();
}

yyerror(char *s) {
   fprintf(stderr, "error: %s\n", s);
}
