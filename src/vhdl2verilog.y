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

%%

entity_declaration :
       RW_ENTITY identifier RW_IS entity_header entity_declarative_part [ RW_BEGIN entity_statement_part ] RW_END [ RW_ENTITY ] [ __entity__simple_name ] ';'

entity_header :
       [ __formal__generic_clause ] [ __formal__port_clause ]

generic_clause :
       RW_GENERIC '(' generic_list ')' ';'

port_clause :
       RW_PORT '(' port_list ')' ';'

generic_list :
       __generic__interface_list

port_list :
       __port__interface_list

entity_declarative_part :
       { entity_declarative_item }

entity_declarative_item :
       subprogram_declaration
     | subprogram_body
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | signal_declaration
     | __shared__variable_declaration
     | file_declaration
     | alias_declaration
     | attribute_declaration
     | attribute_specification
     | disconnection_specification
     | use_clause
     | group_template_declaration
     | group_declaration

entity_statement_part :
       { entity_statement }

entity_statement :
       concurrent_assertion_statement
     | __passive__concurrent_procedure_call
     | __passive__process_statement

architecture_body :
       RW_ARCHITECTURE identifier RW_OF __entity__name RW_IS architecture_declarative_part RW_BEGIN architecture_statement_part RW_END [RW_ARCHITECTURE] [ __architecture__simple_name ] ';'

architecture_declarative_part :
       { block_declarative_item }

block_declarative_item :
       subprogram_declaration
     | subprogram_body
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | signal_declaration
     | __shared__variable_declaration
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
       { concurrent_statement }

configuration_declaration :
       RW_CONFIGURATION identifier RW_OF __entity__name RW_IS configuration_declarative_part block_configuration RW_END [ RW_CONFIGURATION ] [ __configuration__simple_name ] ';'

configuration_declarative_part :
       { configuration_declarative_item }

configuration_declarative_item :
       use_clause
     | attribute_specification
     | group_declaration

block_configuration :
       RW_FOR block_specification { use_clause } { configuration_item } RW_END RW_FOR ';'

block_specification :
       __architecture__name
     | __block_statement__label
     | __generate_statement__label [ '(' index_specification ')' ]

index_specification :
       discrete_range
     | __static__expression

configuration_item :
       block_configuration
     | component_configuration

component_configuration :
       RW_FOR component_specification [ binding_indication ';' ] [ block_configuration ] RW_END RW_FOR ';'

subprogram_declaration :
       subprogram_specification ';'

subprogram_specification :
       RW_PROCEDURE designator [ '(' formal_parameter_list ')' ]
     | [ RW_PURE
     | RW_IMPURE ] RW_FUNCTION designator [ '(' formal_parameter_list ')' ] RW_RETURN type_mark

designator :
       identifier
     | operator_symbol

operator_symbol :
       string_literal

formal_parameter_list :
       __parameter__interface_list

subprogram_body :
       subprogram_specification RW_IS subprogram_declarative_part RW_BEGIN subprogram_statement_part RW_END [ subprogram_kind ] [ designator ] ';'

subprogram_declarative_part :
       { subprogram_declarative_item }

subprogram_declarative_item :
       subprogram_declaration
     | subprogram_body
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | variable_declaration
     | file_declaration
     | alias_declaratio
     | attribute_declaration
     | attribute_specification
     | use_clause
     | group_template_declaration
     | group_declaration

subprogram_statement_part :
       { sequential_statement }

subprogram_kind :
       RW_PROCEDURE
     | RW_FUNCTION

signature :
       '[' [ type_mark { ',' type_mark } ] [ RW_RETURN type_mark ] ']'

package_declaration :
       RW_PACKAGE identifier RW_IS package_declarative_part RW_END [ RW_PACKAGE ] [ __package__simple_name ] ';'

package_declarative_part :
       { package_declarative_item }

package_declarative_item :
       subprogram_declaration
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | signal_declaration
     | __shared__variable_declaration
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
       RW_PACKAGE RW_BODY __package__simple_name RW_IS package_body_declarative_part RW_END [ RW_PACKAGE RW_BODY ] [ __package__simple_name ] ';'

package_body_declarative_part :
       { package_body_declarative_item }

