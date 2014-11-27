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

entity tb_unite_de_gestion_des_instructions is
end entity tb_unite_de_gestion_des_instructions;

--ARCHITECTURE

architecture comport_ugi of tb_unite_de_gestion_des_instructions is
  	
  --SIGNAL DECLARATION  	
 	  signal tb_nPCsel      : std_logic;
    signal tb_clk         : std_logic := '1';
    signal tb_reset       : std_logic;
    signal tb_offset      : std_logic_vector(23 downto 0);
    signal tb_instruction : std_logic_vector(31 downto 0);
    	
  --COMPONENT DECLARATION
  component unite_de_gestion_des_instructions is
  port (
    nPCsel      : in std_logic;
    clk         : in std_logic;
    reset       : in std_logic;
    offset      : in std_logic_vector(23 downto 0);
    instruction : out std_logic_vector(31 downto 0)
  );
  end component ;

begin

  --INSTANCIATION extender
  i_ugi : unite_de_gestion_des_instructions PORT MAP (
    nPCsel => tb_nPCsel ,
    clk    => tb_clk,
    reset  => tb_reset,
    offset => tb_offset ,    
    instruction => tb_instruction
  );
  
  --CLOCK Freq
  tb_clk <= not tb_clk after 50 ps ;
  
  --PROCESS TEST BENCH
  process
    begin
    --Initialisation (reset)
    tb_reset  <= '0';
 
 	  tb_nPCsel <= '0';
    tb_offset <= X"FFFFFD";
    
    wait for 50 ps;
    tb_reset  <= '1'; 
        
    wait for 50 ps; 
    -- (test CP <- CP +1)
    wait for 100 ps; 
    -- (test CP <- CP +1)
    wait for 100 ps; 
    -- (test CP <- CP +1)
    wait for 100 ps; 
    -- (test CP <- CP +1)  
    wait for 100 ps; 
    -- (test CP <- CP + 1)
    wait for 100 ps; 
    -- (test CP <- CP + 1) 
    wait for 100 ps; 
    -- (test CP <- CP + 1)  
 	  wait for 100 ps; 
    -- (test CP <- CP + 1)  
    tb_nPCsel <= '1';
    -- (test CP <- CP + 1 + offset)
    wait for 100 ps; 
    -- (test CP <- CP + 1)  
 	  wait for 100 ps; 
    -- (test CP <- CP + 1)
    wait for 100 ps; 
    
    
  end process;

end architecture comport_ugi;

--FIN PROGRAMME