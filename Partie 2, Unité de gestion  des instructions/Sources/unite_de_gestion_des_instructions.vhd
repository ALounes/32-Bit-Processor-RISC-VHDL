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

entity unite_de_gestion_des_instructions is
  port (
    nPCsel      : in std_logic;
    clk         : in std_logic;
    reset       : in std_logic;
    offset      : in std_logic_vector(23 downto 0);
    instruction : out std_logic_vector(31 downto 0)
  );
end entity unite_de_gestion_des_instructions;

--ARCHITECTURE

architecture comport_ugi of unite_de_gestion_des_instructions is
  	
--SIGNAL DECLARATION  	
  signal Bus_mux  : std_logic_vector(31 downto 0);  	
  signal Bus_PC   : std_logic_vector(31 downto 0);  
  signal Bus_PC_1 : std_logic_vector(31 downto 0);  
  signal Bus_PC_1_offset   : std_logic_vector(31 downto 0);  
  signal Bus_offset_extend : std_logic_vector(31 downto 0); 	
    	
--COMPONENT extender
	component extension_signe is
	  Generic(w_ext:positive);
		port(
			e : in std_logic_vector((w_ext-1) downto 0);
			s : out std_logic_vector(31 downto 0)
		);
	end component;
	
	--COMPONENT PC
	component PC is 
	port (
		Data_in   : in  std_logic_vector(31 downto 0);
		Data_out  : out std_logic_vector(31 downto 0);
		clk,reset : in  std_logic
	);
	end component;
		
  --COMPONENT DECLARATION
	component mult2_1 is
	  Generic(w_mult:positive);
		port(
			a,b : in std_logic_vector((w_mult-1) downto 0);
			com : in std_logic;
			s : out std_logic_vector((w_mult-1) downto 0)
		);
	end component;
	
  --COMPONENT INSTRUCTION MEMORY
	component instruction_memory is
	port (
		addr        : in  std_logic_vector(31 downto 0);
		instruction : out std_logic_vector(31 downto 0);
		reset   : in  std_logic
	);
	end component;
	
	begin
	  
	--INSTANCIATION extender
	i_ext : extension_signe GENERIC MAP (
	 w_ext => 24
	)
	PORT MAP (
    	e => offset,
    	s => Bus_offset_extend
	);
	
	--INSTANCIATION PC 
	i_pc : PC PORT MAP (
	  Data_in   => Bus_mux,
		Data_out  => Bus_PC,
		clk   => clk,
		reset => reset
	);
	
 --INSTANCIATION mux
	i_mux : mult2_1 GENERIC MAP (
	 w_mult => 32
	)
	PORT MAP (
    	a   => Bus_PC_1,
    	b   => Bus_PC_1_offset ,
    	com => nPCsel,
    	s   => Bus_mux
	);
	
	--INSTANCIATION INSTRUCTION MEMORY
	i_Im : instruction_memory PORT MAP(
	  addr  => Bus_PC,
		instruction => instruction,
		reset => reset
	);
	
	Bus_PC_1 <= Bus_PC + 1;
	Bus_PC_1_offset <= Bus_PC_1 + Bus_offset_extend;
  
end architecture comport_ugi;

--FIN PROGRAMME