------------------------------------
-- ACHAB LOUNES - MAXIME MARTELLI --
----- NUM_3 : TP VHDL [EI-SE4] -----
------------------------------------

--LIBRARY

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

--ENTITY

entity PC is
	port (
		Data_in   : in  std_logic_vector(31 downto 0);
		Data_out  : out std_logic_vector(31 downto 0);
		clk,reset : in  std_logic
	);
end entity PC;

--ARCHITECTURE

architecture comport01_PC of PC is

begin
  
	process(clk,reset) is
	begin
	  
	-- Transfère les données sur chaque front d'horloge, sauf lors du reset.
	if (clk'event and clk = '1') then 
		Data_out <= Data_in;
	elsif (reset = '0') then
		Data_out  <= (others => '0');
		
	end if;
	
	end process;

end architecture comport01_PC;

--FIN PROGRAMME
