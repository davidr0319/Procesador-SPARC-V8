library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( crs1 : in  STD_LOGIC_VECTOR(31 downto 0);
           salida_MUX : in  STD_LOGIC_VECTOR(31 downto 0);
           ALU_op : in  STD_LOGIC_VECTOR(5 downto 0);
			  carry : in STD_LOGIC;
           ALU_Result : out  STD_LOGIC_VECTOR(31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin
	process (crs1,salida_MUX,ALU_op,carry)
	begin
		if (ALU_op = "000000") or (ALU_op = "001000") then --add operations
			ALU_Result <=  crs1 + salida_MUX;
		elsif (ALU_op = "001010") or (ALU_op = "001011") then --addx operations
			ALU_Result <= crs1 + salida_MUX + carry;
		elsif (ALU_op = "000001") or (ALU_op = "001001") then --sub operations
			ALU_Result <=  crs1 - salida_MUX ;
		elsif (ALU_op = "001100") or (ALU_op = "001101") then --subx operations
			ALU_Result <= crs1 - salida_MUX - carry;
		elsif (ALU_op = "000010") or (ALU_op = "001110") then --or operations
			ALU_Result <=  crs1 or salida_MUX;
		elsif (ALU_op = "000011") or (ALU_op = "001111") then --and operations
			ALU_Result <=  crs1 and salida_MUX;
		elsif (ALU_op = "000101") or (ALU_op = "010010") then --nor operations
			ALU_Result <=  crs1 or not(salida_MUX);
		elsif (ALU_op = "000100") or (ALU_op = "010000") then --xor operations
			ALU_Result <=  crs1 xor salida_MUX;
		elsif (ALU_op = "000110") or (ALU_op = "010001") then --nand operations
			ALU_Result <=  crs1 and not(salida_MUX);
		elsif (ALU_op = "000111") or (ALU_op = "010011") then --xnor operations
			ALU_Result <=  crs1 xnor salida_MUX;
		elsif (ALU_op = "010100")then --SLL
			ALU_Result <= to_stdlogicvector(to_bitvector(crs1) SLL conv_integer(salida_MUX));
		elsif (ALU_op = "010101")then --SRL
			ALU_Result <= to_stdlogicvector(to_bitvector(crs1) SRL conv_integer(salida_MUX));
		else
			ALU_Result <= x"00000000";
		end if;
	end process;
		

end Behavioral;

