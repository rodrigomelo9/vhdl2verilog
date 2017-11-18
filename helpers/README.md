# Helpers and how to use it

## e2bnf.py

Converts from the Extended Backus-Naur Form (EBNF) used in VHDL93 to BNF. An explanation can be
found in [From the BNF variant of VHDL93 to rules for Bison](../doc/README.md).

Example:
```
cat ../doc/vhdl93.bnf | python e2bnf.py
```

## bnf2bison.py

Used to convert the BNF in code for Bison.
It also gives some statics to know if there are unused rules.

Example:
```
cat ../doc/vhdl93.bnf | python e2bnf.py | python bnf2bison.py
```

## reservedWords.py

Used to convert the BNF in code for Flex.

Example:
```
cat ../doc/vhdl93.bnf | python e2bnf.py | python reservedWords.py
```
