library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PSR_Modifier is
	Port( crs1 : in std_logic;
	      operando2 : in std_logic;
			ALU_Result : in STD_LOGIC_VECTOR(31 downto 0);
			ALU_OP : in std_logic_vector(5 downto 0);
			nzvc : out std_logic_vector(3 downto 0)
	);
end PSR_Modifier;

architecture Behavorial of PSR_Modifier is

begin

process(crs1, operando2, ALU_Result, ALU_OP)
begin

	-- ADDcc y ADDxcc
	if (ALU_OP = "001000" or ALU_OP = "01011") then
		nzvc(3) <= ALU_Result(31);
		
		if (ALU_Result = x"00000000") then nzvc(2) <= '1'; else nzvc(2) <= '0'; end if;
		
		nzvc(1) <= (crs1 and operando2 and (not ALU_Result(31))) or ((not crs1) and (not operando2) and ALU_Result(31));
		
		nzvc(0) <= (crs1 and operando2) or ((not ALU_Result(31)) and (crs1 or operando2));
		
	-- SUBcc y SUBxcc
	else 
		if (ALU_OP = "001001" or ALU_OP = "001101")then
			nzvc(3) <= ALU_Result(31);
			
			if (ALU_Result = x"00000000") then 
				nzvc(2) <= '1'; 
			else 
				nzvc(2) <= '0'; 
			end if;
			
			nzvc(1) <= (crs1 and (not operando2) and (not ALU_Result(31))) or ((not crs1) and operando2 and ALU_Result(31));
			
			nzvc(0) <= ((not crs1) and operando2) or (ALU_Result(31) and ((not crs1) or operando2));
			
		--ANDcc, ANDNcc, ORcc, ORNcc, XORcc, XNORcc
		else
			if (ALU_OP = "001111" or ALU_OP = "010001" or ALU_OP = "001110" or ALU_OP = "010010" or ALU_OP = "010000" or ALU_OP = "010011")then
				nzvc(3) <= ALU_Result(31);
				
				if (ALU_Result = x"00000000") then 
					nzvc(2) <= '1'; 
				else 
					nzvc(2) <= '0'; 
				end if;
				
				nzvc(1) <= '0';
				
				nzvc(0) <= '1';
			end if;
		end if;
	end if;
	
end process;


end Behavorial;