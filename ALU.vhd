library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( crs1 : in  STD_LOGIC_VECTOR(31 downto 0);
           salida_MUX : in  STD_LOGIC_VECTOR(31 downto 0);
           ALU_op : in  STD_LOGIC_VECTOR(5 downto 0);
           ALU_Result : out  STD_LOGIC_VECTOR(31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin
	process (crs1,salida_MUX,ALU_op)
	begin
		case (ALU_OP) is
			when "000000" => -- add
				Alu_Result <= crs1 + salida_MUX;
			when "000001" => -- sub
				Alu_Result <= crs1 - salida_MUX;
			when "000010" => --or
				Alu_Result <= crs1 or salida_MUX;
			when "000011" => --and
				Alu_Result <= crs1 and salida_MUX;
			when "000100" => --xor
				Alu_Result <= crs1 xor salida_MUX;
			when "000101" => -- orn
				Alu_Result <= not(crs1 or salida_MUX);
			when "000110" => --andn
				Alu_Result <= not(crs1 and salida_MUX);
			when "000111" => --xnor
				Alu_Result <= crs1 xnor salida_MUX;
			when others => -- Nop
				Alu_Result <= (others=>'0');
		end case;
	end process;
		

end Behavioral;

