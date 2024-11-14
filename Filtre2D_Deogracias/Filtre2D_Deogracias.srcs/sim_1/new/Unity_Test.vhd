

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Unity_Test is

end Unity_Test;

architecture Behavioral of Unity_Test is

component fifo_generator_1 IS
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    prog_full_thresh : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    prog_full : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
     
end component;

signal clk_TB : std_logic := '0';
signal rest_TB : std_logic;
signal din_TB : std_logic_vector(7 downto 0);
signal dout_TB : std_logic_vector(7 downto 0);
signal prog_full_thresh_TB : std_logic_vector(9 downto 0);
signal wr_TB : std_logic;
signal rd_TB : std_logic;
signal full_TB : std_logic;
signal empty_TB : std_logic;
signal prog_full_TB : std_logic;
signal  wr_rst_busy_TB : std_logic;
signal  rd_rst_busy_TB : std_logic;



constant clk_period : time := 10 ns;


begin

    u1: fifo_generator_1
        port map(
        clk => clk_TB,
        rst => rest_TB,
        din => din_TB,
        wr_en => wr_TB,
        rd_en => rd_TB,
        prog_full_thresh  =>  prog_full_thresh_TB,
        dout  => dout_TB,
        full  => full_TB,
        empty  => empty_TB,
        prog_full => prog_full_TB
       );
       
       
   clk_process: process
    begin
            
           clk_TB <= '0';
           wait for clk_period/2;
           clk_TB <= '1'; 
           wait for clk_period/2;  
           
    end process clk_process;   
    
   sim_process: process
    begin
            wr_TB <= '0';
            rd_TB <= '0';
            rest_TB <= '1';
            din_TB <= "00000000";
            
            wait for clk_period;
            rest_TB <= '0';
            
            
            if ( full_TB ='1' and empty_TB ='1' ) then
            
                wait for clk_period*10;
                
                wr_TB <='1';
                din_TB <= "00000001";
        
                wait for clk_period;
                
                
                din_TB <= "00000011";
        
                wait for clk_period;
                
                
                din_TB <= "00000111";
        
                wait for clk_period;
                
                
                din_TB <= "00001111";
        
                wait for clk_period;
                
                
                
                if (full_TB='0') then
                
                    din_TB <= "00000010";
                    wr_TB <='1';
                    wait for clk_period;
                else
                    din_TB <= "00000000";
                    wr_TB <= '0';
                   
                end if; 
                
                
            end if;
            
                wr_TB <= '0';
                din_TB <= "00000000";
                wait for clk_period;
                rd_TB <= '1';
                wait for clk_period*6;
                
                
                wait;
            
     end process;
             
         


end Behavioral;
