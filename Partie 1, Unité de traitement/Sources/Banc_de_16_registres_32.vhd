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

entity Banc_de_16_registres_32 is
	port (
		rw    : in std_logic_vector(3 downto 0);
		ra    : in std_logic_vector(3 downto 0);
		rb    : in std_logic_vector(3 downto 0);
		we    : in std_logic;
		clk   : in std_logic;
		reset : in std_logic;
		w     : in std_logic_vector(31 downto 0);
		a     : out std_logic_vector(31 downto 0);
		b     : out std_logic_vector(31 downto 0)
	);
end entity Banc_de_16_registres_32;

--ARCHITECTURE

architecture comport01_BDR of Banc_de_16_registres_32 is

	-- Déclaration Type Tableau Mémoire
	type table is array (15 downto 0) of std_logic_vector(31 downto 0);

	-- Fonction d'initialisation du banc de Registres
	function init_banc return table is
	  variable result : table;
	  begin
		 for i in 14 downto 0 loop
		 result(i) := (others => '0');
		 end loop;
		 
		 result(15) := X"00000030";
		 return result;   
	end init_banc;

	-- Déclaration et initialisation du Banc

	signal Banc : table := init_banc;

begin

  -- L'écriture est synchrone et fait donc partie d'un PROCESS
	ECRITURE : process(clk,reset) is
	begin

	if (reset = '0') then
		Banc <= init_banc;
	elsif (clk'event and clk = '1' and we = '1') then 
		Banc(to_integer(unsigned(rw))) <= w;
	end if;

	end process ECRITURE;
  
	--La LECTURE est elle combinatoire
	a <= Banc(to_integer(unsigned(ra)));
	b <= Banc(to_integer(unsigned(rb)));

end architecture comport01_BDR;

--FIN PROGRAMME
