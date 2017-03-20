#!/usr/bin/python 
# by RAM

import re

text = open('vhdl93.bnf', 'r').read()
text = re.sub(r"(?m)^;.*\n", "", text)   # Deleting comments

reserved = re.findall("[A-Z]{2,}", text) # Catching reserved words
reserved = list(set( reserved ))         # Deleting duplicates
reserved.sort()

print ("* Reserved words (%d):" % len(reserved))
print (", ".join(reserved))

print ("")

print ("* Reserved Words for Flex code")
for word in reserved:
    print ("%-30s{ return TOK_%-14s }" % ("\"" + word.lower() + "\"", word + ";") )

