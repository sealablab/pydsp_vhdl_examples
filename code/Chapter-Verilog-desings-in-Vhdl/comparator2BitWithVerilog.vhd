--comparator2BitWithVerilog.vhd

library ieee; 
use ieee.std_logic_1164.all;

entity comparator2BitWithVerilog is
  port(
    a, b : in std_logic_vector(1 downto 0);
    eq : out std_logic
  ); 
end comparator2BitWithVerilog;

architecture structure of comparator2BitWithVerilog is
  signal s0, s1: std_logic; 
  
  -- define Verilog component 
  component comparator1BitVerilog is 
   port(
      x, y : in std_logic;
      eq : out std_logic
   );
  end component;

begin
  -- use Verilog component i.e. comparator1BitVerilog
  eq_bit0: comparator1BitVerilog
    port map (x=>a(0), y=>b(0), eq=>s0);
  eq_bit1: comparator1BitVerilog
    port map (x=>a(1), y=>b(1), eq=>s1);
      
  eq <= s0 and s1;
end structure;  