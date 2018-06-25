library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity PC_tb is
end entity;

architecture arq_PC of PC_tb is

-- Defino el componente
component PC is
  
    port (
		  D_o      : out  std_logic_vector(9 downto 0);
        CLOCK_i  : in  std_logic;
        IMGEN_i: in std_logic_vector(63 downto 0);
			INCOND_i: in std_logic;
			COND_i: in std_logic;
			ZERO_i: in std_logic;
			RESET_i: in std_logic
		  );
end component;

-- Defino Seniales de Interconexion.


	signal Do_s   :  std_logic_vector(9  downto 0);
	signal CLOCK_s   :  std_logic;
	signal IMGEN_s   :  std_logic_vector(63  downto 0);
	signal INCOND_s : std_logic;
	signal COND_s   :  std_logic;
	signal ZERO_s:	std_logic;
	signal RESET_s: std_logic;

begin

-- Se instaancia al PC
	PC1: PC port map (
		D_o => Do_s, 
		CLOCK_i => CLOCK_s,
		IMGEN_i => IMGEN_s,
		INCOND_i => INCOND_s,
		COND_i => COND_s,
		ZERO_i => ZERO_s,
		RESET_i => RESET_s
		
		);
		
 process
	begin
	-- RESET y ver salida no modificada por el salt incondicional
	RESET_s <= '0';   
	CLOCK_s <= '0';
	IMGEN_s <= "0000000000000000000000000000000000000000000000000000000000010000";
	INCOND_s <= '1';
	COND_s <= '0' ;
	ZERO_s <= '0';
		
	
	wait for 20 ns;
	
	-- primer flanco y salto incondicional al 0 + 510
	--(notar que es IMGEN = 255, pero luego se hace rotacion a izquierada)
	RESET_s <= '1' ;  
	CLOCK_s <= '1';
	IMGEN_s <= "0000000000000000000000000000000000000000000000000000000000010000";
	INCOND_s <= '1';
	COND_s <= '0' ;
	ZERO_s <= '1';
		
	
	wait for 20 ns;
	
		-- baja el flanco y salto incondicional al 510 + 10
	RESET_s <= '1' ;  
	CLOCK_s <= '0';
	IMGEN_s <= "1111111111111111111111111111111111111111111111111111111111110110";
	INCOND_s <= '1';
	COND_s <= '0' ;
	ZERO_s <= '1';
	
	wait for 20 ns;
	   --- sube le flanco de clock y debe saltar a la direccion 255+10
	RESET_s <= '1' ;  
	CLOCK_s <= '1';
	IMGEN_s <= "0000000000000000000000000000000000000000000000000000000000000001";
	INCOND_s <= '0';
	COND_s <= '0' ;
	ZERO_s <= '1';
	
	wait for 20 ns;
	
	RESET_s <= '1';
	CLOCK_s <= '0';
   
	wait for 20 ns;
	----- salto normal sin condicion es decir Pc + 4
	RESET_s <= '1';
	CLOCK_s <= '1';
	IMGEN_s <= "0000000000000000000000000000000000000000000000000000000000000001";
	INCOND_s <= '0';
	COND_s <= '0' ;
	ZERO_s <= '1';
	
	wait for 20 ns;
	
	CLOCK_s <= '0';
	
	wait for 20 ns;
	
-- valor de PC + 4 = 8
	CLOCK_s <= '1'; 
	
	wait for 20 ns;
	
	CLOCK_s <= '0';
	
	wait for 20 ns;
--- valor de PC + 4 = 12
	
	CLOCK_s <= '1';
	
	wait for 20 ns;
	wait;
	end process;

	end architecture arq_PC;	
