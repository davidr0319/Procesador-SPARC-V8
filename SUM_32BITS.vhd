----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SUM_32BITS is
    Port ( entrada_1 : in  STD_LOGIC_VECTOR(31 downto 0);
           entrada_2 : in  STD_LOGIC_VECTOR(31 downto 0);
           resultado : out  STD_LOGIC_VECTOR(31 downto 0));
end SUM_32BITS;

architecture Behavioral of SUM_32BITS is

begin

		process(entrada_1,entrada_2)
			begin
				resultado <= entrada_1 + entrada_2;
			end process;

end Behavioral;

