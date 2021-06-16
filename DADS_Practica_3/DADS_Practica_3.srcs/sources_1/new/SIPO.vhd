library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SIPO is
    Port (CLK, RST, data_in : in  std_logic;
          data_out          : out std_logic_vector(127 downto 0)
     );
end SIPO;

architecture Behavioral of SIPO is
    component flipflopD is
        Port(CLK, RST, D : in  std_logic;
             Q           : out std_logic
        );
    end component;
    signal data_aux : std_logic_vector(127 downto 0):=(others => '0');
begin
    SIPOs: for i in 0 to data_out'length - 2 generate
        FFD: flipflopD port map(
            CLK => CLK,
            RST => RST,
            D => data_aux(i),
            Q => data_aux(i+1)
        );
    end generate SIPOs;
    data_aux(0) <= data_in;
    data_out <= data_aux;
end Behavioral;



