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

entity Decodeur is
	port (
	   instruction : in std_logic_vector(31 downto 0);
	   PSRValue    : in std_logic_vector(31 downto 0);
	   ALUCtr      : out std_logic_vector(01 downto 0);
	   nPCsel      : out std_logic ;
	   RegWr       : out std_logic ;
	   ALUSrc      : out std_logic ;
	   PSREn       : out std_logic ;
	   MemWr       : out std_logic ;
	   WrSrc       : out std_logic ;
	   RegSel      : out std_logic 
	);
end entity Decodeur;

--ARCHITECTURE

architecture comport_decodeur of Decodeur is
  
  --TYPE ET SIGNAL DECLARATION
  type enum_instruction is (MOV, ADDI, ADDr, CMP, LDR, STR, BAL, BLT);
  signal instr_courante : enum_instruction;
  signal BIT_27_26 : std_logic_vector(01 downto 0);
  signal BIT_24_23 : std_logic_vector(01 downto 0);
  signal BIT_30    : std_logic;
  signal BIT_25    : std_logic;
  signal BIT_20    : std_logic;
  
begin
  
  BIT_27_26 <= instruction(27) & instruction(26);
  BIT_24_23 <= instruction(24) & instruction(23);
  BIT_30    <= instruction(30);
  BIT_25    <= instruction(25);
  BIT_20    <= instruction(20);
  
  INSTR : process(BIT_27_26 ,BIT_24_23 ,BIT_30 ,BIT_25 ,BIT_20)  
  begin
  
      BIT2726: case Bit_27_26 is
                  when "00" =>
                    BIT2423: case BIT_24_23 is
                                when "01"   => 
                                  if BIT_25 = '1' then
                                    instr_courante <= ADDI;
                                  else
                                    instr_courante <= ADDr;
                                  end if;
                                when "10"    => instr_courante <= CMP;
                                when others  => instr_courante <= MOV;
                             end case BIT2423;
                          
                  when "10" =>
                    BIT30: if (BIT_30 = '1') then
                              instr_courante <= BAL;
                           else
                              instr_courante <= BLT; 
                           end if;
                           
                  when others => 
                   BIT20:  if (BIT_20 = '1') then
                              instr_courante <= LDR;
                           else
                              instr_courante <= STR; 
                           end if;
                           
               end case BIT2726;
                  
  end process;

  INSTR_COUR : process(instr_courante)
  begin
      case instr_courante is
        
        when MOV  => 
           nPCsel <= '0';
	         RegWr  <= '1';
	         ALUSrc <= '1';
	         ALUCtr <= "01";
	         PSREn  <= '0';
	         MemWr  <= '0';
	         WrSrc  <= '0';
	         RegSel <= '0';
	         
        when ADDI => 
           nPCsel <= '0';
	         RegWr  <= '1';
	         ALUSrc <= '1';
	         ALUCtr <= "00";
	         PSREn  <= '0';
	         MemWr  <= '0';
	         WrSrc  <= '0';
	         RegSel <= '0';
	         
        when ADDr => 
           nPCsel <= '0';
	         RegWr  <= '1';
	         ALUSrc <= '0';
	         ALUCtr <= "00";
	         PSREn  <= '0';
	         MemWr  <= '0';
	         WrSrc  <= '0';
	         RegSel <= '0';
	         
        when CMP  => 
           nPCsel <= '0';
	         RegWr  <= '0';
	         ALUSrc <= '1';
	         ALUCtr <= "10";
	         PSREn  <= '1';
	         MemWr  <= '0';
	         RegSel <= '0';
	         
        when LDR  => 
           nPCsel <= '0';
	         RegWr  <= '1';
	         ALUSrc <= '0';
	         ALUCtr <= "11";
	         PSREn  <= '0';
	         MemWr  <= '0';
	         WrSrc  <= '1';
	         RegSel <= '0';
	         
        when STR  => 
           nPCsel <= '0';
	         RegWr  <= '0';
	         ALUSrc <= '0';
	         ALUCtr <= "11";
	         PSREn  <= '0';
	         MemWr  <= '1';
	         RegSel <= '1';
	         
        when BAL  => 
           nPCsel <= '1';
	         RegWr  <= '0';
	         PSREn  <= '0';
	         RegSel <= '0';
	         MemWr  <= '0';
	         
        when others => --BLT 
           nPCsel <= PSRValue(0);
	         RegWr  <= '0';
	         PSREn  <= '0';
	         MemWr  <= '0';
	         RegSel <= '0';
	         
      end case; 
  end process;

end architecture comport_decodeur;

--FIN PROGRAMME
