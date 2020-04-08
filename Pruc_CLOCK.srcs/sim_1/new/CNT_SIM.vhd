library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Counter_tb is
end;

architecture bench of Counter_tb is

  component Counter
      Port ( CLK : in STD_LOGIC;
             Q0 : out STD_LOGIC;
             Q1 : out STD_LOGIC;
             Q2 : out STD_LOGIC;
             Q3 : out STD_LOGIC;
             Q4 : out STD_LOGIC);
  end component;

  signal CLK: STD_LOGIC;
  signal Q0: STD_LOGIC;
  signal Q1: STD_LOGIC;
  signal Q2: STD_LOGIC;
  signal Q3: STD_LOGIC;
  signal Q4: STD_LOGIC;

begin

  uut: Counter port map ( CLK => CLK,
                          Q0  => Q0,
                          Q1  => Q1,
                          Q2  => Q2,
                          Q3  => Q3,
                          Q4  => Q4 );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    wait;
  end process;


end;