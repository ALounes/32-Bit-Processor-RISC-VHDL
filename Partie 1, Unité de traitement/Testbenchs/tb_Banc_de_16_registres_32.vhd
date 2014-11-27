------------------------------------
-- ACHAB LOUNES - MAXIME MARTELLI --
----- NUM_3 : TP VHDL [EI-SE4] -----
------------------------------------

--LIBRARY

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--ENTITY

entity tb_Banc_de_16_registres_32 is 
end entity tb_Banc_de_16_registres_32; 
 
--ARCHITECTURE

architecture tb_comp_bdr of tb_Banc_de_16_registres_32 is 

	--SIGNAL DECLARATION 
	signal tb_rw : std_logic_vector(3 downto 0);
	signal tb_ra : std_logic_vector(3 downto 0);
	signal tb_rb : std_logic_vector(3 downto 0); 
	signal tb_w  : std_logic_vector(31 downto 0);
	signal tb_a  : std_logic_vector(31 downto 0);
	signal tb_b  : std_logic_vector(31 downto 0); 
	signal tb_clk   : std_logic := '0'; 
	signal tb_we    : std_logic; 
	signal tb_reset : std_logic; 

  --COMPONENT DECLARATION
	component Banc_de_16_registres_32 
	port ( 
	  we    : in std_logic; 
	  clk   : in std_logic;
	  reset : in std_logic;
	  rw : in std_logic_vector(3 downto 0);
	  ra : in std_logic_vector(3 downto 0);
	  rb : in std_logic_vector(3 downto 0); 
	  w  : in std_logic_vector(31 downto 0); 
	  a  : out std_logic_vector(31 downto 0);
	  b  : out std_logic_vector(31 downto 0)
	); 
	end component; 


begin 
 
  --INSTANCIATION
	Instanciation : Banc_de_16_registres_32 PORT MAP ( 
	  reset => tb_reset,
	  rw => tb_rw, 
	  ra => tb_ra, 
	  rb => tb_rb, 
	  w => tb_w,
	  a => tb_a, 
	  b => tb_b, 
	  clk => tb_clk, 
	  we => tb_we 
	); 
 
 
 --Generation 
 
 tb_clk <= not tb_clk after 25 ps ;

 WRITE : process
 begin
   
   tb_reset <= '1';
   tb_w <= X"00000001";
   tb_we <= '1';  
   tb_rw <= x"0" ; 
   tb_ra <= x"0" ;
   tb_rb <= x"F" ;
   
   wait for 50 ps;
   
   tb_reset <= '0';
   
   wait for 50 ps;
   
   tb_reset <= '1';
   tb_w <= X"00000002";
   tb_we <= '1';  
   tb_rw <= x"0" ; 
   tb_ra <= x"0" ;
   tb_rb <= x"F" ;
   
   wait for 50 ps;
   
   tb_reset <= '1';
   tb_w <= X"00000003";
   tb_we <= '1';  
   tb_rw <= x"0" ; 
   tb_ra <= x"0" ;
   tb_rb <= x"F" ;
   
   wait for 50 ps;
   
   tb_reset <= '1';
   tb_w <= X"00000004";
   tb_we <= '1';  
   tb_rw <= x"0" ; 
   tb_ra <= x"0" ;
   tb_rb <= x"F" ;

   
 end process ;
 
 
 
end architecture tb_comp_bdr; 
 
