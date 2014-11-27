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

entity unite_de_traitement is
  port (
    --INPUT
    Rw ,Ra ,Rb : in  std_logic_vector(03 downto 0);
    Imm : in  std_logic_vector(07 downto 0);
    --CTR
    WrEn    : in  std_logic;
    Ctr_mux_01 ,Ctr_mux_02,RegWr : in  std_logic;
    Ctr_Alu : in  std_logic_vector(01 downto 0);
    --OUTPUT
    Flag_alu : out std_logic;
    --SPE
    Clk,reset_reg,reset_mem  : in  std_logic
  );
end entity unite_de_traitement;

--ARCHITECTURE

architecture comport_ut of unite_de_traitement is
  
  constant w_mult : positive := 32;
  constant w_ext  : positive := 8;
 	signal BusA   : std_logic_vector(31 downto 0);
	signal BusB   : std_logic_vector(31 downto 0);
	signal BusW   : std_logic_vector(31 downto 0);
	signal BusExt : std_logic_vector(31 downto 0);
	signal BusMux_01   : std_logic_vector(31 downto 0);
	signal BusAlu_Out  : std_logic_vector(31 downto 0);
	signal BusData_In  : std_logic_vector(31 downto 0);
	signal BusData_Out : std_logic_vector(31 downto 0);
	
  --COMPONENT DECLARATION
  component ual
    port (
      a,b : in std_logic_vector(31 downto 0);
      op     : in std_logic_vector(01 downto 0);
      y      : out std_logic_vector(31 downto 0);
      n      : out std_logic
    );
  end component;
  
  component Banc_de_16_registres_32 
    port ( 
      we,clk,reset   : in std_logic; 
      rw,ra,rb : in  std_logic_vector(03 downto 0); 
		  w        : in  std_logic_vector(31 downto 0); 
		  a,b      : out std_logic_vector(31 downto 0)
		  ); 
  end component Banc_de_16_registres_32; 
	
	component mult2_1 is
	  Generic(w_mult:positive);
		port(
			a,b : in std_logic_vector((w_mult-1) downto 0);
			com : in std_logic;
			s : out std_logic_vector((w_mult-1) downto 0)
		);
	end component;
	
	component extension_signe is
	  Generic(w_ext:positive);
		port(
			e : in std_logic_vector((w_ext-1) downto 0);
			s : out std_logic_vector(31 downto 0)
		);
	end component;
  
  component Data_memory is
	port (
		addr     : in std_logic_vector(05 downto 0);
		clk ,WrEn ,reset: in std_logic;
		Data_In  : in   std_logic_vector(31 downto 0);
		Data_Out : out  std_logic_vector(31 downto 0)
	);
  end component;
  
begin
  
  I_BDR : Banc_de_16_registres_32 PORT MAP ( 
	  RESET => reset_reg,
	  RW => Rw, 
	  RA => Ra, 
	  RB => Rb, 
	  W => BusW,
	  A => BusA, 
	  B => BusB, 
	  CLK => Clk, 
	  WE => RegWr 
	); 
  
  I_UAL: ual PORT MAP (
    a  => BusA,
    b  => BusMux_01,
    y  => BusAlu_Out,
    op => Ctr_Alu,
    n  => Flag_alu
  );
  
  I_MUL_1: mult2_1 GENERIC MAP (
	 w_mult => w_mult
	)
	PORT MAP (
    	a => BusB,
    	b => BusExt,
    	com => Ctr_mux_01,
    	s => BusMux_01
	);
  
  I_MUL_2: mult2_1 GENERIC MAP (
	 w_mult => w_mult
	)
	PORT MAP (
   	 a => BusAlu_Out,
    	b => BusData_Out,
    	com => Ctr_mux_02,
    	s => BusW
	);
  
  I_ext_signe: extension_signe GENERIC MAP (
	 w_ext => w_ext
	)
	PORT MAP (
    	e => Imm ,
    	s => BusExt
	);
	
  I_Data_memory : data_memory PORT MAP (
    addr  => BusAlu_Out(5 downto 0),
    clk  => Clk,
    WrEn  => WrEn,
    reset => reset_mem,
    Data_In  => BusB,
    Data_Out => BusData_Out 
  );
  
end architecture comport_ut;