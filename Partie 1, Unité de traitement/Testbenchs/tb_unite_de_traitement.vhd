
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

entity tb_unite_de_traitement is
end entity tb_unite_de_traitement;

--ARCHITECTURE

architecture tb_comport_ut of tb_unite_de_traitement is
  
	 --constant w : positive := 32;
 	  signal tb_Rw  : std_logic_vector(03 downto 0);
 	  signal tb_Ra  : std_logic_vector(03 downto 0);
 	  signal tb_Rb  : std_logic_vector(03 downto 0);
    signal tb_Imm : std_logic_vector(07 downto 0);
    --CTR
    signal tb_WrEn       : std_logic;
    signal tb_Ctr_mux_01 : std_logic;
    signal tb_Ctr_mux_02 : std_logic;
    signal tb_RegWr      : std_logic;
    signal tb_Ctr_Alu    : std_logic_vector(01 downto 0);
    --OUTPUT
    signal tb_Flag_alu : std_logic;
    --SPE
    signal tb_reset_reg : std_logic;
    signal tb_reset_mem : std_logic;
	  signal tb_Clk       : std_logic := '1';
	
  --COMPONENT DECLARATION
  component unite_de_traitement
    
    port (
      --INPUT
      Rw  : in  std_logic_vector(03 downto 0);
      Ra  : in  std_logic_vector(03 downto 0);
      Rb  : in  std_logic_vector(03 downto 0);
      Imm : in  std_logic_vector(07 downto 0);
      --CTR
      WrEn       : in  std_logic;
      Ctr_mux_01 : in  std_logic;
      Ctr_mux_02 : in  std_logic;
      RegWr      : in  std_logic;
      Ctr_Alu    : in  std_logic_vector(01 downto 0);
      --OUTPUT
      Flag_alu  : out std_logic;
      --SPE
      Clk       : in  std_logic;
      reset_reg : in  std_logic;
      reset_mem : in  std_logic
    );
  end component;

  begin 
  
  --INSTANCIATION 
	Instanciation: unite_de_traitement PORT MAP (
    	Rw   => tb_Rw,
		 Ra   => tb_Ra,
    	Rb   => tb_Rb,
    	Imm  => tb_Imm,
    	WrEn => tb_WrEn,
    	Ctr_mux_01 => tb_Ctr_mux_01,
    	Ctr_mux_02 => tb_Ctr_mux_02,
    	RegWr      => tb_RegWr,
    	Ctr_Alu    => tb_Ctr_Alu,
    	Flag_alu   => tb_Flag_alu,
    	Clk        => tb_Clk,
    	reset_reg  => tb_reset_reg,
    	reset_mem  => tb_reset_mem
	);
	
  --PROCESS TEST BENCH

  tb_Clk <= not tb_Clk after 50 ps ; 
      
  tb_reset_reg <= '1';
  tb_reset_mem <= '1';
  
  process
 	begin
 	  
 	  --addition de deux registres : R[0] <- R[0] + R[15]
 	 
    tb_Rw <= "0000";
	  tb_Ra <= "0000";
	  tb_Rb <= "1111";
	 
    
    tb_Ctr_mux_01 <= '0';
    tb_Ctr_mux_02 <= '0';
    tb_RegWr <= '1';
    tb_Ctr_Alu <= "00";
    
    wait for 100 ps;
    
    --addition d'un registre avec une valeur immédiate : R[1] <- R[0] + 1
    
    tb_Imm <= "00000001";
    tb_Ctr_mux_01 <= '1';
    tb_Rw <= "0001";
    
    wait for 100 ps;

    --soustraction de deux registres : R[2] <- R[1] - R[0]
    
    tb_Rw <= "0010";
    tb_Ra <= "0001";
	  tb_Rb <= "0000";
	  tb_Ctr_mux_01 <= '0';
    tb_Ctr_Alu <= "10";

    wait for 100 ps;
    
    --soustraction d'une valeur immédiate à 1 registre : R[3] <- R[0] - 1
    
    tb_Ctr_mux_01 <= '1';
    
    tb_Rw <= "0011";
    tb_Ra <= "0000";
    
    wait for 100 ps;
    
    --copie de la valeur d'un registre dans un autre registre : R[4] <- R[3]
    
    tb_Ctr_mux_01 <= '0';
    tb_Ctr_Alu <= "11";
    
    tb_Rw <= "0100";
    tb_Ra <= "0011";
    
    wait for 100 ps;
    
    --écriture d'un registre dans un mot de la mémoire : écriture de R[4] dans la ligne  0 de la mémoire
    
    tb_WrEn <= '1';
    tb_RegWr <= '0';
    tb_Imm <= "00000000";
    tb_Ctr_mux_01 <= '1';
    tb_Ctr_Alu <= "01";
    tb_Rb <= "0011";
    
    wait for 100 ps;
    
    --lecture d'un mot de la mémoire dans un registre : écriture de la ligne 0 dans R[5]
    
    tb_WrEn <= '0';
    tb_RegWr <= '1';
    tb_Ctr_mux_02 <= '1';
    tb_Ctr_Alu <= "01";
    tb_Rw <= "0101";
    
    wait for 100 ps;

end process;


end architecture tb_comport_ut;
