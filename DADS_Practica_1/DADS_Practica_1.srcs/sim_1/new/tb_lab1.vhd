library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_lab1 is
end tb_lab1;

architecture Behavioral of tb_lab1 is
    component lab1 is
        port ( clk      : in  std_logic;
               reset    : in  std_logic;
               input1   : in  std_logic_vector(3 downto 0);
               input2   : in  std_logic_vector(3 downto 0);
               opcode   : in  std_logic_vector(1 downto 0);
               sevenSeg : out std_logic_vector(6 downto 0);
               selector : out std_logic_vector(7 downto 0);
               leds     : out std_logic_vector(7 downto 0)
    );
    end component;
    signal clk, reset     : std_logic;
    signal input1, input2 : std_logic_vector(3 downto 0);
    signal opcode         : std_logic_vector(1 downto 0);
    signal sevenSeg       : std_logic_vector(6 downto 0);
    signal selector,leds  : std_logic_vector(7 downto 0);
begin

    DUT: lab1 port map (
        clk => clk,
        reset => reset,
        input1 => input1,
        input2 => input2,
        opcode => opcode,
        sevenSeg => sevenSeg,
        selector => selector,
        leds => leds
    );
    
    process begin
        clk <= '1'; wait for 10ns;
        clk <= '0'; wait for 10ns;
        clk <= '1'; wait for 10ns;
    end process;
    
    process begin
        reset <= '0'; wait for 10ns;
        reset <= '1'; wait for 10ns;
        reset <= '0'; wait;
    end process;
    
    process begin
        input1 <= "0001"; wait for 10ns;
        input1 <= "0101"; wait for 20ns;
        input1 <= "0010"; wait for 10ns;
        input1 <= "1111"; wait for 10ns;
    end process;
    
    process begin
        input2 <= "0001"; wait for 10ns;
        input2 <= "0101"; wait for 20ns;
        input2 <= "0010"; wait for 10ns;
        input2 <= "1101"; wait for 10ns;
    end process;
    
    process begin
        opcode <= "00"; wait for 10ns;
        opcode <= "01"; wait for 20ns;
        opcode <= "11"; wait for 10ns;
        opcode <= "10"; wait for 10ns;
    end process;

end Behavioral;