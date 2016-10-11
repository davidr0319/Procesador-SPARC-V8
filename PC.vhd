----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PC is
    Port ( in_data : in  STD_LOGIC_VECTOR(31 downto 0);
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           out_data : out  STD_LOGIC_VECTOR(31 downto 0));
end PC;

architecture Behavioral of PC is

begin
		process(clk)
			begin
				if(rising_edge(clk))then
					if(reset = '1')then
						out_data <= (others=>'0');
					else
						out_data <= in_data;
					end if;
				end if;
			end process;

end Behavioral;

