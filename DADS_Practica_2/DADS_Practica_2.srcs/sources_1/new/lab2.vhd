-- **********************************************
-- lab2.vhd : Stopwatch without Debouncer
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
entity lab2 is
    port ( clk       : in  std_logic;
           reset     : in  std_logic;
           startStop : in  std_logic;
           sevenSeg  : out std_logic_vector(6 downto 0);
           selector  : out std_logic_vector(7 downto 0)
    );
end lab2;

-- **********************************************
-- ARCHITECTURE
-- **********************************************
architecture Behavioral of lab2 is
    -- Define Seven Segments Component
    component display7Seg is
        port( symbol   : in  std_logic_vector(3 downto 0);      -- Number / Letter to Display
              segments : out std_logic_vector(6 downto 0)       -- 7 Segments
        );
    end component;
    
    -- Define Seven Segments Controller Component
    component controller7Seg is
        port( clk      : in  std_logic;                         -- FPGA Clock
              enable   : in  std_logic;                         -- Enable
              data_in  : in  std_logic_vector(11 downto 0);     -- Result to Display (Packed)
              data_out : out std_logic_vector(3 downto 0);      -- Result to Display (Unpacked)
              selector : out std_logic_vector(7 downto 0)       -- 7 Segments Anode
        );
    end component;
    
    -- Define Counter Component
    component counter is
        port ( clk       : in  std_logic;                       -- FPGA Clock
               reset     : in  std_logic;                       -- Reset
               enable    : in  std_logic;                       -- Enable Counting
               count     : out std_logic_vector(11 downto 0)    -- Output Count Value
        );
    end component;
    
    --******************
    -- Declarar señales
    --******************
    signal enableCounter : std_logic;
    signal count         : std_logic_vector(11 downto 0);
    
    signal enableDisplay : std_logic;
    signal symbol        : std_logic_vector(3 downto 0);
    
    type state_type is (S0,S1,S2);
    signal CS, NS : state_type;
begin
    --********************************
    -- Proceso secuencial para la FSM
    --********************************
    process (CLK) begin
        if(rising_edge(CLK))then
            if(reset = '1')then
                CS <= S0;
            else
                CS <= NS;
            end if;
        end if;
    end process;
    --***********************************
    -- Proceso combinacional para la FSM
    --***********************************
    process (CS, startStop) begin
        case CS is
            when S0 =>
                if(startStop = '1')then
                    NS <= S1; enableCounter <= '1'; enableDisplay <= '1';
                else
                    NS <= S2; enableCounter <= '0'; enableDisplay <= '0';
                end if;
            when S1 =>
                if(startStop = '1')then
                    NS <= S1; enableCounter <= '1'; enableDisplay <= '1';
                else
                    NS <= S2; enableCounter <= '0'; enableDisplay <= '1';
                end if;
            when S2 =>
                if(startStop = '1')then
                    NS <= S1; enableCounter <= '1'; enableDisplay <= '1';
                else
                    NS <= S2; enableCounter <= '0'; enableDisplay <= '1';
                end if;
            when others =>
                NS <= S0; enableCounter <= '0'; enableDisplay <= '0';
        end case;
    end process;
    
    -- Instantiate Counter
    TIME_COUNTER : counter port map(
        clk      => clk,
        reset    => reset,
        enable   => enableCounter,
        count    => count
    );
    
    -- Instantiate Seven Segment Controller
    SEVEN_CONTROL : controller7Seg port map(
        clk      => clk,
        enable   => enableDisplay,
        data_in  => count,
        data_out => symbol,
        selector => selector
    );
    
    -- Instantiate Seven Segment
    SEVEN_SEG : display7Seg port map(
        symbol   => symbol,
        segments => sevenSeg
    );
end Behavioral;
