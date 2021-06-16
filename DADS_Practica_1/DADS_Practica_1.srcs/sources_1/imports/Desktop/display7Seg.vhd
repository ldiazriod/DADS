-- **********************************************
-- display7Seg.vhd : 7 Segment Display Controller
--
-- Prof. Dr. Luis A. Aranda
--
-- Universidad Nebrija
--
-- **********************************************
-- LIBRARIES
-- **********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- **********************************************
-- ENTITY
-- **********************************************
entity display7Seg is
    port ( symbol   : in  std_logic_vector(3 downto 0);      -- Number / Letter to Display
           segments : out std_logic_vector(6 downto 0)       -- 7 Segments
    );
end display7Seg;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavioral of display7Seg is
begin

  process (symbol) begin
        case symbol is
            when "0000" =>
                segments <= "1111110";
            when "0001" =>
                segments <= "0110000";
            when "0010" =>
                segments <= "1101101";
            when "0011" =>
                segments <= "1111001";
            when "0100" =>
                segments <= "0110011";
            when "0101" =>
                segments <= "1011011";
            when "0110" =>
                segments <= "1011111";
            when "0111" =>
                segments <= "1110000";
            when "1000" =>
                segments <= "1111111";
            when "1001" =>
                segments <= "1111011";
            when "1010" =>
                segments <= "1110111";
            when "1011" =>
                segments <= "0011111";
            when "1100" =>
                segments <= "1001110";
            when "1101" =>
                segments <= "0111101";
            when "1110" =>
                segments <= "1001111";
            when "1111" =>
                segments <= "1000111";
            when others =>
                segments <= "0000000";
        end case;
    end process;
end Behavioral;

