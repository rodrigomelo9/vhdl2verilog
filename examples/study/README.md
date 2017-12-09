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
| std_logic                            | *nothing*                            |
| std_logic_vector[7 downto 0]         | [7:0]                                |
| signed[7 downto 0]                   | signed [7:0]                         |
| unsigned[7 downto 0]                 | [7:0]                                |
| std_ulogic                           | *nothing*                            |
| std_ulogic_vector[7 downto 0]        | [7:0]                                |
| bit                                  | *nothing*                            |
| bit_vector[7 downto 0]               | [7:0]                                |
| boolean                              | *nothing*                            |
| string(1 to 10)                      | [10*8:1]                             |
| character                            | [8:1]                                |
| real                                 | real                                 |
| time                                 | time                                 |

* Note: $clog2 is not part of Verilog 2001. It can be implemented as a function.

## Constants and Generics

| VHDL                                 | Verilog                              |
|--------------------------------------|--------------------------------------|
| constant                             | localparam                           |
| *generic declaration*                | parameter                            |

* Note: unconstrained strings seems not allowed in both standards, however,
some tools support them as generic/parameter and constant/localparam.

## Operators

| VHDL                      | Verilog                                         |
|---------------------------|-------------------------------------------------|
| NOT A                     | ~A *(bit-wise)*, !A *(logical)*                 |
| A AND B                   | A & B *(bit-wise)*, A && B *(logical)*          |
| A OR B                    | A \| B *(bit-wise)*, A \|\| B *(logical)*       |
| A XOR B                   | A ^ B *(bit-wise)*                              |
| A NAND B                  | ~(A & B) *(bit-wise)*, !(A && B) *(logical)*    |
| A NOR B                   | ~(A \| B) *(bit-wise)*, !(A \|\| B) *(logical)* |
| A XNOR B                  | ~(A ^ B) *(bit-wise)*                           |
| ABS A                     | ( ( A < 0 ) ? -A : A )                          |
| A REM B                   | A % B                                           |
| A MOD B                   | *???*                                           |
| A SLL B                   | A << B                                          |
| A SRL B                   | A >> B                                          |
| A SLA B                   | A <<< B                                         |
| A SRA B                   | A >>> B                                         |
| A ROR B                   | *???*                                           |
| A ROL B                   | *???*                                           |
