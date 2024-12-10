library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity compt_decompt is
    Port (
        clk       : in  std_logic;
        enable     : in  std_logic;      
        reset     : in  std_logic;   
        ten_cycles : out std_logic   
    );

end compt_decompt;

architecture compt_decompt_archi of compt_decompt is

signal counter : integer range 0 to 9 := 0; 
begin
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
            ten_cycles <= '0';
        elsif rising_edge(clk) then
          if enable = '1' then  
            if counter < 10 then
                counter <= counter + 1;
                ten_cycles <= '0';
            else
                counter <= 0; 
                ten_cycles <= '1'; 
             end if;
           else 
               ten_cycles <= '0';
               counter <= 0; 
        end if;
      end if; 
    end process;
end compt_decompt_archi;