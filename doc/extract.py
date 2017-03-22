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

print ("\n\n")

print ("* Reserved Words for Flex code")
for word in reserved:
    print ("%-30s{ return RW_%-14s }" % ("\"" + word.lower() + "\"", word + ";") )

print ("\n\n")

print ("* Bison code:")
text = re.sub(r"\n ", " ", text)                # Deleting line jumps
text = re.sub(r"\n{2,}", "\n\n" , text)         # Delete multiple line jumps
text = re.sub(r" +", " " , text)                # Delete multiple spaces
text = re.sub(r"([A-Z]{2,})", r"RW_\1" , text)  # Add RW_ prefix to Reserved Words

# Add "" to characters which are 'part of the syntax'
text = re.sub(r"\[ \[ type_mark", r"'[' [ type_mark" , text) # for the special case of signatures
text = re.sub(r"type_mark \] \]", r"type_mark ] ']'" , text) # for the special case of signatures

text = re.sub(r" (/=|<=|>=|=>|<>|:=|\*\*)([ \n])" , r' "\1"\2' , text)
text = re.sub(r" (\(|\)|\\)([ \n])"               , r" '\1'\2" , text)
text = re.sub(r" ([;#&@+-:*/=<>,.])([ \n])"       , r" '\1'\2" , text)

text = re.sub(r" ([EBOX])([ \n])" , r" '\1'\2" , text) # Bases and scientific notation
text = re.sub(r" (\") "           , r" '\1' "  , text) # apostrophe
text = re.sub(r" ' "              , r" '\'' "  , text) # apostrophe

# Indentate
text = re.sub(r" \| ", r"\n     | " , text)
text = re.sub(r"::= ", r":\n       " , text)

print (text)

results = re.findall(r'([a-z_]+) :', text)
results.sort()
for res in results:
    uses = re.findall(r'%s' % (res), text)
    num  = len(uses) - 1
    flag = "(not used)" if (num < 1) else ""
    print ("%-40s %3d %s" % (res, num, flag))
