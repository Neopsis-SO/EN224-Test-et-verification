----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2021 16:02:52
-- Design Name: 
-- Module Name: PGCD - Behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PGCD is
PORT ( 
	CLK      : in  STD_LOGIC;
	RESET    : in  STD_LOGIC;

	idata_a  : in  STD_LOGIC_VECTOR (31 downto 0);
	idata_b  : in  STD_LOGIC_VECTOR (31 downto 0);
	idata_en : in  STD_LOGIC;

	odata    : out STD_LOGIC_VECTOR (31 downto 0);
	odata_en : out STD_LOGIC
	);
end PGCD;

architecture Behavioral of PGCD is
    type Etat is (Etat_RESET, Etat_Compute, Etat_Finished);
    signal pr_state : Etat := Etat_RESET;
    signal data_a, data_b : unsigned (31 downto 0) := x"00000000";

begin
    maj_etat : process(CLK, RESET) -- demandez comment il veut faire pour le compteur hors de la machine d'etat?
    begin
        if (RESET = '1') then
            odata_en <= '0';
            odata <= x"00000000";
            pr_state <= Etat_RESET;
        elsif (CLK'event and CLK = '1') then
            case pr_state is
              when Etat_RESET => 
                --calcul de l etat suivant
                if (idata_en = '1') then
                    assert idata_a <= x"0000FFFF" report "a pas dans intervalle" severity error;
                    assert idata_b <= x"0000FFFF" report "b pas dans intervalle" severity failure;
                  pr_state <= Etat_Compute;
                else
                  pr_state <= Etat_RESET;
                end if;
                
                --affectation des sorties
                data_a <= unsigned(idata_a);
                data_b <= unsigned(idata_b);
                odata_en <= '0';
                
              when Etat_Compute => 
                --calcul de l etat suivant
                if (data_a = data_b or data_a = 0 or data_b = 0) then
                  pr_state <= Etat_Finished;
                else
                  pr_state <= Etat_Compute;
                end if;
                
                --calcul
                if (data_a /= data_b) then
                    if (data_a > data_b) then
                        data_a <= data_a - data_b;
                    else
                        data_b <= data_b - data_a;
                    end if;
                end if;
                
              when Etat_Finished => 
                --calcul de l etat suivant
                pr_state <= Etat_RESET;
                
                --affectation des sorties
                odata_en <= '1';
                if (data_a = 0) then
                    odata <= std_logic_vector(data_b);
                else
                    odata <= std_logic_vector(data_a);
                end if;
            end case;
        end if;
    end process maj_etat;
end Behavioral;
