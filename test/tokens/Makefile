#!/usr/bin/make
# by RAM

all: tokens_bin

vhdl2verilog.tab.c vhdl2verilog.tab.h: tokens.y
	bison -d $< -o vhdl2verilog.tab.c

lex.yy.c: ../../src/vhdl2verilog.l vhdl2verilog.tab.h
	flex $<

tokens_bin: lex.yy.c vhdl2verilog.tab.c
	cc -o $@ vhdl2verilog.tab.c lex.yy.c -lfl

run: tokens_bin
	cat input.txt | ./tokens_bin > result.txt
	diff -u output.txt result.txt
	@echo PASS

clean:
	rm -fr vhdl2verilog.tab.c vhdl2verilog.tab.h lex.yy.c tokens_bin result.txt
