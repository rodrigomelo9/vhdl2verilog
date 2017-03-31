#!/usr/bin/make
# by RAM

all: example

example.tab.c example.tab.h: example.y
	bison -d $<

lex.yy.c: example.l example.tab.h
	flex $<

example: lex.yy.c example.tab.c
	cc -g -O1 -o $@ example.tab.c lex.yy.c -lfl

clean:
	rm -fr example.tab.c example.tab.h lex.yy.c example

run:
	valgrind --leak-check=yes ./example
