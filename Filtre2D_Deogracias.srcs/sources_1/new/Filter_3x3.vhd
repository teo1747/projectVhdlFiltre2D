
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;



entity Filter_3x3 is

 Port (
        clk  : in  STD_LOGIC;      
        rst  : in  STD_LOGIC;
        en  : in  STD_LOGIC;
        din9  : in  STD_LOGIC_VECTOR(7 downto 0);      
        din8  : in  STD_LOGIC_VECTOR(7 downto 0);
        din7  : in  STD_LOGIC_VECTOR(7 downto 0); 
        din6  : in  STD_LOGIC_VECTOR(7 downto 0); 
        din5  : in  STD_LOGIC_VECTOR(7 downto 0); 
        din4_c  : in  STD_LOGIC_VECTOR(7 downto 0); 
        din3  : in  STD_LOGIC_VECTOR(7 downto 0); 
        din2  : in  STD_LOGIC_VECTOR(7 downto 0); 
        din1  : in  STD_LOGIC_VECTOR(7 downto 0);  
        dout : out STD_LOGIC_VECTOR(7 downto 0)                  
    );

end Filter_3x3;

architecture Behavioral of Filter_3x3 is

signal Stage1sum_1, Stage1sum_2, Stage1sum_3, Stage1sum_4 : STD_LOGIC_VECTOR(8 downto 0):= "000000000";
signal Stage2sum_1, Stage2sum_2 : STD_LOGIC_VECTOR(9 downto 0):= "0000000000";
signal Stage3sum : STD_LOGIC_VECTOR(10 downto 0):= "00000000000";
signal Stage4sum : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
signal Stage5sum: STD_LOGIC_VECTOR(8 downto 0):= "000000000";
signal Stage6sum: STD_LOGIC_VECTOR(7 downto 0):= "00000000";

begin


Stage_1:process(clk,rst,en)
    begin
         if (rst = '1') 
          then
               dout <= "00000000";  
                
          elsif (clk'event and clk='1')
          then 
              if (en = '1')
                then      
                 
          Stage1sum_1 <=  (('0' & din9)  +  ('0' & din8));
          Stage1sum_2 <=  (('0' & din7)  +  ('0' & din6));
          Stage1sum_3 <=  (('0' & din5)  +  ('0' & din3));
          Stage1sum_4 <=  (('0' & din2)  +  ('0' & din1));
          
          
         Stage2sum_1  <= (('0' & Stage1sum_1)  +  ('0' & Stage1sum_2));
         Stage2sum_2  <= (('0' & Stage1sum_3)  +  ('0' & Stage1sum_4));
         
         Stage3sum <= (('0' & Stage2sum_1)  +  ('0' & Stage2sum_2));
         
         Stage4sum <= Stage3sum(10 downto 3);
                  
         
                 
             end if;
          
        end if;

    end process Stage_1;
    

    
    
end Behavioral;
