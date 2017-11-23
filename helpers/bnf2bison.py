#!/usr/bin/python
#
# Copyright (C) 2017, Rodrigo A. Melo
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

import sys, re

text = sys.stdin.read()

###############################################################################
# Functions
###############################################################################

#def delete(text):
#    # Section 13
#    text = re.sub(r"\nbasic_graphic_character.*::=.*\n", "\n" , text)
#    text = re.sub(r"\ngraphic_character.*::=.*\n", "\n" , text)
#    text = re.sub(r"\nbasic_character.*::=.*\n", "\n" , text)
#    text = re.sub(r"\nidentifier ::=.*\n", "\n" , text)
#    text = re.sub(r"\nbasic_identifier.*::=.*\n", "\n" , text)
#    text = re.sub(r"\nletter_or_digit.*::=.*\n", "\n" , text)
#    text = re.sub(r"\nletter.*::=.*\n", "\n" , text)
#    text = re.sub(r"\nextended_identifier.*::=.*\n", "\n" , text)
#    text = re.sub(r"\nabstract_literal.*::=.*\n", "\n" , text)
#    text = re.sub(r"\ndecimal_literal.*::=.*\n", "\n" , text)
#    text = re.sub(r"\ninteger ::=.*\n", "\n" , text)
#    text = re.sub(r"\ninteger_opt.*::=.*\n", "\n" , text)
#    text = re.sub(r"\nexponent ::=.*\n", "\n" , text)
#    text = re.sub(r"\nexponent_opt.*::=.*\n", "\n" , text)
#    text = re.sub(r"\nbased_literal.*::=.*\n", "\n" , text)
#    text = re.sub(r"\nbase ::=.*\n", "\n" , text)
#    text = re.sub(r"\nbased_integer.*::=.*\n", "\n" , text)
#    text = re.sub(r"\nextended_digit.*::=.*\n", "\n" , text)
#    text = re.sub(r"\ncharacter_literal.*::=.*\n", "\n" , text)
#    text = re.sub(r"\nstring_literal.*::=.*\n", "\n" , text)
#    text = re.sub(r"\nbit_string_literal.*::=.*\n", "\n" , text)
#    text = re.sub(r"\nbit_value.*::=.*\n", "\n" , text)
#    text = re.sub(r"\nbase_specifier.*::=.*\n", "\n" , text)
#    # replaces
#    text = re.sub(r" identifier ", " IDENTIFIER " , text)
#    text = re.sub(r" abstract_literal ", " NUMBER " , text)
#    text = re.sub(r" character_literal ", " CHARACTER " , text)
#    text = re.sub(r" string_literal ", " STRING " , text)
#    text = re.sub(r" bit_string_literal ", " BITSTRING " , text)
#    return text

def printStats(text):
    print ("* Stats:")
    results = re.findall(r'([a-z_\d]+) :', text)
    results.sort()
    for res in results:
        uses = re.findall(r'( |\n|__)%s[ \n]' % (res), text)
        num  = len(uses) - 1
        flag = " (not used)" if (num < 1) else ""
        print ("%-50s %3d%s" % (res, num, flag))

###############################################################################
# Main
###############################################################################

text = re.sub(r"([A-Z]{2,})" , r"RW_\1"        , text) # Add RW_ prefix to Reserved Words
text = re.sub(r"::= \|"      , r"::= %empty |" , text)
text = re.sub(r" \| "        , r"\n     | "    , text)
text = re.sub(r"::= "        , r":\n       "   , text)

print (text)

printStats(text)
