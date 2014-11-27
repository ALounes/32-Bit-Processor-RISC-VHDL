------------------------------------
-- ACHAB LOUNES - MAXIME MARTELLI --
----- NUM_3 : TP VHDL [EI-SE4] -----
------------------------------------

--LIBRARY
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--ENTITY 
entity tb_ual is
end entity tb_ual;

--ARCHITECTURE
architecture tb_comport_ual of tb_ual is
  
  --SIGNAL DECLARATION 
  signal tb_a,tb_b,tb_y : std_logic_vector(31 downto 0);
  signal tb_op    : std_logic_vector(01 downto 0);
  signal tb_n     : std_logic;
  
  --COMPONENT DECLARATION
  component ual
    port (
      a,b : in std_logic_vector(31 downto 0);
      op     : in std_logic_vector(01 downto 0);
      y      : out std_logic_vector(31 downto 0);
      n      : out std_logic
    );
  end component;

begin 
  
  --INSTANCIATION 
  Instanciation: ual PORT MAP (
    a  => tb_a,
    b  => tb_b,
    y  => tb_y,
    op => tb_op,
    n  => tb_n
  );

  --PROCESS TEST BENCH
  process
  begin

    --TEST  y = a + b
    tb_op <= "00"; 
    tb_a  <= X"00001111";
    tb_b  <= X"01100000";
    wait for 50 ps ;
    
    --TEST  y = b
    tb_op <= "01"; 
    tb_a  <= X"00001111";
    tb_b  <= X"01100000";
    wait for 50 ps ;
    
    --TEST  y = a - b ( AVEC n = 0 )
    tb_op <= "10"; 
    tb_a  <= X"00001111";
    tb_b  <= X"00001110";
    wait for 50 ps ;

    --TEST  y = a - b  ( AVEC n = 1 )
    tb_op <= "10"; 
    tb_a  <= X"00001111";
    tb_b  <= X"01100000";
    wait for 50 ps ;
    
    --TEST  y = a
    tb_op <= "11"; 
    tb_a  <= X"00001111";
    tb_b  <= X"01100000";
    wait for 50 ps ;
    
  end process;
end architecture tb_comport_ual;

--FIN PROGRAMME