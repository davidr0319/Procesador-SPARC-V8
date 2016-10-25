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
		carry : IN std_logic;          
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
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0);
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

COMPONENT WM
	PORT(
		cwp : IN std_logic;
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		Nrs1 : OUT std_logic_vector(5 downto 0);
		Nrs2 : OUT std_logic_vector(5 downto 0);
		Nrd : OUT std_logic_vector(5 downto 0);
		Ncwp : OUT std_logic
		);
	END COMPONENT;

COMPONENT PSR
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		nzvc : IN std_logic_vector(3 downto 0);
		Ncwp : IN std_logic;          
		Carry : OUT std_logic;
		cwp : OUT std_logic
		);
	END COMPONENT;
	
COMPONENT PSR_Modifier
	PORT(
		crs1 : IN std_logic;
		operando2 : IN std_logic;
		ALU_Result : IN std_logic_vector(31 downto 0);
		ALU_OP : IN std_logic_vector(5 downto 0);          
		nzvc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

signal salida_nPC, salida_SUM32, salida_PC, salida_IM, salida_RF1, salida_RF2 : STD_LOGIC_VECTOR(31 downto 0);
signal salida_SEU, salida_ALU, salida_MUX : STD_LOGIC_VECTOR(31 downto 0);
signal salida_CU, salida_WM1, salida_WM2, salida_WMd : STD_LOGIC_VECTOR(5 downto 0);
signal salida_WMcwp, carry_aux, salida_PSR_cwp : STD_LOGIC;
signal nzvc_aux : STD_LOGIC_VECTOR (3 downto 0);

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
		rs1 => salida_WM1,
		rs2 => salida_WM2,
		rd => salida_WMd,
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
		carry => carry_aux,
		ALU_op => salida_CU,
		ALU_Result => salida_ALU
	);
	
Inst_WM: WM PORT MAP(
		cwp => salida_PSR_cwp,
		rs1 => salida_IM(18 downto 14),
		rs2 => salida_IM(4 downto 0),
		rd => salida_IM(29 downto 25),
		op => salida_IM(31 downto 30),
		op3 => salida_IM(24 downto 19),
		Nrs1 => salida_WM1,
		Nrs2 => salida_WM2,
		Nrd => salida_WMd,
		Ncwp => salida_WMcwp
	);
	
Inst_PSR: PSR PORT MAP(
		clk => clk,
		reset => reset,
		nzvc => nzvc_aux,
		Ncwp => salida_WMcwp,
		Carry => carry_aux,
		cwp => salida_PSR_cwp
	);
	
Inst_PSR_Modifier: PSR_Modifier PORT MAP(
		crs1 => salida_RF1 (31),
		operando2 => salida_MUX (31),
		ALU_Result => salida_ALU,
		ALU_OP => salida_CU,
		nzvc => nzvc_aux
	);

salida <= salida_ALU;

end Behavioral;

