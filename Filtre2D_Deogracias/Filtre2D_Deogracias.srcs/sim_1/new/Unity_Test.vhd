
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

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



  signal I1 : std_logic_vector (7 downto 0);
  signal CLK : std_logic;
  signal O1 : std_logic_vector (7 downto 0); 
  signal DATA_AVAILABLE : std_logic;

constant clck_period : time := 10 ns;


begin

    u1: fifo_generator_1
        port map(
        clk => clk_TB,
        rst => rest_TB,
        din => din_TB,
        wr_en => wr_TB,
        rd_en => rd_TB,
        prog_full_thresh  =>  "0001111100",
        dout  => dout_TB,
        full  => full_TB,
        empty  => empty_TB,
        prog_full => prog_full_TB
       );
       

    p_read : process
 
   
  FILE vectors : text;
  variable Iline : line;
  variable I1_var :std_logic_vector (7 downto 0);
 
    begin
       
	DATA_AVAILABLE <= '0';
    file_open (vectors,"C:\Users\HP\Desktop\project\projectVhdlFiltre2D\Filtre2D_Deogracias\Filtre2D_Deogracias.srcs\sources_1\new\Lena128x128g_8bits.dat", read_mode);
   wait for clck_period*12; 
    while not endfile(vectors) loop
      readline (vectors,Iline);
      read (Iline,I1_var);
                
      I1 <= I1_var;
	  DATA_AVAILABLE <= '1';
	  
	  wait for clck_period;
    end loop;
    DATA_AVAILABLE <= '0';
    wait for clck_period;
    file_close (vectors);
    wait;
 end process;
       
 clck_process : process
    begin
        clk_TB <= '0';
        wait for clck_period/2;
        clk_TB <= '1';
        wait for clck_period/2;
        
        
        
    end process;
       
 sim: process
    begin
        
       
        rest_TB <= '1';
        wr_TB <= '0';
        
     
        wait for clck_period;
        rest_TB <= '0';
  
        wait for clck_period*10;
        wr_TB <= '1';
        rd_TB <= prog_full_TB;
 
        wait for clck_period*500;
        wr_TB <= '0';
        
 
        wait;                                                                                      

 end process sim;
din_TB <= I1;
      
      CLK <= clk_TB;

end Behavioral;
