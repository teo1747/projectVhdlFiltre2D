

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Memory_block is

 Port (
        clk  : in  STD_LOGIC;      
        rst  : in  STD_LOGIC;      
        din  : in  STD_LOGIC_VECTOR(7 downto 0); 
        dout : out STD_LOGIC_VECTOR(7 downto 0); 
        wr_en : in STD_LOGIC;      
        wr1_en : in STD_LOGIC       
    );

end Memory_block;

architecture Behavioral of Memory_block is

signal dff1_out, dff2_out, dff3_out : STD_LOGIC_VECTOR(7 downto 0);
signal dff4_out, dff5_out, dff6_out : STD_LOGIC_VECTOR(7 downto 0);
signal dff7_out, dff8_out, dff9_out : STD_LOGIC_VECTOR(7 downto 0);

signal din_1 : std_logic_vector(7 downto 0);
signal dout_f1: std_logic_vector(7 downto 0);
signal wr1 : std_logic;
signal rd1 : std_logic;
signal full1 : std_logic;
signal empty1 : std_logic;
signal prog_full1 : std_logic;


component  D_FlipFlop is
    Port (
        clk   : in  STD_LOGIC;      
        reset : in  STD_LOGIC;      
        D     : in  STD_LOGIC_VECTOR(7 downto 0); 
        Q     : out STD_LOGIC_VECTOR(7 downto 0) 
    );
    end component;
    
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
    

begin


 DFF1: D_FlipFlop
        Port Map (
            clk => clk,
            reset => rst,
            D => din,
            Q => dff1_out
        );
        
 DFF2: D_FlipFlop
        Port Map (
            clk => clk,
            reset => rst,
            D => dff1_out,
            Q => dff2_out
        );
        
        
  DFF3: D_FlipFlop
        Port Map (
            clk => clk,
            reset => rst,
            D => dff2_out,
            Q => dff3_out
        ); 
        
 FIFO1: fifo_generator_1
 
        port map(
        clk => clk,
        rst => rst,
        din => dff3_out,
        wr_en => wr1,
        rd_en => rd1,
        prog_full_thresh  => "00000000",
        dout  => dout_f1,
        full  => full1,
        empty  => empty1,
        prog_full => prog_full1
       );          
       


end Behavioral;
