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

entity Data_memory is
	port (
		addr  : in std_logic_vector(05 downto 0);
		clk   : in std_logic;
		WrEn  : in std_logic;
		reset : in std_logic;
		Data_In  : in   std_logic_vector(31 downto 0);
		Data_Out : out  std_logic_vector(31 downto 0)
	);
end entity Data_memory;

--ARCHITECTURE

architecture comport01_DM of Data_memory is

	-- Déclaration Type Tableau Mémoire
	type table is array (63 downto 0) of std_logic_vector(31 downto 0);

	-- Fonction d'initialisation de la memoire
	function init_banc return table is
	  variable result : table;
	  begin
	    
		 for i in 63 downto 0 loop
		 result(i) := X"00000001";
		 end loop;
		 
		 return result;   
		 
	end init_banc;

	-- Déclaration et initialisation de la memoire

	signal Banc : table := init_banc;

begin

	ECRITURE : process(clk,reset) is
	begin
	  
	 if (reset = '0') then
		Banc <= init_banc;
	 elsif (clk'event and clk = '1' and WrEn = '1') then 
		Banc(to_integer(unsigned(addr))) <= Data_In; -- Conversion rw : "10" en 2?
	 end if;
	 
	end process ECRITURE;

	--LECTURE
	Data_Out <= Banc(to_integer(unsigned(addr)));

end architecture comport01_DM;

--FIN PROGRAMME
