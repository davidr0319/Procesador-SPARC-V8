library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX32 is
    Port ( crs2 : in  STD_LOGIC_VECTOR(31 downto 0);
           salida_SEU : in  STD_LOGIC_VECTOR(31 downto 0);
           i : in  STD_LOGIC;
           salida_MUX : out  STD_LOGIC_VECTOR(31 downto 0));
end MUX32;

architecture Behavioral of MUX32 is

begin

	process(crs2,salida_SEU,i)
	begin
		if(i = '1')then
			salida_MUX <= salida_SEU;
		else
				salida_MUX <= crs2;
		end if;
	end process;

end Behavioral;

