# VHDL93

## From the BNF variant of VHDL93 to rules for Bison

Text transformations:
* Added RW_ prefix to Reserved Words to avoid name collision (as example, BEGIN is a Flex action).
* Added Single Quote to literal character tokens.
* Added Double Quote to literal string tokens.

Optional rules were made explicit:
* [] means 0 or 1 time.
* {} means 0 or more times.
