#!/usr/bin/make

TEMP = ../../temp

FLAGS=-P$(TEMP) --workdir=$(TEMP)

all:
	@mkdir -p $(TEMP)
	ghdl -a $(FLAGS) *.vhdl
	ghdl -e $(FLAGS) -o $(TEMP)/types_vhdl types
	iverilog -o $(TEMP)/types_verilog types.v

test: all
	$(TEMP)/types_vhdl > $(TEMP)/types_vhdl.out
	$(TEMP)/types_verilog > $(TEMP)/types_verilog.out
	diff $(TEMP)/types_vhdl.out $(TEMP)/types_verilog.out

clean:
	rm -fr $(TEMP)
