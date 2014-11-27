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

entity instruction_memory is
	port (
		addr        : in  std_logic_vector(31 downto 0);
		instruction : out std_logic_vector(31 downto 0);
		reset   : in  std_logic
	);
end entity instruction_memory;

--ARCHITECTURE

architecture comport01_IM of instruction_memory is

	-- Déclaration Type Tableau Mémoire
	type table is array (63 downto 0) of std_logic_vector(31 downto 0);

	-- Fonction d'initialisation de la memoire
	function init_banc return table is
	  variable result : table;
	  begin
		 for i in 63 downto 9 loop
		 result(i) := (others => '0');
		 end loop;
		 
		 result(0) := X"E3A01020";
		 result(1) := X"E3A02000";
		 result(2) := X"E6110000";
		 result(3) := X"E0822000";
		 result(4) := X"E2811001";
		 result(5) := X"E351002A";
		 result(6) := X"BAFFFFFB";
		 result(7) := X"E6012000";
		 result(8) := X"EAFFFFF7";
		 
		 return result;   
	end init_banc;

	-- Déclaration et initialisation de la memoire

	signal Banc : table := init_banc;

begin

	process(reset) is
	begin
	  
	if (reset = '0') then
		Banc <= init_banc;
		 
	end if;
	
	end process;
	
  instruction <= Banc(to_integer(unsigned(addr))) ;

end architecture comport01_IM;

--FIN PROGRAMME
