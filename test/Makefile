#!/usr/bin/make
# by RAM

all: testTokens

vhdl2verilog.tab.c vhdl2verilog.tab.h: testTokens.y
	bison -d $< -o vhdl2verilog.tab.c

lex.yy.c: ../src/vhdl2verilog.l vhdl2verilog.tab.h
	flex $<

testTokens: lex.yy.c vhdl2verilog.tab.c
	cc -o $@ vhdl2verilog.tab.c lex.yy.c -lfl

clean:
	rm -fr vhdl2verilog.tab.c vhdl2verilog.tab.h lex.yy.c testTokens
