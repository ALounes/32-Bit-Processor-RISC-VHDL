------------------------------------
-- ACHAB LOUNES - MAXIME MARTELLI --
----- NUM_3 : TP VHDL [EI-SE4] -----
------------------------------------

--LIBRARY
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--ENTITY 
entity tb_mult2_1 is
end entity tb_mult2_1;

--ARCHITECTURE
architecture tb_comport01_mult2_1 of tb_mult2_1 is

  --SIGNAL DECLARATION 
  constant w_mult : positive := 32;
  signal tb_a   : std_logic_vector((w_mult-1) downto 0);
  signal tb_b   : std_logic_vector((w_mult-1) downto 0);
  signal tb_com : std_logic;
  signal tb_s   : std_logic_vector((w_mult-1) downto 0);
 
  
  --COMPONENT DECLARATION
	component mult2_1 is
	  Generic(w_mult:positive);
		port(
			a : in std_logic_vector((w_mult-1) downto 0);
			b : in std_logic_vector((w_mult-1) downto 0);
			com : in std_logic;
			s : out std_logic_vector((w_mult-1) downto 0)
		);
	end component;
	
begin 
  
  --INSTANCIATION 
	Instanciation: mult2_1 
	  GENERIC MAP (
	   w_mult => w_mult
	  )
	  PORT MAP (
   	 a   => tb_a,
   	 b   => tb_b,
   	 com => tb_com,
  	  s   => tb_s
	  );
	
--PROCESS TEST BENCH
process
begin

  tb_a <= X"00001111";
  tb_b <= X"11110000";
  tb_com <= '0';
  
  wait for 100 ps;
  
  tb_com <= '1';
  
  wait for 100 ps;


end process;

end architecture tb_comport01_mult2_1;

--END PROGRAMME