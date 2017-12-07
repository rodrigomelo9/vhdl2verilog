library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity types_syn is
   port (
      clk_i  :  in std_logic;
      --
      int1_i :  in integer range    0 to 100;
      int2_i :  in integer range -100 to 100;
      int3_i :  in integer range   -1 to 100;
      int4_i :  in integer range -100 to 1;
      int5_i :  in integer range   99 to 100;
      nat1_i :  in integer range    0 to 100;
      nat2_i :  in integer range   99 to 100;
      pos1_i :  in integer range    0 to 100;
      pos2_i :  in integer range   99 to 100;
      --
      int1_o : out integer range    0 to 100;
      int2_o : out integer range -100 to 100;
      int3_o : out integer range   -1 to 100;
      int4_o : out integer range -100 to 1;
      int5_o : out integer range   99 to 100;
      nat1_o : out integer range    0 to 100;
      nat2_o : out integer range   99 to 100;
      pos1_o : out integer range    0 to 100;
      pos2_o : out integer range   99 to 100
   );
end entity types_syn;

architecture rtl of types_syn is
begin

   regs_i : process (clk_i)
   begin
      if rising_edge(clk_i) then
         int1_o <= int1_i; -- 7 FFs
         int2_o <= int2_i; -- 8 FFs
         int3_o <= int3_i; -- 8 FFs
         int4_o <= int4_i; -- 8 FFs
         int5_o <= int5_i; -- 7 FFs
         nat1_o <= nat1_i; -- 7 FFs
         nat2_o <= nat2_i; -- 7 FFs
         pos1_o <= pos1_i; -- 7 FFs
         pos2_o <= pos2_i; -- 7 FFs
      end if;
   end process regs_i;

end architecture rtl;
