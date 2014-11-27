library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_UAL_REG is 
end entity tb_UAL_REG ;

architecture tb_Comp of tb_UAL_REG is
		--CTR
		signal tb_we :  std_logic;
		signal tb_OP :  std_logic_vector(1 downto 0);
		--INPUT
	  signal tb_rw     :  std_logic_vector(3 downto 0);
	  signal tb_ra     :  std_logic_vector(3 downto 0);
	  signal tb_rb     :  std_logic_vector(3 downto 0);
		signal tb_REG_IN :  std_logic_vector(31 downto 0);
		--OUTPUT
		signal tb_ALU_out : std_logic_vector(31 downto 0);
		signal tb_n       : std_logic;
		--SPE
		signal tb_reset : std_logic;
		signal tb_Clk   : std_logic := '1';
  
  --COMPONENT DECLARATION
  component UAL_REG
	port(
		--CTR
		we : in std_logic;
		OP : in std_logic_vector(1 downto 0);
		--INPUT
		rw     : in std_logic_vector(3 downto 0);
		ra     : in std_logic_vector(3 downto 0);
		rb     : in std_logic_vector(3 downto 0);
		REG_IN : in std_logic_vector(31 downto 0);
		--OUTPUT
		ALU_out : out std_logic_vector(31 downto 0);
		n       : out std_logic;
		--SPE
		Clk   : in std_logic;
		reset : in std_logic
	);
	
	end component UAL_REG;
	
begin
  
  --INSTANCIATION
  I_UAL_REG : UAL_REG PORT MAP (
    we => tb_we,
	  OP => tb_OP,
	  rw => tb_rw,
	  ra => tb_ra,
	  rb => tb_rb,
		REG_IN => tb_REG_IN,
		ALU_out => tb_ALU_out,
		n => tb_n,
    Clk => tb_Clk,
    reset => tb_reset
  );
  
   --Generation 
  
  tb_REG_IN <= tb_ALU_out ;
  tb_Clk <= not tb_Clk after 50 ps ;
  tb_reset <= '1';  
  
  process 
  begin 
    
	  tb_OP <= "11";
	  tb_rw <= "0001";
	  tb_ra <= "1111";
    tb_we <= '1';
    
    wait for 100 ps;
  
	  tb_OP <= "00";
	  tb_rw <= "0001";
	  tb_ra <= "0001";
	  tb_rb <= "1111";
    tb_we <= '1';
    
    wait for 100 ps;
  
	  tb_OP <= "00";
	  tb_rw <= "0010";
	  tb_ra <= "0001";
	  tb_rb <= "1111";
    tb_we <= '1';
    
    wait for 100 ps;

	  tb_OP <= "10";
	  tb_rw <= "0011";
	  tb_ra <= "0001";
	  tb_rb <= "1111";
    tb_we <= '1';

    wait for 100 ps;
    
	  tb_OP <= "10";
	  tb_rw <= "0101";
	  tb_ra <= "0111";
	  tb_rb <= "1111";
    tb_we <= '1';

    wait for 100 ps;

  end process ;
  
end architecture tb_Comp ;