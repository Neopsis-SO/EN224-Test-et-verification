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
use STD.textio.all;
use ieee.std_logic_textio.all;

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
  signal idata_c: STD_LOGIC_VECTOR (31 downto 0);
  signal idata_en: STD_LOGIC;
  signal odata: STD_LOGIC_VECTOR (31 downto 0);
  signal odata_en: STD_LOGIC ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;
  
  file file_data_a : text;
  file file_data_b : text;
  file file_data_c : text;

begin

  uut: PGCD port map ( CLK      => CLK,
                       RESET    => RESET,
                       idata_a  => idata_a,
                       idata_b  => idata_b,
                       idata_en => idata_en,
                       odata    => odata,
                       odata_en => odata_en );

  stimulus: process
  variable v_ILINE_a     : line;
  variable v_ILINE_b     : line;
  variable v_ILINE_c     : line;
  variable v_idata_a: STD_LOGIC_VECTOR (31 downto 0);
  variable v_idata_b: STD_LOGIC_VECTOR (31 downto 0);
  variable v_idata_c: STD_LOGIC_VECTOR (31 downto 0);
  
  begin
    -- Put initialisation code here
    file_open(file_data_a, "data_a.txt", read_mode);
    file_open(file_data_b, "data_b.txt", read_mode);
    file_open(file_data_c, "data_c.txt", read_mode);
    
    RESET <= '1';
    idata_en <= '0';
    idata_a <= x"00000000";
    idata_b <= x"00000000";
    
    wait for 4*clock_period;
    
    -- Put test bench stimulus code here
    
    RESET <= '0';
    wait for 4*clock_period;
    
    while ((not endfile(file_data_a)) and (not endfile(file_data_b)) and (not endfile(file_data_c))) loop
        readline(file_data_a, v_ILINE_a);
        read(v_ILINE_a, v_idata_a);
        idata_a <= v_idata_a;
        
        readline(file_data_b, v_ILINE_b);
        read(v_ILINE_b, v_idata_b);
        idata_b <= v_idata_b;
        
        readline(file_data_c, v_ILINE_c);
        read(v_ILINE_c, v_idata_c);
        idata_c <= v_idata_c;
        
        idata_en <= '1';
        wait for clock_period;
        
        idata_a <= x"00000000";
        idata_b <= x"00000000";
        while odata_en = '0' loop
            idata_en <= '0';
            wait for clock_period;
        end loop;
        ASSERT UNSIGNED(odata) = UNSIGNED(idata_c) SEVERITY ERROR;
    end loop;
    
    file_close(file_data_a);
    file_close(file_data_b);
    file_close(file_data_c);
    
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
