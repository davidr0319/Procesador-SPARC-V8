library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RF is
	Port( reset  : in  STD_LOGIC;
			rs1  : in  STD_LOGIC_VECTOR (4  downto 0);
			rs2  : in  STD_LOGIC_VECTOR (4  downto 0);
			rd   : in  STD_LOGIC_VECTOR (4  downto 0);
			data_to_write : in  STD_LOGIC_VECTOR (31 downto 0);
			crs1 : out STD_LOGIC_VECTOR (31 downto 0);
			crs2 : out STD_LOGIC_VECTOR (31 downto 0)
			);
			
end RF;

architecture Behavorial of RF is

	type ram_type is array (0 to 31) of std_logic_vector (31 downto 0);
	signal reg : ram_type := (others => x"00000000");
	
begin
	
	process(reset, rs1, rs2, rd, reg, data_to_write)
	begin
		if (reset = '1') then
			crs1 <= (others => '0');
			crs2 <= (others => '0');
			reg <= (others => x"00000000");
		elsif (rd /= "00000") then
			reg(conv_integer(rd)) <= data_to_write;
		end if;
		crs1 <= reg(conv_integer(rs1));
		crs2 <= reg(conv_integer(rs2));
	end process;

end Behavorial;
