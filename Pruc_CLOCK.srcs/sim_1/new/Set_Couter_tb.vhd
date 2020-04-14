library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Set_Counter_tb is
end;

architecture bench of Set_Counter_tb is

  component Set_Counter
      generic(N:integer:=5);
      port ( Reset : in STD_LOGIC;
             Clock : in STD_LOGIC;
             Capacity : in STD_LOGIC_VECTOR(N-1 downto 0);
             Count : out STD_LOGIC_VECTOR(N-1 downto 0));
  end component;

  signal Reset: STD_LOGIC :='0';
  signal Clock: STD_LOGIC :='0';
  signal Capacity: STD_LOGIC_VECTOR(4 downto 0);
  signal Count: STD_LOGIC_VECTOR(4 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: Set_Counter generic map ( N        => 5  )
                      port map ( Reset    => Reset,
                                 Clock    => Clock,
                                 Capacity => Capacity,
                                 Count    => Count );

  stimulus: process
  begin
  
    -- Put initialisation code here

    reset <= '0';
    wait for 5 ns;
    reset <= '1';
    wait for 20 ns;
    capacity <= "00111";
    wait for 1 us;
  
    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clock <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;