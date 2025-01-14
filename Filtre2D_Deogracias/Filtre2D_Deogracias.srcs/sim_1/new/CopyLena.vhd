
 
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
 
entity CopyLena is
--    Port ();
end CopyLena;
 
architecture Behavioral of CopyLena is
 
signal  dataIn :  STD_LOGIC_VECTOR (7 downto 0);
signal  clk :  STD_LOGIC;
signal  dataOut :  STD_LOGIC_VECTOR (7 downto 0);
signal  dataDispo,flag_debug:  STD_LOGIC;
 
constant clock_periode: time := 10ns;
 
begin
 
 
clocking: process 
begin 
    clk <= '0';
    wait for clock_periode/2;
    clk <= '1';
    wait for clock_periode/2;
end process;
  -- Processus pour lire les données depuis le fichier Lena.dat
reading : process
 
    FILE vectors : text;
    variable Xline : line;
    variable temp1 : std_logic_vector (7 downto 0);
  begin
    dataDispo <=  '0';
    file_open(vectors, "D:\Xilinx\sosoVivado\Projet_filtre\Lena128x128g_8bits.dat", read_mode);
    wait for 10ns;
    while not endfile(vectors) loop
      readline(vectors, xline);
      read(xline, temp1);
      dataIn <= temp1;
       dataDispo <= '1';
       wait for 10ns;
    end loop;
    dataDispo <= '0';
    wait for 10ns;
    file_close(vectors);
    wait ;
  end process;
  -- Processus pour écrire les données dans le fichier Lena.dat
  writing: process
    file results : text;
    variable yLine : line;
    variable temp2 : std_logic_vector (7 downto 0);
  begin
    file_open(results, "D:\Xilinx\sosoVivado\Projet_filtre\Lena128x128g_8bits_c.dat", write_mode);
    flag_debug <= '0'; 
    wait for 5ns;
    wait until dataDispo = '1';
    while dataDispo = '1' loop
      flag_debug <= '1'; 
      temp2 := dataIn;
      dataOut <= temp2; 
      write(yLine, temp2, right, 2);
      writeline(results, yLine);
      wait for 10ns;
      end loop;
   file_close(results);
   wait ;
  end process;
 
end Behavioral;

