
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;



entity Gaussian_filter is
Port (  clk  : in  STD_LOGIC;      
        rst  : in  STD_LOGIC;
        en  : in  STD_LOGIC;
        p00, p01, p02 : in std_logic_vector(7 downto 0); 
        p10, p11, p12 : in std_logic_vector(7 downto 0); 
        p20, p21, p22 : in std_logic_vector(7 downto 0); 
        output_pixel  : out std_logic_vector(7 downto 0) 
        );
end Gaussian_filter;

architecture Behavioral of Gaussian_filter is

    signal weighted_sum : integer := 0;
    signal normalized_value : integer := 0;
    
    
begin

process(clk,rst,en)
        variable temp_sum : integer := 0;
    begin
    
        if (rst = '1') 
          then
--               dout <= "00000000";  
                
          elsif (clk'event and clk='1')
          then 
              if (en = '1')
                then      
        -- Apply weights (Gaussian kernel)
        temp_sum := 1 * to_integer(unsigned(p00)) +
                    2 * to_integer(unsigned(p01)) +
                    1 * to_integer(unsigned(p02)) +
                    2 * to_integer(unsigned(p10)) +
                    4 * to_integer(unsigned(p11)) + -- Center pixel has the highest weight
                    2 * to_integer(unsigned(p12)) +
                    1 * to_integer(unsigned(p20)) +
                    2 * to_integer(unsigned(p21)) +
                    1 * to_integer(unsigned(p22));
 
        -- Normalize by dividing the sum by 16
        weighted_sum <= temp_sum;
        normalized_value <= temp_sum / 16;
        
        end if;
        
        end if;
 
        -- Convert back to std_logic_vector (8 bits)
       
    end process;
 output_pixel <= std_logic_vector(to_unsigned(normalized_value, 8));

end Behavioral;
