library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU is
    Port ( op : in  STD_LOGIC_VECTOR(1 downto 0);
           op3 : in  STD_LOGIC_VECTOR(5 downto 0);
           ALU_op : out  STD_LOGIC_VECTOR(5 downto 0));
end CU;

architecture Behavioral of CU is

begin
	process (op,op3)
	begin
	
		if(op = "10") then
		
			case (op3) is
			
				when "000000" => ALU_op <= "000000";--add
				when "000100" => ALU_op <= "000001";--sub
				when "000010" => ALU_op <= "000010";--or
				when "000001" => ALU_op <= "000011";--and
				when "000011" => ALU_op <= "000100";--xor
				when "000110" => ALU_op <= "000101";--nor
				when "000101" => ALU_op <= "000110";--nand
				when "000111" => ALU_op <= "000111";--xnor
				when "010000" => ALU_op <= "001000";--addcc
				when "010100" => ALU_op <= "001001";--subcc
				when "001000" => ALU_op <= "001010";--addx
				when "011000" => ALU_op <= "001011";--addxcc
				when "001100" => ALU_op <= "001100";--subx
				when "011100" => ALU_op <= "001101";--subxcc
				when "010010" => ALU_op <= "001110";--orcc
				when "010001" => ALU_op <= "001111";--andcc
				when "010011" => ALU_op <= "010000";--xorcc
				when "010101" => ALU_op <= "010001";--nandcc
				when "010110" => ALU_op <= "010010";--norcc
				when "010111" => ALU_op <= "010011";--xnorcc
				when "100101" => ALU_op <= "010100";--SLL
				when "100110" => ALU_op <= "010101";--SRL
				
				when others =>  ALU_OP <= "000000";--nop
			
			end case;
		
		else ALU_op <= "000000";
		
		end if;
		
	end process;

end Behavioral;

