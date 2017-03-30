#!/usr/bin/make
# by RAM

all: tokens

vhdl2verilog.tab.c vhdl2verilog.tab.h: tokens.y
	bison -d $< -o vhdl2verilog.tab.c

lex.yy.c: ../../src/vhdl2verilog.l vhdl2verilog.tab.h
	flex $<

tokens: lex.yy.c vhdl2verilog.tab.c
	cc -o $@ vhdl2verilog.tab.c lex.yy.c -lfl

clean:
	rm -fr vhdl2verilog.tab.c vhdl2verilog.tab.h lex.yy.c tokens
