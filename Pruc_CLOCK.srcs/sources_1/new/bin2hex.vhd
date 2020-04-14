----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.04.2020 12:46:28
-- Design Name: 
-- Module Name: bin2hex - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bin2hex is
port (

 Bin: in STD_LOGIC_VECTOR (3 downto 0);
 Hex: out std_logic_vector(6 downto 0)
 
);
end bin2hex;
architecture Behavioral of bin2hex is

begin
 process(Bin)
 begin
  case(Bin) is
   when "0000" =>  Hex <= "0000001"; --0--
   when "0001" =>  Hex <= "1001111"; --1--
   when "0010" =>  Hex <= "0010010"; --2--
   when "0011" =>  Hex <= "0000110"; --3--
   when "0100" =>  Hex <= "1001100"; --4-- 
   when "0101" =>  Hex <= "0100100"; --5--    
   when "0110" =>  Hex <= "0100000"; --6--
   when "0111" =>  Hex <= "0001111"; --7--   
   when "1000" =>  Hex <= "0000000"; --8--
   when "1001" =>  Hex <= "0000100"; --9--
   when "1010" =>  Hex <= "0000010"; --a--
   when "1011" =>  Hex <= "1100000"; --b--
   when "1100" =>  Hex <= "0110001"; --c--
   when "1101" =>  Hex <= "1000010"; --d--
   when "1110" =>  Hex <= "0110000"; --e--
   when others =>  Hex <= "0111000"; 
   end case;
 end process;

 
end Behavioral;
