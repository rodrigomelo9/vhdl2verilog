## Types

* VHDL
```
signal NAME1  : integer;
signal NAME2  : integer range 0 to 10;
signal NAME3  : integer range -1 to 10;
signal NAME4  : integer range -20 to 5;
signal NAME5  : natural;
signal NAME6  : natural range 0 to 10;
signal NAME7  : positive;
signal NAME8  : positive range 5 to 10;
signal NAME9  : signed[7 downto 0];
signal NAME10 : unsigned[7 downto 0];
signal NAME11 : std_logic_vector[7 downto 0];

* Verilog
```
reg signed [31:0]           NAME1;
reg signed [$clog2(10)-1:0] NAME2;
reg signed [$clog2(10):0]   NAME3;
reg signed [$clog2(20):0]   NAME4;
reg        [31:0]           NAME5;
reg        [$clog2(10)-1:0] NAME6;
reg        [31:0]           NAME7;
reg        [$clog2(10)-1:0] NAME8;
reg signed [7:0]            NAME9;
reg        [7:0]            NAME10;
reg        [7:0]            NAME11;
```

* Note: $clog2 is not part of Verilog 2001. It can be implemented as a function.
