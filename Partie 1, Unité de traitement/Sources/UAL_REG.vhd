------------------------------------
-- ACHAB LOUNES - MAXIME MARTELLI --
----- NUM_3 : TP VHDL [EI-SE4] -----
------------------------------------

--LIBRARY
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


--ENTITY
entity UAL_REG is 
	port(
		--CTR
		we      : in std_logic;
		OP      : in std_logic_vector(1 downto 0);
		--INPUT
		rw      : in std_logic_vector(3 downto 0);
		ra      : in std_logic_vector(3 downto 0);
		rb      : in std_logic_vector(3 downto 0);
		REG_IN  : in std_logic_vector(31 downto 0);
		--OUTPUT
		ALU_out : out std_logic_vector(31 downto 0);
		n       : out std_logic;
		--SPE
		clk     : in std_logic;
		reset   : in std_logic
	);
end entity UAL_REG ;


--ARCHITECTURE
architecture archi_compo01 of UAL_REG is
  
	signal BusA : std_logic_vector(31 downto 0);
	signal BusB : std_logic_vector(31 downto 0);
	--signal BusW : std_logic_vector(31 downto 0);

  component Banc_de_16_registres_32 
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
		  
  end component Banc_de_16_registres_32; 

  component ual
	   port (
	   a  : in std_logic_vector(31 downto 0);
	   b  : in std_logic_vector(31 downto 0);
	   op : in std_logic_vector(01 downto 0);
	   y  : out std_logic_vector(31 downto 0);
	   n  : out std_logic
     );
  end component ual;

begin

-- On ne fait que relier les deux blocs entre eux

I_BDR : Banc_de_16_registres_32 PORT MAP ( 
  reset => reset,
  rw    => rw, 
  ra    => ra, 
  rb    => rb, 
  w     => REG_IN,
  a     => BusA, 
  b     => BusB, 
  clk   => clk, 
  we    => we 
); 

I_UAL: ual PORT MAP (
	a    => BusA,
	b    => BusB,
	y    => ALU_out,
	op   => OP,
	n    => n
);

end architecture archi_compo01;