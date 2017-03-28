#!/usr/bin/make
# by RAM

all: vhdl2verilog

vhdl2verilog.tab.c vhdl2verilog.tab.h: vhdl2verilog.y
	bison -d $<

lex.yy.c: ../src/vhdl2verilog.l vhdl2verilog.tab.h
	flex $<

vhdl2verilog: lex.yy.c vhdl2verilog.tab.c
	cc -o $@ vhdl2verilog.tab.c lex.yy.c -lfl

clean:
	rm -fr vhdl2verilog.tab.c vhdl2verilog.tab.h lex.yy.c vhdl2verilog
