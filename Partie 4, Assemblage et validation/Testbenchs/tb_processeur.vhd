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
entity tb_processeur is
end entity tb_processeur;

--ARCHITECTURE
architecture tb_comport_processeur of tb_processeur is
  
  --SIGNAL DECLARATION 
  signal tb_clk : std_logic := '1';
  signal tb_reset : std_logic := '0';
  
  --COMPONENT DECLARATION
  component processeur
    port (
      CLK   : in std_logic;
      RESET : in std_logic
    );
  end component;

begin 
  
  --INSTANCIATION 
  Instanciation: processeur PORT MAP (
    CLK    => tb_clk,
    RESET  => tb_reset
  );

  --PROCESS TEST BENCH
  process
  begin

    tb_Clk <= not tb_Clk after 50 ps ;
    
    tb_reset <= '1';
    
    wait for 50 ps;

end process;

end architecture tb_comport_processeur;

--FIN PROGRAMME
