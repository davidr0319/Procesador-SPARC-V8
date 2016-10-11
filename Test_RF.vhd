--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   05:55:24 10/11/2016
-- Design Name:   
-- Module Name:   C:/Users/David Ramirez/Desktop/UTP/SEMESTRE16-2/ARQUITECTURA DE COMPUTADORES/SPARC v8/PROCESADOR MONOCICLO/PROCESADOR_MONOCICLO/Test_RF.vhd
-- Project Name:  PROCESADOR_MONOCICLO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF
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
 
ENTITY Test_RF IS
END Test_RF;
 
ARCHITECTURE behavior OF Test_RF IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         reset : IN  std_logic;
         rs1 : IN  std_logic_vector(4 downto 0);
         rs2 : IN  std_logic_vector(4 downto 0);
         rd : IN  std_logic_vector(4 downto 0);
         data_to_write : IN  std_logic_vector(31 downto 0);
         crs1 : OUT  std_logic_vector(31 downto 0);
         crs2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal rs1 : std_logic_vector(4 downto 0) := (others => '0');
   signal rs2 : std_logic_vector(4 downto 0) := (others => '0');
   signal rd : std_logic_vector(4 downto 0) := (others => '0');
   signal data_to_write : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal crs1 : std_logic_vector(31 downto 0);
   signal crs2 : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          reset => reset,
          rs1 => rs1,
          rs2 => rs2,
          rd => rd,
          data_to_write => data_to_write,
          crs1 => crs1,
          crs2 => crs2
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '0';
      rs1 <= "00000";
      rs2 <= "00001";
      rd <= "10101";
      data_to_write <= x"0000000C";
      wait for 50 ns;	
      rd <= "00010";
      data_to_write <= x"0000000A";
      wait for 50 ns;
      rs1 <= "01000";
      rs2 <= "10100";
      rd <= "00000";
      data_to_write <= x"00000003";
      wait for 50 ns;
		reset <= '1';


      wait;
   end process;

END;
