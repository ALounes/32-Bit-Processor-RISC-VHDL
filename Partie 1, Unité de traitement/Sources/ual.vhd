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

entity ual is
  port (
    a  : in  std_logic_vector(31 downto 0);
    b  : in std_logic_vector(31 downto 0);
    op : in  std_logic_vector(01 downto 0);
    y  : out std_logic_vector(31 downto 0);
    n  : out std_logic
  );
end entity ual;

--ARCHITECTURE

architecture comport_ual of ual is
  
  --SIGNAL DECLARATION 
  signal yin : std_logic_vector(31 downto 0);
 
  
  begin 
    
    y <= yin;
    process(a,b,op) is
    begin
      
      -- N est égal à 1 lorsque la soustraction renvoie un résultat négatif (utile plus tard pour les comparaisons)
      if ( op = "10" and (to_integer(unsigned(a)) < to_integer(unsigned(b)))) then
        n <= '1';
      else
        n <= '0';
      end if;
      
      case op is
        when "00" => yin <= a + b;
        when "01" => yin <= b;
        when "10" => yin <= a - b;
        when others => yin <= a;
      end case;

    end process;
    
end architecture comport_ual;

--FIN PROGRAMME