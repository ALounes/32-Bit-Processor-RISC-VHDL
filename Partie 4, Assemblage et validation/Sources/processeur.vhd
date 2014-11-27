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

entity processeur is
  port(
    CLK   : in std_logic;
    RESET : in std_logic
  );
end entity processeur;

--ARCHITECTURE

architecture comport_proc of processeur is
  
    signal p_RegSel      : std_logic;
    --signal p_WrEn        : std_logic;
    signal p_WrSrc       : std_logic;
    signal p_RegWr       : std_logic;
    signal p_ALUSrc      : std_logic;
    signal p_ALUCtr      : std_logic_vector(01 downto 0);
    signal p_Flag_alu    : std_logic;
    signal p_offset      : std_logic_vector(23 downto 0);
    signal p_nPCsel      : std_logic;
    signal p_instruction : std_logic_vector(31 downto 0);
	  signal p_PSRValue    : std_logic_vector(31 downto 0);
	  signal p_DATAIN      : std_logic_vector(31 downto 0);
    signal p_PSREn       : std_logic;
	  signal p_MemWr       : std_logic;
		--signal p_WE          : std_logic;
		--signal p_DATAOUT     : std_logic_vector(31 downto 0);
  
component unite_de_traitement_final is
  port (
    --INPUT
    Rd     : in  std_logic_vector(03 downto 0);
    Rn     : in  std_logic_vector(03 downto 0);
    mux_Rm : in  std_logic_vector(03 downto 0);
    mux_Rd : in  std_logic_vector(03 downto 0);
    Imm    : in  std_logic_vector(07 downto 0);
    --CTR
    RegSel      : in  std_logic;
    WrEn        : in  std_logic;
    WrSrc       : in  std_logic;
    RegWr       : in  std_logic;
    ALUSrc      : in  std_logic;
    ALUCtr      : in  std_logic_vector(01 downto 0);
    --SPE
    Clk         : in  std_logic;
    reset       : in  std_logic;
    --OUTPUT
    Flag_alu    : out std_logic
  );
end component;

component unite_de_gestion_des_instructions is
  port (
    --INPUT
    offset      : in std_logic_vector(23 downto 0);
    --CTR
    nPCsel      : in std_logic;
    --SPE
    clk         : in std_logic;
    reset       : in std_logic;
    --OUTPUT
    instruction : out std_logic_vector(31 downto 0)
  );
end component;

component Decodeur is
	port (
	   --INPUT
	   instruction: in std_logic_vector(31 downto 0);
	   PSRValue   : in std_logic_vector(31 downto 0);
	   --OUTPUT
	   ALUCtr     : out std_logic_vector(01 downto 0);
	   nPCsel     : out std_logic ;
	   RegWr      : out std_logic ;
	   ALUSrc     : out std_logic ;
	   PSREn      : out std_logic ;
	   MemWr      : out std_logic ;
	   WrSrc      : out std_logic ;	
	   RegSel     : out std_logic    
	);
end component;

component REG_PSR is
	port (
	  --INPUT
		DATAIN    : in  std_logic_vector(31 downto 0);
		--CTR
		WE        : in  std_logic;
    --SPE
		CLK       : in  std_logic;
		RESET     : in  std_logic;
		--OUTPUT
		DATAOUT   : out std_logic_vector(31 downto 0)
	);
end component;

begin
  
p_DATAIN <= "0000000000000000000000000000000" & p_Flag_alu ;
  
ETQ_PSR: REG_PSR
PORT MAP(
	  --INPUT
		DATAIN    => p_DATAIN,		
		--CTR
		WE        => p_PSREn,
    --SPE
		CLK       => CLK,
		RESET     => RESET,
		--OUTPUT
		DATAOUT   => p_PSRValue
);  
  
ETQ_DECODEUR: Decodeur
PORT MAP(
     --INPUT
     instruction => p_instruction,
	   PSRValue    => p_PSRValue,
	   --OUTPUT
	   ALUCtr      => p_ALUCtr,
	   nPCsel      => p_nPCsel,
	   RegWr       => p_RegWr,
	   ALUSrc      => p_ALUSrc,
	   PSREn       => p_PSREn,
	   MemWr       => p_MemWr,
	   WrSrc       => p_WrSrc,
	   RegSel      => p_RegSel
);

ETQ_GESTION_INSTRUCTION:unite_de_gestion_des_instructions
PORT MAP(
     --INPUT
	   offset      => p_instruction(23 downto 0),
	   --CTR
     nPCsel      => p_nPCsel,
     --SPE
	   clk         => CLK,
	   reset       => RESET,
	   --OUTPUT
	   instruction => p_instruction
);
EQT_TRAITEMENT:unite_de_traitement_final
PORT MAP(
    --INPUT
    Rd       => p_instruction(15 downto 12),
    Rn       => p_instruction(19 downto 16),
    mux_Rm   => p_instruction(03 downto 00),
    mux_Rd   => p_instruction(15 downto 12),
    Imm      => p_instruction(07 downto 00),
    --CTR
    RegSel   => p_RegSel,     
    WrEn     => p_MemWr,    
    WrSrc    => p_WrSrc,    
    RegWr    => p_RegWr,    
    ALUSrc   => p_ALUSrc ,     
    ALUCtr   => p_ALUCtr,     
    --SPE
    Clk      => CLK,    
    reset    => RESET, 
    --OUTPUT
    Flag_alu => p_Flag_alu
    --p_DATAIN(0)  
);
end architecture comport_proc;

--FIN PROGRAMME
