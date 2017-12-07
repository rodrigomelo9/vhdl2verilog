library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library STD;
use STD.textio.all;

entity types is
end entity types;

architecture rtl of types is
   procedure display(message: string) is
      variable l : line;
   begin
      write(l,message);
      writeline(output,l);
   end procedure display;
begin

   test: process
      variable int_r, int_a, int_b : integer;
      variable nat_r, nat_a, nat_b : natural;
      variable pos_r, pos_a, pos_b : positive;
      variable sig_r, sig_a, sig_b : signed(7 downto 0);
      variable uns_r, uns_a, uns_b : unsigned(7 downto 0);
   begin
      display("Integer");
      int_a :=  9;
      int_b :=  2;
      int_r := int_a + int_b;  display(integer'image(int_r));
      int_r := int_a - int_b;  display(integer'image(int_r));
      int_r := int_a * int_b;  display(integer'image(int_r));
      int_r := int_a / int_b;  display(integer'image(int_r));
      int_a :=  9;
      int_b := -2;
      int_r := int_a + int_b;  display(integer'image(int_r));
      int_r := int_a - int_b;  display(integer'image(int_r));
      int_r := int_a * int_b;  display(integer'image(int_r));
      int_r := int_a / int_b;  display(integer'image(int_r));
      int_a := -9;
      int_b :=  2;
      int_r := int_a + int_b;  display(integer'image(int_r));
      int_r := int_a - int_b;  display(integer'image(int_r));
      int_r := int_a * int_b;  display(integer'image(int_r));
      int_r := int_a / int_b;  display(integer'image(int_r));
      int_a := -9;
      int_b := -2;
      int_r := int_a + int_b;  display(integer'image(int_r));
      int_r := int_a - int_b;  display(integer'image(int_r));
      int_r := int_a * int_b;  display(integer'image(int_r));
      int_r := int_a / int_b;  display(integer'image(int_r));
      int_r := -int_r;         display(integer'image(int_r));
      display("Natural");
      nat_a :=  9;
      nat_b :=  2;
      nat_r := nat_a + nat_b;  display(integer'image(nat_r));
      nat_r := nat_a - nat_b;  display(integer'image(nat_r));
      nat_r := nat_a * nat_b;  display(integer'image(nat_r));
      nat_r := nat_a / nat_b;  display(integer'image(nat_r));
      display("Positive");
      pos_a :=  9;
      pos_b :=  2;
      pos_r := pos_a + pos_b;  display(integer'image(pos_r));
      pos_r := pos_a - pos_b;  display(integer'image(pos_r));
      pos_r := pos_a * pos_b;  display(integer'image(pos_r));
      pos_r := pos_a / pos_b;  display(integer'image(pos_r));
      display("Signed");
      sig_a := to_signed(9,8);
      sig_b := to_signed(2,8);
      sig_r := sig_a + sig_b;                         display(integer'image(to_integer(sig_r)));
      sig_r := sig_a - sig_b;                         display(integer'image(to_integer(sig_r)));
      sig_r := sig_a(4 downto 0) * sig_b(2 downto 0); display(integer'image(to_integer(sig_r)));
      sig_r := sig_a / sig_b;                         display(integer'image(to_integer(sig_r)));
      sig_a := to_signed( 9,8);
      sig_b := to_signed(-2,8);
      sig_r := sig_a + sig_b;                         display(integer'image(to_integer(sig_r)));
      sig_r := sig_a - sig_b;                         display(integer'image(to_integer(sig_r)));
      sig_r := sig_a(4 downto 0) * sig_b(2 downto 0); display(integer'image(to_integer(sig_r)));
      sig_r := sig_a / sig_b;                         display(integer'image(to_integer(sig_r)));
      sig_a := to_signed(-9,8);
      sig_b := to_signed( 2,8);
      sig_r := sig_a + sig_b;                         display(integer'image(to_integer(sig_r)));
      sig_r := sig_a - sig_b;                         display(integer'image(to_integer(sig_r)));
      sig_r := sig_a(4 downto 0) * sig_b(2 downto 0); display(integer'image(to_integer(sig_r)));
      sig_r := sig_a / sig_b;                         display(integer'image(to_integer(sig_r)));
      sig_a := to_signed(-9,8);
      sig_b := to_signed(-2,8);
      sig_r := sig_a + sig_b;                         display(integer'image(to_integer(sig_r)));
      sig_r := sig_a - sig_b;                         display(integer'image(to_integer(sig_r)));
      sig_r := sig_a(4 downto 0) * sig_b(2 downto 0); display(integer'image(to_integer(sig_r)));
      sig_r := sig_a / sig_b;                         display(integer'image(to_integer(sig_r)));
      sig_r := -sig_r;                                display(integer'image(to_integer(sig_r)));
      display("Unsigned");
      uns_a := to_unsigned(9,8);
      uns_b := to_unsigned(2,8);
      uns_r := uns_a + uns_b;                         display(integer'image(to_integer(uns_r)));
      uns_r := uns_a - uns_b;                         display(integer'image(to_integer(uns_r)));
      uns_r := uns_a(4 downto 0) * uns_b(2 downto 0); display(integer'image(to_integer(uns_r)));
      uns_r := uns_a / uns_b;                         display(integer'image(to_integer(uns_r)));
      wait;
   end process test;

end architecture rtl;
