------------------------------------
-- ACHAB LOUNES - MAXIME MARTELLI --
----- NUM_3 : TP VHDL [EI-SE4] -----
------------------------------------

--LIBRARY
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--ENTITY 
entity extension_signe is

	Generic(w_ext:positive);
	
	port(
		e : in std_logic_vector((w_ext-1) downto 0);
		s : out std_logic_vector(31 downto 0)
	);
	
end entity extension_signe;


--ARCHITECTURE
architecture comport01_extension_signe of extension_signe is

	begin
	s((w_ext-1) downto 0) <= e;
	s(31 downto w_ext)    <= (others => e(w_ext-1));

end architecture comport01_extension_signe;





