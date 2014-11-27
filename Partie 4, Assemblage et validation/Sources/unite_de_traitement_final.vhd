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

entity unite_de_traitement_final is
  port (
    --INPUT
    Rd     : in  std_logic_vector(03 downto 0);
    Rn     : in  std_logic_vector(03 downto 0);
    mux_Rm : in  std_logic_vector(03 downto 0);
    mux_Rd : in  std_logic_vector(03 downto 0);
    Imm    : in  std_logic_vector(07 downto 0);
    --CTR
    RegSel     : in  std_logic;
    WrEn       : in  std_logic;
    WrSrc      : in  std_logic;
    RegWr      : in  std_logic;
    ALUSrc     : in  std_logic;
    ALUCtr     : in  std_logic_vector(01 downto 0);
    --SPE
    Clk        : in  std_logic;
    reset      : in  std_logic;
    --OUTPUT
    Flag_alu   : out std_logic
  );
end entity unite_de_traitement_final;

--ARCHITECTURE

architecture comport_ut of unite_de_traitement_final is
  
  constant w_mult    : positive := 32;
  constant w_ext     : positive := 8;
  constant w_rb      : positive := 4;
 	signal BusA        : std_logic_vector(31 downto 0);
	signal BusB        : std_logic_vector(31 downto 0);
	signal BusW        : std_logic_vector(31 downto 0);
	signal BusExt      : std_logic_vector(31 downto 0);
	signal BusAluSrc   : std_logic_vector(31 downto 0);
	signal BusAluOut   : std_logic_vector(31 downto 0);
	signal BusRb       : std_logic_vector(03 downto 0);
	signal BusData_Out : std_logic_vector(31 downto 0);
	signal BusFlag_alu : std_logic ;
	
  --COMPONENT DECLARATION
  component ual
    port (
      a,b    : in  std_logic_vector(31 downto 0);
      op     : in  std_logic_vector(01 downto 0);
      y      : out std_logic_vector(31 downto 0);
      n      : out std_logic
    );
  end component;
  
  component Banc_de_16_registres_32 
    port ( 
      we,clk,reset : in std_logic; 
      rw,ra,rb : in  std_logic_vector(03 downto 0); 
		  w        : in  std_logic_vector(31 downto 0); 
		  a,b      : out std_logic_vector(31 downto 0)
		  ); 
  end component Banc_de_16_registres_32; 
	
	component mult2_1 is
	  Generic(w_mult:positive);
		port(
			a   : in  std_logic_vector((w_mult-1) downto 0);
			b   : in  std_logic_vector((w_mult-1) downto 0);
			com : in  std_logic;
			s   : out std_logic_vector((w_mult-1) downto 0)
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
		clk      : in std_logic;
		WrEn     : in std_logic;
		reset    : in std_logic;
		Data_In  : in   std_logic_vector(31 downto 0);
		Data_Out : out  std_logic_vector(31 downto 0)
	);
  end component;
  
begin
  
  Flag_alu <= BusFlag_alu;
  
  I_BDR : Banc_de_16_registres_32 PORT MAP ( 
	  RESET => reset,
	  RW    => Rd, 
	  RA    => Rn, 
	  RB    => BusRb, 
	  W     => BusW,
	  A     => BusA, 
	  B     => BusB, 
	  CLK   => Clk, 
	  WE    => RegWr 
	); 
  
  I_UAL: ual PORT MAP (
    a  => BusA,
    b  => BusALUSrc,
    y  => BusAluOut,
    op => ALUCtr,
    n  => BusFlag_alu 
  );
  
  I_MUX_ALUSrc: mult2_1 GENERIC MAP (
	 w_mult => w_mult
	)
	PORT MAP (
    	a   => BusB,
    	b   => BusExt,
    	com => ALUSrc,
    	s   => BusALUSrc
	);
  
  I_MUL_ALUCtr: mult2_1 GENERIC MAP (
	 w_mult => w_mult
	)
	PORT MAP (
   	 a   => BusAluOut,
    	b   => BusData_Out,
    	com => WrSrc,
    	s   => BusW
	);
	
	I_MUL_RB: mult2_1 GENERIC MAP (
	 w_mult => w_rb
	)
	PORT MAP (
   	 a   => mux_Rm,
    	b   => mux_Rd,
    	com => RegSel,
    	s   => BusRb
	);
  
  I_ext_signe: extension_signe GENERIC MAP (
	 w_ext => w_ext
	)
	PORT MAP (
    	e => Imm ,
    	s => BusExt
	);
	
  I_Data_memory : data_memory PORT MAP (
    addr     => BusAluOut(5 downto 0),
    clk      => Clk,
    WrEn     => WrEn,
    reset    => reset,
    Data_In  => BusB,
    Data_Out => BusData_Out 
  );
  
end architecture comport_ut;