package_body_declarative_item :
       subprogram_declaration
     | subprogram_body
     | type_declaration
     | subtype_declaration
     | constant_declaration
     | __shared__variable_declaration
     | file_declaration
     | alias_declaration
     | use_clause
     | group_template_declaration
     | group_ declaration

scalar_type_definition :
       enumeration_type_definition
     | integer_type_definition
     | floating_type_definition
     | physical_type_definition

range_constraint :
       RW_RANGE range

range :
       __range__attribute_name
     | simple_expression direction simple_expression

direction :
       RW_TO
     | RW_DOWNTO

enumeration_type_definition :
       '(' enumeration_literal { ',' enumeration_literal } ')'

enumeration_literal :
       identifier
     | character_literal

integer_type_definition :
       range_constraint

physical_type_definition :
       range_constraint RW_UNITS primary_unit_declaration { secondary_unit_declaration } RW_END RW_UNITS [ __physical_type__simple_name ]

primary_unit_declaration :
       identifier

secondary_unit_declaration :
       identifier '=' physical_literal ';'

physical_literal :
       [ abstract_literal ] __unit__name

floating_type_definition :
       range_constraint

composite_type_definition :
       array_type_definition
     | record_type_definition

array_type_definition :
       unconstrained_array_definition
     | constrained_array_definition

unconstrained_array_definition :
       RW_ARRAY '(' index_subtype_definition { ',' index_subtype_definition } ')' RW_OF __element__subtype_indication

constrained_array_definition :
       RW_ARRAY index_constraint RW_OF __element__subtype_indication

index_subtype_definition :
       type_mark RW_RANGE "<>"

index_constraint :
       '(' discrete_range { ',' discrete_range } ')'

discrete_range :
       __discrete__subtype_indication
     | range

record_type_definition :
       RW_RECORD element_declaration { element_declaration } RW_END RW_RECORD [ __record_type__simple_name ]

element_declaration :
       identifier_list ':' element_subtype_definition ';'

identifier_list :
       identifier { ',' identifier }

element_subtype_definition :
       subtype_indication

access_type_definition :
       RW_ACCESS subtype_indication

incomplete_type_declaration :
       RW_TYPE identifier ';'

file_type_definition :
       RW_FILE RW_OF type_mark

declaration :
       type_declaration
     | subtype_declaration
     | object_declaration
     | interface_declaration
     | alias_declaration
     | attribute_declaration
     | component_declaration
     | group_template_declaration
     | group_declaration
     | entity_declaration
     | configuration_declaration
     | subprogram_declaration
     | package_declaration

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
       [ __resolution_function__name ] type_mark [ constraint ]

type_mark :
       __type__name
     | __subtype__name

constraint :
       range_constraint
     | index_constraint

object_declaration :
       constant_declaration
     | signal_declaration
     | variable_declaration
     | file_declaration

constant_declaration :
       RW_CONSTANT identifier_list ':' subtype_indication [ ":=" expression ] ';'

signal_declaration :
       RW_SIGNAL identifier_list ':' subtype_indication [ signal_kind ] [ ":=" expression ] ';'

signal_kind :
       RW_REGISTER
     | RW_BUS

variable_declaration :
       [ RW_SHARED ] RW_VARIABLE identifier_list ':' subtype_indication [ ":=" expression ] ';'

file_declaration :
       RW_FILE identifier_list ':' subtype_indication [ file_open_information ] ';'

file_open_information :
       [ RW_OPEN __file_open__kind_expression ] RW_IS file_logical_name

file_logical_name :
       __string__expression

interface_declaration :
       interface_constant_declaration
     | interface_signal_declaration
     | interface_variable_declaration
     | interface_file_declaration

interface_constant_declaration :
       [RW_CONSTANT] identifier_list ':' [ RW_IN ] subtype_indication [ ":=" __static__expression ]

interface_signal_declaration :
       [RW_SIGNAL] identifier_list ':' [ mode ] subtype_indication [ RW_BUS ] [ ":=" __static__expression ]

interface_variable_declaration :
       [RW_VARIABLE] identifier_list ':' [ mode ] subtype_indication [ ":=" __static__expression ]

interface_file_declaration :
       RW_FILE identifier_list subtype_indication

