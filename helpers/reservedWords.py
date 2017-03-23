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
text = re.sub(r"(?m)^;.*\n", "", text)   # Deleting comments

reserved = re.findall("[A-Z]{2,}", text) # Catching reserved words
reserved = list(set( reserved ))         # Deleting duplicates
reserved.sort()

print ("* Reserved words (%d):" % len(reserved))
print (", ".join(reserved))

print ("\n")

print ("* Code for Flex")
for word in reserved:
    print ("%-30s{ return RW_%-14s }" % ("\"" + word.lower() + "\"", word + ";") )
