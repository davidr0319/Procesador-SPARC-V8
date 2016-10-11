--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   04:23:11 10/11/2016
-- Design Name:   
-- Module Name:   C:/Users/David Ramirez/Desktop/UTP/SEMESTRE16-2/ARQUITECTURA DE COMPUTADORES/SPARC v8/PROCESADOR MONOCICLO/PROCESADOR_MONOCICLO/Test_PC.vhd
-- Project Name:  PROCESADOR_MONOCICLO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PC
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
 
ENTITY Test_PC IS
END Test_PC;
 
ARCHITECTURE behavior OF Test_PC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PC
    PORT(
         in_data : IN  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         out_data : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in_data : std_logic_vector(31 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal out_data : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PC PORT MAP (
          in_data => in_data,
          clk => clk,
          reset => reset,
          out_data => out_data
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <= '1';
      wait for 100 ns;	
		in_data <= x"00000000"; 
      reset <= '0'; 
		wait for 20 ns;
		in_data <= x"00000001";
		wait for 20 ns;
		in_data <= x"00000002";
		wait for 20 ns;
		in_data <= x"00000003";
      wait;
   end process;

END;
