library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SEU is
    Port ( imm13 : in  STD_LOGIC_VECTOR(12 downto 0);
           imm32 : out  STD_LOGIC_VECTOR(31 downto 0));
end SEU;

architecture Behavioral of SEU is

begin

	process(imm13)
		begin
				if(imm13(12) = '1')then
					imm32(12 downto 0) <= imm13;
					imm32(31 downto 13) <= (others=>'1');
				else
					imm32(12 downto 0) <= imm13;
					imm32(31 downto 13) <= (others=>'0');
				end if;
		end process;

end Behavioral;

