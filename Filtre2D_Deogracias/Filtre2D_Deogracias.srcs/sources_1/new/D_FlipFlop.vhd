library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FlipFlop is
    Port (
        clk   : in  STD_LOGIC;      
        reset : in  STD_LOGIC;      
        D     : in  STD_LOGIC_VECTOR(7 downto 0); 
        Q     : out STD_LOGIC_VECTOR(7 downto 0) 
    );
end D_FlipFlop;

architecture Behavioral of D_FlipFlop is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            Q <= (others => '0'); 
        elsif rising_edge(clk) then
            Q <= D; 
        end if;
    end process;
end Behavioral;
