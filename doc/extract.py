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
text = re.sub(r"\*[a-z_]+\*", "" , text)        # Delete text between *
text = re.sub(r"([A-Z]{2,})", r"RW_\1" , text) # Delete text between *

# Add "" to characters which are 'part of the syntax'
text = re.sub(r"\[ \[ type_mark", r'"[" [ type_mark' , text)
text = re.sub(r"type_mark \] \]", r'type_mark ] "]"' , text)
text = re.sub(r";", r'";"'       , text)
text = re.sub(r" # ", r' "#" '   , text)
text = re.sub(r" : ", r' ":" '   , text)
text = re.sub(r" :\n", r' ":"\n' , text)
text = re.sub(r" \+ ", r' "+" '  , text)
text = re.sub(r" - ", r' "-" '   , text)
text = re.sub(r" \* ", r' "*" '  , text)
text = re.sub(r" / ", r' "/" '   , text)
text = re.sub(r" \&", r' "&"'    , text)
text = re.sub(r" /=", r' "/="'   , text)
text = re.sub(r" <=", r' "<="'   , text)
text = re.sub(r" >=", r' ">="'   , text)
text = re.sub(r" =>", r' "=>"'   , text)
text = re.sub(r" <>", r' "<>"'   , text)
text = re.sub(r" \*\*", r' "**"' , text)
text = re.sub(r" :=", r' ":="'   , text)
text = re.sub(r" = ", r' "=" '   , text)
text = re.sub(r" < ", r' "<" '   , text)
text = re.sub(r" > ", r' ">" '   , text)
text = re.sub(r" \(", r' "("'    , text)
text = re.sub(r" \)", r' ")"'    , text)
text = re.sub(r" \. ", r' "." '  , text)
text = re.sub(r" , ", r' "," '   , text)
text = re.sub(r" \\ ", r' "\" '  , text)
text = re.sub(r" @ ", r' "@" '   , text)
text = re.sub(r" : ", r' ":" '   , text)
text = re.sub(r" E ", r' "E" '   , text)
text = re.sub(r" B ", r' "B" '   , text)
text = re.sub(r" O ", r' "O" '   , text)
text = re.sub(r" X\n", r' "X"\n' , text)

text = re.sub(r" \| ", r"\n     | " , text)
text = re.sub(r"::= ", r":\n       " , text)

print (text)
