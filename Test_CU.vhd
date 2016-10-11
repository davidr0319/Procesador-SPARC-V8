
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Test_CU IS
END Test_CU;
 
ARCHITECTURE behavior OF Test_CU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CU
    PORT(
         op : IN  std_logic_vector(1 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         ALU_op : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal ALU_op : std_logic_vector(5 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CU PORT MAP (
          op => op,
          op3 => op3,
          ALU_op => ALU_op
        );
		  
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
		op <= "10";
		op3 <= "000111";
      wait for 50 ns;	
		
		op <= "10";
		op3 <= "000100";
      wait for 50 ns;	
		
		op <= "11";
		op3 <= "000010";
      wait for 50 ns;	
		
		op <= "10";
		op3 <= "000011";
      wait for 50 ns;	
      wait;
   end process;

END;
