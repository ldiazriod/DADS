-- **********************************************
-- lab1.vhd : 8-bit Combinational ALU
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
use IEEE.NUMERIC_STD.ALL;

-- **********************************************
-- ENTITY
-- **********************************************
entity lab1 is
    port ( clk      : in  std_logic;
           reset    : in  std_logic;
           input1   : in  std_logic_vector(3 downto 0);
           input2   : in  std_logic_vector(3 downto 0);
           opcode   : in  std_logic_vector(1 downto 0);
           sevenSeg : out std_logic_vector(6 downto 0);
           selector : out std_logic_vector(7 downto 0);
           leds     : out std_logic_vector(7 downto 0)
    );
end lab1;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavioral of lab1 is
    component display7Seg is 
        port( symbol   : in std_logic_vector(3 downto 0);
              segments : out std_logic_vector(6 downto 0)
        );
    end component;
    
    component controller7Seg is
        port( clk      : in  std_logic;                         
              reset    : in  std_logic;                         
              data_in  : in  std_logic_vector(9 downto 0);  
              data_out : out std_logic_vector(3 downto 0);     
              selector : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- Definición de señales
    signal result     : std_logic_vector(7 downto 0);
    signal symbol     : std_logic_vector(3 downto 0);
    signal aux_result : std_logic_vector(9 downto 0);
begin
    with opcode select
        result <= std_logic_vector("0000" & UNSIGNED(input1) + UNSIGNED(input2)) when "00",
                  std_logic_vector("0000" & UNSIGNED(input1) - UNSIGNED(input2)) when "01",
                  "0000" & (not input2)                                          when "10",
                  std_logic_vector(UNSIGNED(input1) * UNSIGNED(input2))          when "11",
                  (others => '0')                                                when others;
    
    -- ***********************
    -- Conectar señales
    -- ***********************
    aux_result <= (opcode & result);
    leds <= input1 & input2;
    
    -- ***********************
    -- Instanciar componentes
    -- ***********************
    result_controller: controller7Seg port map (
        clk      => clk,
        reset    => reset,
        data_in  => aux_result,
        data_out => symbol,
        selector => selector
    );
    
    controller_dis7Seg: display7Seg port map (
        symbol   => symbol,
        segments => sevenSeg
    );
    

end Behavioral;
