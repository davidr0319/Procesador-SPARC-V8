--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:59:01 10/11/2016
-- Design Name:   
-- Module Name:   C:/Users/David Ramirez/Desktop/UTP/SEMESTRE16-2/ARQUITECTURA DE COMPUTADORES/SPARC v8/PROCESADOR MONOCICLO/PROCESADOR_MONOCICLO/Test_SEU.vhd
-- Project Name:  PROCESADOR_MONOCICLO
-- Target Device:  

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Test_SEU IS
END Test_SEU;
 
ARCHITECTURE behavior OF Test_SEU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SEU
    PORT(
         imm13 : IN  std_logic_vector(12 downto 0);
         imm32 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal imm13 : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal imm32 : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SEU PORT MAP (
          imm13 => imm13,
          imm32 => imm32
        );

   -- Stimulus process
   stim_proc: process
   begin		
      imm13 <= "0101100010101";
      wait for 50 ns;	
		
		imm13 <= "1100101010100";
      wait for 50 ns;	
		
		imm13 <= "0101000000000";
      wait for 50 ns;	
		
      wait;
   end process;

END;
