LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Test_ALU IS
END Test_ALU;
 
ARCHITECTURE behavior OF Test_ALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         crs1 : IN  std_logic_vector(31 downto 0);
         salida_MUX : IN  std_logic_vector(31 downto 0);
         ALU_op : IN  std_logic_vector(5 downto 0);
         ALU_Result : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal crs1 : std_logic_vector(31 downto 0) := (others => '0');
   signal salida_MUX : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_op : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal ALU_Result : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          crs1 => crs1,
          salida_MUX => salida_MUX,
          ALU_op => ALU_op,
          ALU_Result => ALU_Result
        );



   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		crs1 <= x"00000000";
      salida_MUX <= x"00000002";
      ALU_op <= "000000";
      wait for 50 ns;	
		
		crs1 <= x"00100000";
      salida_MUX <= x"00000100";
      ALU_op <= "000001";
      wait for 50 ns;
		
		crs1 <= x"00000000";
      salida_MUX <= x"10000100";
      ALU_op <= "000010";
      wait for 50 ns;
		
		crs1 <= x"01000000";
      salida_MUX <= x"10000101";
      ALU_op <= "000011";
      wait for 50 ns;
		
      wait;
   end process;

END;
