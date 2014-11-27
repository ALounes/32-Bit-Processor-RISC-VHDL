------------------------------------
-- ACHAB LOUNES - MAXIME MARTELLI --
----- NUM_3 : TP VHDL [EI-SE4] -----
------------------------------------

--LIBRARY
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--ENTITY 
entity tb_extension_signe is
end entity tb_extension_signe;

--ARCHITECTURE
architecture tb_comport01_extension_signe of tb_extension_signe is


--SIGNAL DECLARATION 
  constant w_ext : positive := 8;
	signal tb_e    : std_logic_vector((w_ext-1) downto 0);
	signal tb_s    : std_logic_vector(31 downto 0);

  
--COMPONENT DECLARATION
	component extension_signe is
	  Generic(w_ext:positive);
		port(
			e : in std_logic_vector((w_ext-1) downto 0);
			s : out std_logic_vector(31 downto 0)
		);
	end component;
	
begin 
  
--INSTANCIATION 
	Instanciation: extension_signe GENERIC MAP (
	 w_ext => w_ext
	)
	PORT MAP (
    	e => tb_e,
    	s => tb_s
	);
	
--PROCESS TEST BENCH
process
  	begin

      tb_e <= "00001111";
      wait for 100 ps;
      
      tb_e <= "11110000";
      wait for 100 ps;
      

end process;

end architecture tb_comport01_extension_signe;



