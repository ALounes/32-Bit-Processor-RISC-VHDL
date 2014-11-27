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

entity REG_PSR is
	port (
		DATAIN    : in  std_logic_vector(31 downto 0);
		DATAOUT   : out std_logic_vector(31 downto 0);
		CLK,RESET : in  std_logic;
		WE        : in  std_logic
	);
end entity REG_PSR;

--ARCHITECTURE

architecture comport_psr of REG_PSR is

begin
  
	process(clk,reset) is
	begin
	  
	if (clk'event and clk = '1' and WE = '1') then 
	
		DATAOUT <= DATAIN;
		
	elsif (reset = '1') then
	
	  DATAOUT  <= (others => '0');
	
	end if;
	
	end process;

end architecture comport_psr;

--FIN PROGRAMME
