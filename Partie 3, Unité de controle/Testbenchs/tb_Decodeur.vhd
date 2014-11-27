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

entity tb_Decodeur is
end entity tb_Decodeur;

--ARCHITECTURE

architecture comport_decodeur of tb_Decodeur is
  
	 signal tb_instruction : std_logic_vector(31 downto 0);
	 signal tb_PSRValue    : std_logic_vector(31 downto 0);
	 signal tb_ALUCtr      : std_logic_vector(01 downto 0);
	 signal tb_nPCsel      : std_logic;
	 signal tb_RegWr       : std_logic;
	 signal tb_ALUSrc      : std_logic;
	 signal tb_PSREn       : std_logic;
	 signal tb_MemWr       : std_logic;
	 signal tb_WrSrc       : std_logic;
	 signal tb_RegSel      : std_logic;

  --COMPONENT DECLARATION
  component Decodeur
  	port (
	   instruction : in  std_logic_vector(31 downto 0);
	   PSRValue    : in  std_logic_vector(31 downto 0);
	   ALUCtr      : out std_logic_vector(01 downto 0);
	   nPCsel      : out std_logic ;
	   RegWr       : out std_logic ;
	   ALUSrc      : out std_logic ;
	   PSREn       : out std_logic ;
	   MemWr       : out std_logic ;
	   WrSrc       : out std_logic ;
	   RegSel      : out std_logic 
	  );
	 end component;

begin

  --INSTANCIATION 
  i_decod : Decodeur 
   PORT MAP (
	   instruction => tb_instruction,
	   PSRValue    => tb_PSRValue,
	   ALUCtr      => tb_ALUCtr,
	   nPCsel      => tb_nPCsel,
	   RegWr       => tb_RegWr,
	   ALUSrc      => tb_ALUSrc,
	   PSREn       => tb_PSREn,
	   MemWr       => tb_MemWr,
	   WrSrc       => tb_WrSrc,
	   RegSel      => tb_RegSel
   );

  TEST: process
  begin
    
    -- FOR n = 0 
    -- PSRValue
    
    tb_PSRValue    <= X"00000000";
    
    --MOV
    tb_instruction <= X"E3A01020";
     
    wait for 50 ps;
    
    --MOV
    tb_instruction <= X"E3A02000";
    
    wait for 50 ps;
    
    --LDR
    tb_instruction <= X"E6110000";
    
    wait for 50 ps;
    
    --ADDr
    tb_instruction <= X"E0822000";
    
    wait for 50 ps;
    
    --ADDI
    tb_instruction <= X"E2811001";
    
    wait for 50 ps;
    
    --CMP
    tb_instruction <= X"E351002A";
    
    wait for 50 ps;
    
    
    --BLT
    tb_instruction <= X"BAFFFFFB";
    
    wait for 50 ps;
    
    --STR
    tb_instruction <= X"E6012000";
    
    wait for 50 ps;
    
    --BAL
    tb_instruction <= X"EAFFFFF7";
    
    wait for 50 ps;
    
    
    -- FOR n = 1 
    -- PSRValue
    tb_PSRValue <= X"00000001";
    
    --MOV
    tb_instruction <= X"E3A01020";
     
    wait for 50 ps;
    
    --MOV
    tb_instruction <= X"E3A02000";
    
    wait for 50 ps;
    
    --LDR
    tb_instruction <= X"E6110000";
    
    wait for 50 ps;
    
    --ADDr
    tb_instruction <= X"E0822000";
    
    wait for 50 ps;
    
    --ADDI
    tb_instruction <= X"E2811001";
    
    wait for 50 ps;
    
    --CMP
    tb_instruction <= X"E351002A";
    
    wait for 50 ps;
    
    
    --BLT
    tb_instruction <= X"BAFFFFFB";
    
    wait for 50 ps;
    
    --STR
    tb_instruction <= X"E6012000";
    
    wait for 50 ps;
    
    --BAL
    tb_instruction <= X"EAFFFFF7";
    
    wait for 50 ps;
    
  end process;

end architecture comport_decodeur;

--FIN PROGRAMME
