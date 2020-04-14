library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity clk_div is
port (
   clk_100: in std_logic;
   clk_1s: out std_logic
  );
end clk_div;
architecture Behavioral of clk_div is
signal counter: std_logic_vector(27 downto 0):=(others =>'0');
begin
 process(clk_100)
 begin
  if(rising_edge(clk_100)) then
   counter <= counter + x"0000001";
   if(counter>=x"5F5E0FF") then -- for running on FPGA -- comment when running simulation
   --if(counter_slow>=x"0000001") then -- for running simulation -- comment when running on FPGA
    counter <= x"0000000";
   end if;
  end if;
 end process;
 clk_1s <= '0' when counter < x"2FAF07F" else '1';
end Behavioral;