

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


component  D_FlipFlop is
    Port (
        clk   : in  STD_LOGIC;      
        reset : in  STD_LOGIC;      
        D     : in  STD_LOGIC_VECTOR(7 downto 0); 
        Q     : out STD_LOGIC_VECTOR(7 downto 0) 
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

signal D_TB : std_logic_vector(7 downto 0);
signal Q_TB : std_logic_vector(7 downto 0);



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
       
       
   u2: fifo_generator_1
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
       
       
     u3: D_FlipFlop 
    Port map (
        clk   => clk_TB,     
        reset => rest_TB,    
        D     => D_TB, 
        Q     => Q_TB
    );
    
       
       
       


end Behavioral;
