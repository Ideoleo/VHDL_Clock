----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.04.2020 12:09:26
-- Design Name: 
-- Module Name: Digit_Clock - Behavioral
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
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Digit_Clock is
Port (

clk: in std_logic; --Clock 100 MHz
reset: in std_logic; --For normal operation, this input should be 1
--H_in1: in std_logic_vector (1 downto 0); --most significant bit of hours
--H_in0: in std_logic_vector (3 downto 0); --the least significant bit of hours
--M_in1: in std_logic_vector (3 downto 0); --the most significant bits of minutes
--M_in0: in std_logic_vector (3 downto 0); --the least significiant bits of minutes
--S_in1: in std_logic_vector (3 downto 0); --the most significant bits of seconds
--S_in0: in std_logic_vector (3 downto 0); --the least significiant bits of seconds
Seg_out: out std_logic_vector(6 downto 0); 
Anode_Activate: out std_logic_vector (3 downto 0)

 );
end Digit_Clock;

architecture Behavioral of Digit_Clock is

component bin2hex
port(

Bin: in std_logic_vector(3 downto 0);
Hex: out std_logic_vector(6 downto 0)

);
end component;

component clk_div
port(

clk_100: in std_logic;
clk_1s: out std_logic

);

end component;


signal clk_1s: std_logic;
signal counter_hour, counter_minute, counter_second: integer;

signal H_out1_bin: std_logic_vector(3 downto 0);
signal H_out0_bin: std_logic_vector(3 downto 0);
signal M_out1_bin: std_logic_vector(3 downto 0);
signal M_out0_bin: std_logic_vector(3 downto 0);
signal S_out1_bin: std_logic_vector(3 downto 0);
signal S_out0_bin: std_logic_vector(3 downto 0);
signal H_out1_hex: std_logic_vector(6 downto 0);
signal H_out0_hex: std_logic_vector(6 downto 0);
signal M_out1_hex: std_logic_vector(6 downto 0);
signal M_out0_hex: std_logic_vector(6 downto 0);
signal S_out1_hex: std_logic_vector(6 downto 0);
signal S_out0_hex: std_logic_vector(6 downto 0);


signal refresh_counter: STD_LOGIC_VECTOR (19 downto 0);
-- creating 10.5ms refresh period
signal LED_activating_counter: std_logic_vector(1 downto 0);

begin

create_1s_clock: clk_div port map (clk_100 => clk, clk_1s => clk_1s);

process(clk_1s,reset) begin

if(reset = '1') then

    counter_hour <= 0;
    counter_minute <= 0;
    counter_second <= 0;
    
elsif(rising_edge(clk_1s)) then
 counter_second <= counter_second + 1;
    if(counter_second >=59) then -- second > 59 then minute increases
         counter_minute <= counter_minute + 1;
         counter_second <= 0;
         if(counter_minute >=59) then -- minute > 59 then hour increases
             counter_minute <= 0;
             counter_hour <= counter_hour + 1;
             if(counter_hour >= 24) then -- hour > 24 then set hour to 0
                 counter_hour <= 0;
             end if;
         end if;
    end if;
 end if;
end process;

--Converison Time--
H_out1_bin <= x"2" when counter_hour >=20 else
 x"1" when counter_hour >=10 else
 x"0";
-- 7-Segment LED display of H_out1
convert_hex_H_out1: bin2hex port map (Bin => H_out1_bin, Hex => H_out1_hex); 

-- H_out0 binary value
 H_out0_bin <= std_logic_vector(to_unsigned((counter_hour - to_integer(unsigned(H_out1_bin))*10),4));
 
-- 7-Segment LED display of H_out0
convert_hex_H_out0: bin2hex port map (Bin => H_out0_bin, Hex => H_out0_hex); 

-- M_out1 binary value
 M_out1_bin <= x"5" when counter_minute >=50 else
 x"4" when counter_minute >=40 else
 x"3" when counter_minute >=30 else
 x"2" when counter_minute >=20 else
 x"1" when counter_minute >=10 else
 x"0";
-- 7-Segment LED display of M_out1
convert_hex_M_out1: bin2hex port map (Bin => M_out1_bin, Hex => M_out1_hex); 

-- M_out0 binary value
 M_out0_bin <= std_logic_vector(to_unsigned((counter_minute - to_integer(unsigned(M_out1_bin))*10),4));
 
-- 7-Segment LED display of M_out0
convert_hex_M_out0: bin2hex port map (Bin => M_out0_bin, Hex => M_out0_hex); 

S_out1_bin <= x"5" when counter_second >=50 else
 x"4" when counter_second >=40 else
 x"3" when counter_second >=30 else
 x"2" when counter_second >=20 else
 x"1" when counter_second >=10 else
 x"0";
 
convert_hex_S_out1: bin2hex port map (Bin => S_out1_bin, Hex => S_out1_hex); 
 
S_out0_bin <= std_logic_vector(to_unsigned((counter_second - to_integer(unsigned(S_out1_bin))*10),4));

convert_hex_S_out0: bin2hex port map (Bin => S_out0_bin, Hex => S_out0_hex); 
 
process(clk,reset)
begin 
    if(reset='1') then
        refresh_counter <= (others => '0');
    elsif(rising_edge(clk)) then
        refresh_counter <= refresh_counter + 1;
    end if;
end process;
 LED_activating_counter <= refresh_counter(19 downto 18);
-- 4-to-1 MUX to generate anode activating signals for 4 LEDs 
process(LED_activating_counter)
begin
    case LED_activating_counter is
    when "00" =>
        Anode_Activate <= "0111"; 
        -- activate LED1 and Deactivate LED2, LED3, LED4
        Seg_out <= M_out1_hex;
        -- the first hex digit of the 16-bit number
    when "01" =>
        Anode_Activate <= "1011"; 
        -- activate LED2 and Deactivate LED1, LED3, LED4
        Seg_out <= M_out0_hex;
        -- the second hex digit of the 16-bit number
    when "10" =>
        Anode_Activate <= "1101"; 
        -- activate LED3 and Deactivate LED2, LED1, LED4
        Seg_out <= S_out1_hex;
        -- the third hex digit of the 16-bit number
    when "11" =>
        Anode_Activate <= "1110"; 
        -- activate LED4 and Deactivate LED2, LED3, LED1
        Seg_out <= S_out0_hex;
        -- the fourth hex digit of the 16-bit number    
    end case;
end process;

end Behavioral;






