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

import argparse, re, os, sys

parser = argparse.ArgumentParser(description='Get Reserved Words (UPPERCASE) from a BNF.')
parser.add_argument('file', metavar='BNF_FILE', nargs=1, help='BNF file Name')

opts = parser.parse_args()
file = opts.file[0]

if not os.path.isfile(file):
   sys.exit("%s doesn't exists or is not a file" % (file))

text = open(file, 'r').read()

###############################################################################
# Functions
###############################################################################

def clean(text):
    text = re.sub(r"(?m)^;.*\n", "", text)          # Deleting comments
    text = re.sub(r"\n ", " ", text)                # Deleting line jumps
    text = re.sub(r"\n{2,}", "\n\n" , text)         # Delete multiple line jumps
    text = re.sub(r" +", " " , text)                # Delete multiple spaces
    text = re.sub(r"([A-Z]{2,})", r"RW_\1" , text)  # Add RW_ prefix to Reserved Words
    return text

def addQuotes(text):
    text = re.sub(r"\[ \[ type_mark", r"'[' [ type_mark" , text) # for the special case of signatures
    text = re.sub(r"type_mark \] \]", r"type_mark ] ']'" , text) # for the special case of signatures
    text = re.sub(r" (/=|<=|>=|=>|<>|:=|\*\*)([ \n])" , r' "\1"\2' , text)
    text = re.sub(r" (\(|\)|\\)([ \n])"               , r" '\1'\2" , text)
    text = re.sub(r" ([;#&@+-:*/=<>,.])([ \n])"       , r" '\1'\2" , text)
    text = re.sub(r" ([EBOX])([ \n])" , r" '\1'\2" , text) # Bases and scientific notation
    text = re.sub(r" (\") "           , r" '\1' "  , text) # apostrophe
    text = re.sub(r" ' "              , r" '\'' "  , text) # apostrophe
    return text

def unroll(text):
    num = 0
    result  = re.match(r"[a-z_]*",text).group(0)
    # aaa : bbb [ ccc [ ddd ] ] [ eee [ fff ] ] ggg
    matches = re.findall(r"\[ (.*? \[ .*? \]) \]",text)
    for match in matches:
        num+=1
        newresult = "%s_opt%d" % (result, num)
        text = text.replace("[ %s ]" % (match), newresult, 1)
        text += "\n\n" + newresult + " : | " + match
    # aaa : bbb [ ccc ] ddd [ eee ] [ fff ] ggg
    matches = re.findall(r"\[ (.*?) \]",text)
    for match in matches:
        num+=1
        newresult = "%s_opt%d" % (result, num)
        text = text.replace("[ %s ]" % (match), newresult, 1)
        text += "\n\n" + newresult + " : | " + match
    # aaa : { bbb } -> aaa : | bbb
    text = re.sub(r"::= { (.*?) }",r"| \1",text)
    # Others {}
    matches = re.findall(r"{ (.*?) }",text)
    for match in matches:
        num+=1
        newresult1 = "%s_opt%d" % (result, num)
        num+=1
        newresult2 = "%s_opt%d" % (result, num)
        text = text.replace("{ %s }" % (match), newresult1, 1)
        text += "\n\n" + newresult1 + " : | " + newresult1 + " " + newresult2
        text += "\n\n" + newresult2 + " : " + match
    return text

def indentate(text):
    text = re.sub(r" \| ", r"\n     | " , text)
    text = re.sub(r"::= ", r":\n       " , text)
    return text

def printStats(text):
    print ("* Stats:")
    results = re.findall(r'([a-z_\d]+) :', text)
    results.sort()
    for res in results:
        uses = re.findall(r' ?%s[ \n]' % (res), text)
        num  = len(uses) - 1
        flag = " (not used)" if (num < 1) else ""
        print ("%-50s %3d%s" % (res, num, flag))

###############################################################################
# Main
###############################################################################

text = clean(text)
text = addQuotes(text)

lines = text.split("\n")
text = ""
for line in lines:
    text += unroll(line) + "\n"

text = indentate(text)

printStats(text)

print ("\n* Code for Bison:\n" + text)
