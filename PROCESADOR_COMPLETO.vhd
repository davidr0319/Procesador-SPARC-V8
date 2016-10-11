library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PROCESADOR_COMPLETO is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           salida : out  STD_LOGIC_VECTOR(31 downto 0));
end PROCESADOR_COMPLETO;

architecture Behavioral of PROCESADOR_COMPLETO is

COMPONENT PC

	PORT(
		in_data : IN std_logic_vector(31 downto 0);
		clk : IN std_logic;
		reset : IN std_logic;          
		out_data : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT ALU
	PORT(
		crs1 : IN std_logic_vector(31 downto 0);
		salida_MUX : IN std_logic_vector(31 downto 0);
		ALU_op : IN std_logic_vector(5 downto 0);          
		ALU_Result : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT CU
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		ALU_op : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

COMPONENT MUX32
	PORT(
		crs2 : IN std_logic_vector(31 downto 0);
		salida_SEU : IN std_logic_vector(31 downto 0);
		i : IN std_logic;          
		salida_MUX : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT RF
	PORT(
		reset : IN std_logic;
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		data_to_write : IN std_logic_vector(31 downto 0);          
		crs1 : OUT std_logic_vector(31 downto 0);
		crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT SEU
	PORT(
		imm13 : IN std_logic_vector(12 downto 0);          
		imm32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT SUM_32BITS
	PORT(
		entrada_1 : IN std_logic_vector(31 downto 0);
		entrada_2 : IN std_logic_vector(31 downto 0);          
		resultado : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

signal salida_nPC, salida_SUM32, salida_PC, salida_IM, salida_RF1, salida_RF2 : STD_LOGIC_VECTOR(31 downto 0);
signal salida_SEU, salida_ALU, salida_MUX : STD_LOGIC_VECTOR(31 downto 0);
signal salida_CU : STD_LOGIC_VECTOR(5 downto 0);

begin

Inst_PC: PC PORT MAP(
		in_data => salida_nPC,
		clk => clk,
		reset => reset,
		out_data => salida_PC
	);

Inst_nPC: PC PORT MAP(
		in_data => salida_SUM32,
		clk => clk,
		reset => reset,
		out_data => salida_nPC
	);

Inst_SUM_32BITS: SUM_32BITS PORT MAP(
		entrada_1 => x"00000001",
		entrada_2 => salida_nPC,
		resultado => salida_SUM32
	);

Inst_instructionMemory: instructionMemory PORT MAP(
		address => salida_PC,
		reset => reset,
		outInstruction => salida_IM
	);

Inst_RF: RF PORT MAP(
		reset => reset,
		rs1 => salida_IM(18 downto 14),
		rs2 => salida_IM(4 downto 0),
		rd => salida_IM(29 downto 25),
		data_to_write => salida_ALU,
		crs1 => salida_RF1,
		crs2 => salida_RF2
	);

Inst_CU: CU PORT MAP(
		op => salida_IM(31 downto 30),
		op3 => salida_IM(24 downto 19),
		ALU_op => salida_CU
	);

Inst_SEU: SEU PORT MAP(
		imm13 => salida_IM(12 downto 0),
		imm32 => salida_SEU
	);

Inst_MUX32: MUX32 PORT MAP(
		crs2 => salida_RF2,
		salida_SEU => salida_SEU,
		i => salida_IM(13),
		salida_MUX => salida_MUX
	);


Inst_ALU: ALU PORT MAP(
		crs1 => salida_RF1,
		salida_MUX => salida_MUX,
		ALU_op => salida_CU,
		ALU_Result => salida_ALU
	);

salida <= salida_ALU;

end Behavioral;