mode :
       RW_IN
     | RW_OUT
     | RW_INOUT
     | RW_BUFFER
     | RW_LINKAGE

interface_list :
       interface_element { ';' interface_element }

interface_element :
       interface_declaration

association_list :
       association_element { ',' association_element }

association_element :
       [ formal_part "=>" ] actual_part

formal_part :
       formal_designator
     | __function__name '(' formal_designator ')'
     | type_mark '(' formal_designator ')'

formal_designator :
       __generic__name
     | __port__name
     | __parameter__name

actual_part :
       actual_designator
     | __function__name '(' actual_designator ')'
     | type_mark '(' actual_designator ')'

actual_designator :
       expression
     | __signal__name
     | __variable__name
     | __file__name
     | RW_OPEN

alias_declaration :
       RW_ALIAS alias_designator [ ':' subtype_indication ] RW_IS name [ signature ] ';'

alias_designator :
       identifier
     | character_literal
     | operator_symbol

attribute_declaration :
       RW_ATTRIBUTE identifier ':' type_mark ';'

component_declaration :
       RW_COMPONENT identifier [ RW_IS ] [ __local__generic_clause ] [ __local__port_clause ] RW_END RW_COMPONENT [ __component__simple_name ] ';'

group_template_declaration :
       RW_GROUP identifier RW_IS '(' entity_class_entry_list ')' ';'

entity_class_entry_list :
       entity_class_entry { ',' entity_class_entry }

entity_class_entry :
       entity_class [ "<>" ]

group_declaration :
       RW_GROUP identifier ':' __group_template__name '(' group_constituent_list ')' ';'

group_constituent_list :
       group_constituent { ',' group_constituent }

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
       entity_designator { ',' entity_designator }
     | RW_OTHERS
     | RW_ALL

entity_designator :
       entity_tag [ signature ]

entity_tag :
       simple_name
     | character_literal
     | operator_symbol

configuration_specification :
       RW_FOR component_specification binding_indication ';'

component_specification :
       instantiation_list ':' __component__name

instantiation_list :
       __instantiation__label { ',' __instantiation__label }
     | RW_OTHERS
     | RW_ALL

binding_indication :
       [ RW_USE entity_aspect ] [ generic_map_aspect ] [ port_map_aspect ]

entity_aspect :
       RW_ENTITY __entity__name [ '(' __architecture__identifier ')' ]
     | RW_CONFIGURATION __configuration__name
     | RW_OPEN

generic_map_aspect :
       RW_GENERIC RW_MAP '(' __generic__association_list ')'

port_map_aspect :
       RW_PORT RW_MAP '(' __port__association_list ')'

disconnection_specification :
       RW_DISCONNECT guarded_signal_specification RW_AFTER __time__expression ';'

guarded_signal_specification :
       __guarded__signal_list ':' type_mark

signal_list :
       __signal__name { ',' __signal__name }
     | RW_OTHERS
     | RW_ALL

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
       prefix '(' expression { ',' expression } ')'

slice_name :
       prefix '(' discrete_range ')'

attribute_name :
       prefix [ signature ] '\'' attribute_designator [ '(' expression ')' ]

attribute_designator :
       __attribute__simple_name

expression :
       relation { RW_AND relation }
     | relation { RW_OR relation }
     | relation { RW_XOR relation }
     | relation [ RW_NAND relation ]
     | relation [ RW_NOR relation ]
     | relation { RW_XNOR relation }

relation :
       shift_expression [ relational_operator shift_expression ]

shift_expression :
       simple_expression [ shift_operator simple_expression ]

simple_expression :
       [ sign ] term { adding_operator term }

term :
       factor { multiplying_operator factor }

factor :
       primary [ "**" primary ]
     | RW_ABS primary
     | RW_NOT primary

primary :
       name
     | literal
     | aggregate
     | function_call
     | qualified_expression
     | type_conversion
     | allocator
     | '(' expression ')'

logical_operator :
       RW_AND
     | RW_OR
     | RW_NAND
     | RW_NOR
     | RW_XOR
     | RW_XNOR

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

miscellaneous_operator :
       "**"
     | RW_ABS
     | RW_NOT

literal :
       numeric_literal
     | enumeration_literal
     | string_literal
     | bit_string_literal
     | RW_NULL

