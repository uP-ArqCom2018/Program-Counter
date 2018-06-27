---- PROGRAM COUNTER uP RISC V
---- MATERIA ARQUITECTURA DE COMPUTADORAS - UNSL
---  AUTORES: FRANCALANCIA MARIANO, GONZALEZ ROBERTO


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity PC is
generic (N: integer :=32;
			anchodataout: integer :=10); ---para compatibilidad colocar 10
	
	port( D_o: out std_logic_vector(anchodataout-1 downto 0); ----- a fin de compatibilizar con MEM Instruccion
			CLOCK_i: in std_logic;
			IMGEN_i: in std_logic_vector(2*N-1 downto 0);
			INCOND_i: in std_logic;
			COND_i: in std_logic;
			ZERO_i: in std_logic;
			RESET_i: in std_logic
			);
end PC;

			
architecture arq_PC of PC is
	signal sum32_s: std_logic_vector(anchodataout-1 downto 0);
	signal Do_s: std_logic_vector(anchodataout-1 downto 0):="0000000000";
	signal mux: std_logic;
	signal aux: std_logic_vector((2*N)-1 downto 0);
	signal Dext_s: std_logic_vector((2*N)-1 downto 0);
	signal Sumext_s: std_logic_vector((2*N)-1 downto 0);
	CONSTANT cuatro : unsigned(anchodataout-1 downto 0) := "0000000100";
	CONSTANT carry_i: std_logic := '0';
	signal carry_o: std_logic;
	


begin
     


Dext_s <=std_logic_vector(shift_left(unsigned(IMGEN_i),1));
--
aux <= std_logic_vector(to_unsigned(0,2*N-anchodataout)) & Do_s; 
--
Sumext_s <= std_logic_vector(unsigned((signed(Dext_s) + signed(aux))));



	
main: process (CLOCK_i,mux,Do_s,RESET_i,ZERO_i,COND_i,INCOND_i)
	begin 
	mux <= INCOND_i OR (ZERO_i AND COND_i);
	
	if (RESET_i='0') then 
	 Do_s <= (others => '0');
	elsif (CLOCK_i'event and CLOCK_i='1') then
	  case mux is
	    when '0' => 
	      Do_s <= std_logic_vector(unsigned(Do_s) + cuatro) ;
	    
		 when others =>
	      Do_s <= Sumext_s(anchodataout-1 downto 0);
	  end case;
	end if;  
	   D_o <= std_logic_vector(Do_s);
 end process;
 

end arq_PC;  
	 
		
