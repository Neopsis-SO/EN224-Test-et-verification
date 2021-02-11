----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2021 17:49:00
-- Design Name: 
-- Module Name: tb_PGCD - Behavioral
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

-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity tb_PGCD is
end;

architecture bench of tb_PGCD is

  component PGCD
  PORT ( 
  	CLK      : in  STD_LOGIC;
  	RESET    : in  STD_LOGIC;
  	idata_a  : in  STD_LOGIC_VECTOR (31 downto 0);
  	idata_b  : in  STD_LOGIC_VECTOR (31 downto 0);
  	idata_en : in  STD_LOGIC;
  	odata    : out STD_LOGIC_VECTOR (31 downto 0);
  	odata_en : out STD_LOGIC
  	);
  end component;

  signal CLK: STD_LOGIC;
  signal RESET: STD_LOGIC;
  signal idata_a: STD_LOGIC_VECTOR (31 downto 0);
  signal idata_b: STD_LOGIC_VECTOR (31 downto 0);
  signal idata_en: STD_LOGIC;
  signal odata: STD_LOGIC_VECTOR (31 downto 0);
  signal odata_en: STD_LOGIC ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: PGCD port map ( CLK      => CLK,
                       RESET    => RESET,
                       idata_a  => idata_a,
                       idata_b  => idata_b,
                       idata_en => idata_en,
                       odata    => odata,
                       odata_en => odata_en );

  stimulus: process
  begin
  
    -- Put initialisation code here
    RESET <= '1';
    idata_en <= '0';
    idata_a <= x"00000000";
    idata_b <= x"00000000";
    wait for 4*clock_period;
    
    -- Put test bench stimulus code here
    
    RESET <= '0';
    wait for 4*clock_period;
    
    idata_a <= x"00000000";
    idata_b <= x"00000001";
    idata_en <= '1';
    wait for clock_period;
    
    idata_a <= x"00000000";
    idata_b <= x"00000000";
    while odata_en = '0' loop
        idata_en <= '0';
        wait for clock_period;
    end loop;
    ASSERT UNSIGNED(odata) = TO_UNSIGNED( 1, 32) SEVERITY ERROR;
    
    idata_a <= x"00000002";
    idata_b <= x"00000000";
    idata_en <= '1';
    wait for clock_period;
    
    idata_a <= x"00000000";
    idata_b <= x"00000000";
    while odata_en = '0' loop
        idata_en <= '0';
        wait for clock_period;
    end loop;
    ASSERT UNSIGNED(odata) = TO_UNSIGNED( 2, 32) SEVERITY ERROR;
    
    idata_a <= x"00000000";
    idata_b <= x"00000000";
    idata_en <= '1';
    wait for clock_period;
    
    idata_a <= x"00000000";
    idata_b <= x"00000000";
    while odata_en = '0' loop
        idata_en <= '0';
        wait for clock_period;
    end loop;
    ASSERT UNSIGNED(odata) = TO_UNSIGNED( 0, 32) SEVERITY ERROR;
    
    idata_a <= x"00FFFFFF";
    idata_b <= x"0000FFFF";
    idata_en <= '1';
    wait for clock_period;
    
    idata_a <= x"00000000";
    idata_b <= x"00000000";
    while odata_en = '0' loop
        idata_en <= '0';
        wait for clock_period;
    end loop;
    ASSERT UNSIGNED(odata) = TO_UNSIGNED( 255, 32) SEVERITY ERROR;
    
    idata_a <= x"00000002";
    idata_b <= x"00000001";
    idata_en <= '1';
    wait for clock_period;
    
    idata_a <= x"00000000";
    idata_b <= x"00000000";
    while odata_en = '0' loop
        idata_en <= '0';
        wait for clock_period;
    end loop;
    ASSERT UNSIGNED(odata) = TO_UNSIGNED( 1, 32) SEVERITY ERROR;
    
    idata_a <= x"00000018";
    idata_b <= x"00000060";
    idata_en <= '1';
    wait for clock_period;
    
    idata_a <= x"00000000";
    idata_b <= x"00000000";
    while odata_en = '0' loop
        idata_en <= '0';
        wait for clock_period;
    end loop;
    ASSERT UNSIGNED(odata) = TO_UNSIGNED( 23, 32) SEVERITY ERROR;
    
    idata_a <= x"0000FFFF";
    idata_b <= x"000000FF";
    idata_en <= '1';
    wait for clock_period;
    
    idata_a <= x"00000000";
    idata_b <= x"00000000";
    while odata_en = '0' loop
        idata_en <= '0';
        wait for clock_period;
    end loop;
    ASSERT UNSIGNED(odata) = TO_UNSIGNED( 254, 32) SEVERITY failure;
    
    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;


end;
