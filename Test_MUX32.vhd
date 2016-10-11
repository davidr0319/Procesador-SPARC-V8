
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Test_MUX32 IS
END Test_MUX32;
 
ARCHITECTURE behavior OF Test_MUX32 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX32
    PORT(
         crs2 : IN  std_logic_vector(31 downto 0);
         salida_SEU : IN  std_logic_vector(31 downto 0);
         i : IN  std_logic;
         salida_MUX : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal crs2 : std_logic_vector(31 downto 0) := (others => '0');
   signal salida_SEU : std_logic_vector(31 downto 0) := (others => '0');
   signal i : std_logic := '0';

 	--Outputs
   signal salida_MUX : std_logic_vector(31 downto 0);
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX32 PORT MAP (
          crs2 => crs2,
          salida_SEU => salida_SEU,
          i => i,
          salida_MUX => salida_MUX
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      crs2 <= x"00000100";
		salida_SEU <= x"0000010";
		i <= '0';
      wait for 50 ns;

		crs2 <= x"0000000E";
		salida_SEU <= x"0000000C";
		i <= '1';
      wait for 50 ns;
		
		crs2 <= x"00000000";
		salida_SEU <= x"00000011";
		i <= '1';
      wait for 50 ns;
		
		crs2 <= x"00000001";
		salida_SEU <= x"0000001C";
		i <= '0';
      wait for 50 ns;

      wait;
   end process;

END;
