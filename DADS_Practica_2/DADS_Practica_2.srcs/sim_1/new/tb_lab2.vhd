library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_lab2 is
end tb_lab2;

architecture Behavioral of tb_lab2 is
    component lab2 is
        port ( clk       : in  std_logic;
               reset     : in  std_logic;
               startStop : in  std_logic;
               sevenSeg  : out std_logic_vector(6 downto 0);
               selector  : out std_logic_vector(7 downto 0)
        );
    end component;
    signal clk, reset, startStop : std_logic;
    signal sevenSeg              : std_logic_vector(6 downto 0);
    signal selector              : std_logic_vector(7 downto 0);
begin
    
    DUT: lab2 port map (
        clk       => clk,
        reset     => reset,
        startStop => startStop,
        sevenSeg  => sevenSeg,
        selector  => selector
    );

    process begin
        clk <= '1'; wait for 20ns;
        clk <= '0'; wait for 10ns;
        clk <= '1'; wait for 20ns;
    end process;

    process begin
        reset <= '0'; wait for 20ns;
        reset <= '1'; wait for 10ns;
        reset <= '0'; wait for 20ns;
    end process;
    
    process begin
        startStop <= '1'; wait for 20ns;
        startStop <= '0'; wait for 10ns;
        startStop <= '1'; wait for 30ns;
    end process;
end Behavioral;
