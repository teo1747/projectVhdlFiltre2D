library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_lena_dupliq is
       
end;

architecture arch_tb_lena_dupliq of tb_lena_dupliq is


  signal I1 : std_logic_vector (7 downto 0);
  signal CLK : std_logic;
  signal O1 : std_logic_vector (7 downto 0); 
  signal DATA_AVAILABLE : std_logic;
  
  
  signal clk_TB : std_logic := '0';
  signal rest_TB : std_logic;
  signal wr_TB : std_logic;
  signal din_TB : std_logic_vector(7 downto 0);
  signal dout_TB : std_logic_vector(7 downto 0);
  signal dout_filtert_TB : std_logic_vector(7 downto 0);
  
  
  constant clck_period : time := 10 ns;
  
  component Memory_block 

 Port (
        clk  : in  STD_LOGIC;      
        rst  : in  STD_LOGIC;      
        din  : in  STD_LOGIC_VECTOR(7 downto 0); 
        dout : out STD_LOGIC_VECTOR(7 downto 0);
        dout_filtert : out STD_LOGIC_VECTOR(7 downto 0); 
        wr_en : in STD_LOGIC             
    );
  
  
  end component;
begin

memory: Memory_block 

 Port map (
        clk  => clk_TB,      
        rst  => rest_TB,      
        din  => din_TB,
        dout => dout_TB,
        dout_filtert => dout_filtert_TB,
        wr_en => wr_TB             
    );

clck_process : process
    begin
        clk_TB <= '0';
        wait for clck_period/2;
        clk_TB <= '1';
        wait for clck_period/2;
        
        
        
    end process;
    
    

 p_read : process
 
   
  FILE vectors : text;
  variable Iline : line;
  variable I1_var :std_logic_vector (7 downto 0);
 
    begin
       
	DATA_AVAILABLE <= '0';
    file_open (vectors,"C:\Users\jm134934\Desktop\mambo\projectVhdlFiltre2D\Filtre2D_Deogracias\Filtre2D_Deogracias.srcs\sources_1\new\Lena128x128g_8bits.dat", read_mode);
   wait for clck_period*25; 
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

p_write: process
  file results : text;
  variable OLine : line;
  variable O1_var :std_logic_vector (7 downto 0);
    
    begin
    file_open (results,"C:\Users\jm134934\Desktop\mambo\projectVhdlFiltre2D\Filtre2D_Deogracias\Filtre2D_Deogracias.srcs\sources_1\new\Lena128x128g_8bits_r.dat", write_mode);
    wait for 10 ns;
    wait until DATA_AVAILABLE = '1';

    while DATA_AVAILABLE ='1' loop
         
      write (Oline, O1, right, 2);
      writeline (results, Oline);
      
      wait for 10 ns;  
    end loop;
    file_close (results);
    wait;
 end process;
 
sim: process
    begin
        
       
        rest_TB <= '1';
        wr_TB <= '0';
        
     
        wait for clck_period*15;
        rest_TB <= '0';
  
        wait for clck_period*8;
        wr_TB <= '1';
 
        wait for clck_period*500;
        wr_TB <= '0';
 
        wait;                                                                                      

 end process sim;
--Instancier composant filtre à place de la simple recopie entre I1 vers sortie O1 (top)
       din_TB <= I1;
        O1<= dout_filtert_TB; 
      CLK <= clk_TB;
  
end arch_tb_lena_dupliq;

