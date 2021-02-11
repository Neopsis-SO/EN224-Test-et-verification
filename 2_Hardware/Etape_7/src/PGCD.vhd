library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity PGCD is
    Port ( 
           CLK      : in  STD_LOGIC;
           RESET    : in  STD_LOGIC;

           idata_a  : in  STD_LOGIC_VECTOR (31 downto 0);
           idata_b  : in  STD_LOGIC_VECTOR (31 downto 0);
           idata_en : in  STD_LOGIC;

           odata    : out STD_LOGIC_VECTOR (31 downto 0);
           odata_en : out STD_LOGIC
	);
end PGCD;

ARCHITECTURE Behavioral of PGCD IS
type Etat is (Etat_RESET, Etat_Compute, Etat_Finished);
    signal pr_state : Etat := Etat_RESET;
    signal data_a, data_b : unsigned (31 downto 0) := x"00000000";
    -- pragma translate_off
    signal nb_clock : unsigned (31 downto 0) := x"00000000";
    -- pragma translate_on

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
                  -- pragma translate_off
                  nb_clock <= x"00000000";
                  -- pragma translate_on
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
                    -- pragma translate_off
                    nb_clock <= nb_clock + 1;
                    -- pragma translate_on
                    if (data_a > data_b) then
                        data_a <= data_a - data_b;
                    else
                        data_b <= data_b - data_a;
                    end if;
                end if;
                
              when Etat_Finished => 
                --calcul de l etat suivant
                pr_state <= Etat_RESET;
                -- pragma translate_off
                REPORT "nombre de cycle d'horloge : " & integer'image(to_integer(nb_clock));
                -- pragma translate_on
                
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
END Behavioral;
