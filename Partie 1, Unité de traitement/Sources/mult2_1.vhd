------------------------------------
-- ACHAB LOUNES - MAXIME MARTELLI --
----- NUM_3 : TP VHDL [EI-SE4] -----
------------------------------------

--LIBRARY
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--ENTITY 
entity mult2_1 is

	Generic(w_mult:positive);
	
	port(
		a : in std_logic_vector((w_mult-1) downto 0);
		b : in std_logic_vector((w_mult-1) downto 0);
		com : in std_logic;
		s   : out std_logic_vector((w_mult-1) downto 0)
	);
end entity mult2_1;

--ARCHITECTURE
architecture comport01_mult2_1 of mult2_1 is
begin
	process(a,b,com) is
	begin
	  
		if (com = '0') then
			s <= a;
		else
			s <= b;
		end if;

	end process;

end architecture comport01_mult2_1;
