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

def transformations(text):
    text = re.sub(r"([A-Z]{2,})", r"RW_\1" , text)  # Add RW_ prefix to Reserved Words
    text = re.sub(r"::= \|", r"::= %empty |" , text)
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

text = transformations(text)
text = indentate(text)
print ("\n* Code for Bison:\n" + text)
printStats(text)
