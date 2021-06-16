library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_SIPO is
end tb_SIPO;

architecture Behavioral of tb_SIPO is
    component SIPO is
        Port(CLK, RST, data_in : in  std_logic;
             data_out          : out std_logic_vector(127 downto 0)
        );
    end component;
    signal CLK, RST, data_in : std_logic;
    signal data_out          : std_logic_vector(127 downto 0):= (others => '0');
begin
    DUT: SIPO port map(
        CLK      => CLK,
        RST      => RST,
        data_in  => data_in,
        data_out => data_out
    );
    
    process begin
        CLK <= '1'; wait for 10ns;
        CLK <= '0'; wait for 10ns;
        CLK <= '1'; wait for 10ns;
    end process;
    
    process begin
        RST <= '0'; wait for 10ns;
        RST <= '1'; wait for 10ns;
        RST <= '0'; wait for 10ns;
    end process;
    
    process begin
        for i in 0 to data_out'length-1 loop
            if((i mod 2) = 0)then
                data_in <= '1'; wait for 20ns;
            else
                data_in <= '0'; wait for 20ns;
            end if;
        end loop;
    end process;
end Behavioral;



