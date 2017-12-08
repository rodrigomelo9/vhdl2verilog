## Types

| VHDL                                 | Verilog                              |
|--------------------------------------|--------------------------------------|
| integer                              | signed [31:0]                        |
| integer range 0 to 10                | [$clog2(10)-1:0]                     |
| integer range -1 to 10               | signed [$clog2(10):0]                |
| integer range -20 to 5               | signed [$clog2(20):0]                |
| natural                              | [31:0]                               |
| natural range 0 to 10                | [$clog2(10)-1:0]                     |
| positive                             | [31:0]                               |
| positive range 5 to 10               | [$clog2(10)-1:0]                     |
| signed[7 downto 0]                   | signed [7:0]                         |
| unsigned[7 downto 0]                 | [7:0]                                |
| std_logic_vector[7 downto 0]         | [7:0]                                |

* Note: $clog2 is not part of Verilog 2001. It can be implemented as a function.