numeric_literal :
       abstract_literal
     | physical_literal

aggregate :
       '(' element_association { ',' element_association } ')'

element_association :
       [ choices "=>" ] expression

choices :
       choice { | choice }

choice :
       simple_expression
     | discrete_range
     | __element__simple_name
     | RW_OTHERS

function_call :
       __function__name [ '(' actual_parameter_part ')' ]

actual_parameter_part :
       __parameter__association_list

qualified_expression :
       type_mark '\'' '(' expression ')'
     | type_mark '\'' aggregate

type_conversion :
       type_mark '(' expression ')'

allocator :
       RW_NEW subtype_indication
     | RW_NEW qualified_expression

sequence_of_statements :
       { sequential_statement }

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
       [ label ':' ] RW_WAIT [ sensitivity_clause ] [ condition_clause ] [ timeout_clause ] ';'

sensitivity_clause :
       RW_ON sensitivity_list

sensitivity_list :
       __signal__name { ',' __signal__name }

condition_clause :
       RW_UNTIL condition

condition :
       __boolean__expression

timeout_clause :
       RW_FOR __time__expression

assertion_statement :
       [ label ':' ] assertion ';'

assertion :
       RW_ASSERT condition [ RW_REPORT expression ] [ RW_SEVERITY expression ]

report_statement :
       [ label ':' ] RW_REPORT expression [ RW_SEVERITY expression ] ';'

signal_assignment_statement :
       [ label ':' ] target "<=" [ delay_mechanism ] waveform ';'

delay_mechanism :
       RW_TRANSPORT
     | [ RW_REJECT __time__expression ] RW_INERTIAL

target :
       name
     | aggregate

waveform :
       waveform_element { ',' waveform_element }
     | RW_UNAFFECTED

waveform_element :
       __value__expression [ RW_AFTER __time__expression ]
     | RW_NULL [ RW_AFTER __time__expression ]

variable_assignment_statement :
       [ label ':' ] target ":=" expression ';'

procedure_call_statement :
       [ label ':' ] procedure_call ';'

procedure_call :
       __procedure__name [ '(' actual_parameter_part ')' ]

if_statement :
       [ __if__label ':' ] RW_IF condition RW_THEN sequence_of_statements { RW_ELSIF condition RW_THEN sequence_of_statements } [ RW_ELSE sequence_of_statements ] RW_END RW_IF [ __if__label ] ';'

case_statement :
       [ __case__label ':' ] RW_CASE expression RW_IS case_statement_alternative { case_statement_alternative } RW_END RW_CASE [ __case__label ] ';'

case_statement_alternative :
       RW_WHEN choices "=>" sequence_of_statements

loop_statement :
       [ __loop__label ':' ] [ iteration_scheme ] RW_LOOP sequence_of_statements RW_END RW_LOOP [ __loop__label ] ';'

iteration_scheme :
       RW_WHILE condition
     | RW_FOR __loop__parameter_specification

parameter_specification :
       identifier RW_IN discrete_range

next_statement :
       [ label ':' ] RW_NEXT [ __loop__label ] [ RW_WHEN condition ] ';'

exit_statement :
       [ label ':' ] RW_EXIT [ __loop__label ] [ RW_WHEN condition ] ';'

return_statement :
       [ label ':' ] RW_RETURN [ expression ] ';'

null_statement :
       [ label ':' ] RW_NULL ';'

concurrent_statement :
       block_statement
     | process_statement
     | concurrent_procedure_call_statement
     | concurrent_assertion_statement
     | c oncurrent_signal_assignment_statement
     | component_instantiation_statement
     | generate_statement

block_statement :
       __block__label ':' RW_BLOCK [ '(' __guard__expression ')' ] [ RW_IS ] block_header block_declarative_part RW_BEGIN block_statement_part RW_END RW_BLOCK [ __block__label ] ';'

block_header :
       [ generic_clause [ generic_map_aspect ';' ] ] [ port_clause [ port_map_aspect ';' ] ]

block_declarative_part :
       { block_declarative_item }

block_statement_part :
       { concurrent_statement }

process_statement :
       [ __process__label ':' ] [ RW_POSTPONED ] RW_PROCESS [ '(' sensitivity_list ')' ] [ RW_IS ] process_declarative_part RW_BEGIN process_statement_part RW_END [ RW_POSTPONED ] RW_PROCESS [ __process__label ] ';'

