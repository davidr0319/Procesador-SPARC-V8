--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   04:45:49 10/11/2016
-- Design Name:   
-- Module Name:   C:/Users/David Ramirez/Desktop/UTP/SEMESTRE16-2/ARQUITECTURA DE COMPUTADORES/SPARC v8/PROCESADOR MONOCICLO/PROCESADOR_MONOCICLO/Test_SUM_32BITS.vhd
-- Project Name:  PROCESADOR_MONOCICLO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SUM_32BITS
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Test_SUM_32BITS IS
END Test_SUM_32BITS;
 
ARCHITECTURE behavior OF Test_SUM_32BITS IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SUM_32BITS
    PORT(
         entrada_1 : IN  std_logic_vector(31 downto 0);
         entrada_2 : IN  std_logic_vector(31 downto 0);
         resultado : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal entrada_1 : std_logic_vector(31 downto 0) := (others => '0');
   signal entrada_2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal resultado : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SUM_32BITS PORT MAP (
          entrada_1 => entrada_1,
          entrada_2 => entrada_2,
          resultado => resultado
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		entrada_1 <= x"00000001";
      wait for 100 ns;	
		entrada_2 <= x"00000002";
      wait for 20 ns;	
		entrada_2 <= x"00000003";
      wait for 20 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
