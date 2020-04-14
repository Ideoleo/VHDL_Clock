----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2020 09:48:16
-- Design Name: 
-- Module Name: Counter - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Set_Counter is
    generic(N:integer:=5);
    port ( Reset : in STD_LOGIC;
           Clock : in STD_LOGIC;
           Capacity : in STD_LOGIC_VECTOR(N-1 downto 0);
           Count : out STD_LOGIC_VECTOR(N-1 downto 0));
        
end entity Set_Counter;

architecture Synth of Set_Counter is
signal cnt: std_logic_vector(N-1 downto 0);
signal one_second_counter: STD_LOGIC_VECTOR (27 downto 0);
signal one_second_enable: STD_LOGIC;
begin

process(clock, reset)
begin
        if(reset='1') then
            one_second_counter <= (others => '0');
        elsif(rising_edge(clock)) then
            if(one_second_counter>=x"5F5E0FF") then
                one_second_counter <= (others => '0');
            else
                one_second_counter <= one_second_counter + "0000001";
            end if;
        end if;
end process;

one_second_enable <= '1' when one_second_counter=x"5F5E0FF" else '0';


process(clock,reset,capacity)is
begin

if (reset = '1') then
    cnt <= (others => '0');
elsif (rising_edge(clock)) then
    if(one_second_enable = '1') then
        if (cnt = Capacity-1) then
            cnt <= (others => '0');
        else
            cnt <= cnt+1;
        end if;
    end if;
end if;

end process;

Count <=cnt;
end architecture Synth;