process_declarative_part :
       { process_declarative_item }

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
     | group_type_declaration
     | group_declaration

process_statement_part :
       { sequential_statement }

concurrent_procedure_call_statement :
       [ label ':' ] [ RW_POSTPONED ] procedure_call ';'

concurrent_assertion_statement :
       [ label ':' ] [ RW_POSTPONED ] assertion ';'

concurrent_signal_assignment_statement :
       [ label ':' ] [ RW_POSTPONED ] conditional_signal_assignment
     | [ label ':' ] [ RW_POSTPONED ] selected_signal_assignment

options :
       [ RW_GUARDED ] [ delay_mechanism ]

conditional_signal_assignment :
       target "<=" options conditional_waveforms ';'

conditional_waveforms :
       { waveform RW_WHEN condition RW_ELSE } waveform [ RW_WHEN condition ]

selected_signal_assignment :
       RW_WITH expression RW_SELECT target "<=" options selected_waveforms ';'

selected_waveforms :
       { waveform RW_WHEN choices ',' } waveform RW_WHEN choices

component_instantiation_statement :
       __instantiation__label ':' instantiated_unit [ generic_map_aspect ] [ port_map_aspect ] ';'

instantiated_unit :
       [ RW_COMPONENT ] __component__name
     | RW_ENTITY __entity__name [ '(' __architecture__identifier ')' ]
     | RW_CONFIGURATION __configuration__name

generate_statement :
       __generate__label ':' generation_scheme RW_GENERATE [ { block_declarative_item } RW_BEGIN ] { concurrent_statement } RW_END RW_GENERATE [ __generate__label ] ';'

generation_scheme :
       RW_FOR __generate__parameter_specification
     | RW_IF condition

label :
       identifier

use_clause :
       RW_USE selected_name { ',' selected_name } ';'

design_file :
       design_unit { design_unit }

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
       logical_name { ',' logical_name }

logical_name :
       identifier

context_clause :
       { context_item }

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

basic_character :
       basic_graphic_character
     | format_effector

identifier :
       basic_identifier
     | extended_identifier

basic_identifier :
       letter { [ underline ] letter_or_digit }

letter_or_digit :
       letter
     | digit

letter :
       upper_case_letter
     | lower_case_letter

extended_identifier :
       '\' graphic_character { graphic_character } '\'

abstract_literal :
       decimal_literal
     | based_literal

decimal_literal :
       integer [ '.' integer ] [ exponent ]

integer :
       digit { [ underline ] digit }

exponent :
       'E' [ '+' ] integer
     | 'E' '-' integer

based_literal :
       base '#' based_integer [ '.' based_integer ] '#' [ exponent ]

base :
       integer

based_integer :
       extended_digit { [ underline ] extended_digit }

extended_digit :
       digit
     | letter

character_literal :
       '\'' graphic_character '

string_literal :
       '"' { graphic_character } "

bit_string_literal :
       base_specifier '"' [ bit_value ] "

bit_value :
       extended_digit { [ underline ] extended_digit }

base_specifier :
       'B'
     | 'O'
     | 'X'

instance_name :
       package_based_path
     | full_instance_based_path

package_based_path :
       leader __library__logical_name leader __package__simple_name leader [ local_item_name ]

full_instance_based_path :
       leader full_path_to_instance [ local_item_name ]

full_path_to_instance :
       { full_path_instance_element leader }

local_item_name :
       simple_name character_literal operator_symbol

full_path_instance_element :
       [ __component_instantiation__label '@' ] __entity__simple_name '(' __architecture__simple_name ')'
     | __block__label
     | generate_label
     | process_label
     | __loop__label
     | __subprogram__simple_name

generate_label :
       __generate__label [ '(' literal ')' ]

process_label :
       [ __process__label ]

leader :
       ':'

path_name :
       package_based_path
     | instance_based_path

instance_based_path :
       leader path_to_instance [ local_item_name ]

path_to_instance :
       { path_instance_element leader }

path_instance_element :
       __component_instantiation__label
     | __entity__simple_name
     | __block__label
     | generate_label
     | process_label
     | __subprogram__simple_name

%%

