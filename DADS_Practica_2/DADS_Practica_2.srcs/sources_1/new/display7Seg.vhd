library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display7Seg is
    Port(symbol   : in  std_logic_vector(3 downto 0);
         segments : out std_logic_vector(6 downto 0)
    );
end display7Seg;

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
            when others =>
                segments <= "0000000";
        end case;
    end process;

end Behavioral;
