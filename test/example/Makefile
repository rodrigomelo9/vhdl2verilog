#!/usr/bin/make
# by RAM

all: example_bin

example.tab.c example.tab.h: example.y
	bison -d $<

lex.yy.c: example.l example.tab.h
	flex $<

example_bin: lex.yy.c example.tab.c
	cc -g -O1 -o $@ example.tab.c lex.yy.c -lfl

clean:
	rm -fr example.tab.c example.tab.h lex.yy.c example_bin

run: example_bin
	valgrind --leak-check=yes ./example_bin
