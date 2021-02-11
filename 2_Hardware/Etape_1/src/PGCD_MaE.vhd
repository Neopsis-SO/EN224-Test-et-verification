----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2021 16:35:38
-- Design Name: 
-- Module Name: PGCD_MaE - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PGCD_MaE is
Port ( 
    CLK      : in  STD_LOGIC;
	RESET    : in  STD_LOGIC;
	idata_en : in  STD_LOGIC;
    Etat_Machine : out STD_LOGIC_VECTOR (1 downto 0));
end PGCD_MaE;

architecture Behavioral of PGCD_MaE is
type Etat is (Etat_RESET, Etat_Compute, Etat_Finished);
  signal pr_state, nx_state : Etat := Etat_RESET;
begin
  maj_etat : process(CLK, RESET) -- demandez comment il veut faire pour le compteur hors de la machine d'etat?
  begin
    if (RESET = '1') then
        pr_state <= Etat_RESET;
    elsif (CLK'event and CLK = '1') then
        case pr_state is
          when Etat_RESET => 
            odata_en <= '0';
            if (idata_en = '1') then
              pr_state <= Etat_Compute;
            else
              pr_state <= Etat_RESET;
            end if;
            
          when Etat_Compute => 
            if () then
              pr_state <= Etat_Finished;
            else
              pr_state <= Etat_Compute;
            end if;
            
          when Etat_Finished => 
            odata_en <= '1';
            odata <= a;
              pr_state <= Etat_RESET;
        end case;
    end if;
  end process maj_etat;
  
  cal_nx_state : process (idata_en, odata_en)
  begin
    
  end process cal_nx_state;
  
    cal_output : process (pr_state)
  begin
    case pr_state is
      when Etat_RESET => Etat_Machine <= "00";  
      when Etat_RAZtoM => Etat_Machine <= "01";
      when Etat_M => Etat_Machine <= "10";
    end case;
  end process cal_output;
end Behavioral;
