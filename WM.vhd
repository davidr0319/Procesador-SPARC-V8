library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.ALL;

entity WM is
    Port ( cwp : in  STD_LOGIC;
			  rs1 : in  STD_LOGIC_VECTOR(4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR(4 downto 0);
           rd : in  STD_LOGIC_VECTOR(4 downto 0);
           op : in  STD_LOGIC_VECTOR(1 downto 0);
           op3 : in  STD_LOGIC_VECTOR(5 downto 0);
           Nrs1 : out  STD_LOGIC_VECTOR(5 downto 0);
           Nrs2 : out  STD_LOGIC_VECTOR(5 downto 0);
           Nrd : out  STD_LOGIC_VECTOR(5 downto 0);
           Ncwp : out  STD_LOGIC
           );
end WM;

architecture Behavioral of WM is

signal rs1_aux,rs2_aux,rd_aux: integer range 0 to 39;
signal Ncwp_aux: std_logic;

begin

	process(cwp,rs1,rs2,rd,op,op3,Ncwp_aux)
	begin
		if(op = "10") then
			if(op3= "111100") then
			-- Save
				Ncwp_aux<= '0';
			elsif(op3="111101") then
			-- Restore
				Ncwp_aux<= '1';
			else
				Ncwp_aux<=cwp;
			end if;
		end if;
			
			if(rs1>="11000" and rs1<="11111") then--Formula registro de entrada (r[24] - r[31])
					rs1_aux <= conv_integer(rs1)-(conv_integer(cwp)*16);
			elsif(rs1>="10000" and rs1<="10111") then--Formula registro de local (r[16] - r[23])
					rs1_aux <= conv_integer(rs1)+(conv_integer(cwp)*16);
			elsif(rs1>="01000" and rs1<="01111") then--Formula registro de salida (r[8] - r[15])
					rs1_aux <= conv_integer(rs1)+ (conv_integer(cwp)*16);
			elsif(rs1>="00000" and rs1<="00111") then--Formula registro global (r[0] - r[7])
					rs1_aux <= conv_integer(rs1);
			end if;
			
			if(rs2>="11000" and rs2<="11111") then--Formula registro de entrada (r[24] - r[31])
					rs2_aux <= conv_integer(rs2)-(conv_integer(cwp)*16);
			elsif(rs2>="10000" and rs2<="10111") then--Formula registro de local (r[16] - r[23])
					rs2_aux <= conv_integer(rs2)+(conv_integer(cwp)*16);
			elsif(rs2>="01000" and rs2<="01111") then--Formula registro de salida (r[8] - r[15])
					rs2_aux <= conv_integer(rs2)+ (conv_integer(cwp)*16);
			elsif(rs2>="00000" and rs2<="00111") then--Formula registro global (r[0] - r[7])
					rs2_aux <= conv_integer(rs2);
			end if;
			
			if(rd>="11000" and rd<="11111") then--Formula registro de entrada (r[24] - r[31])
					rd_aux <= conv_integer(rd)-(conv_integer(Ncwp_aux)*16);
			elsif(rd>="10000" and rd<="10111") then--Formula registro de local (r[16] - r[23])
					rd_aux <= conv_integer(rd)+(conv_integer(Ncwp_aux)*16);
			elsif(rd>="01000" and rd<="01111") then--Formula registro de salida (r[8] - r[15])
					rd_aux <= conv_integer(rd)+ (conv_integer(Ncwp_aux)*16);
			elsif(rd>="00000" and rd<="00111") then--Formula registro global (r[0] - r[7])
					rd_aux <= conv_integer(rd);
			end if;
			
	end process;
	
	Nrs1 <= conv_std_logic_vector(rs1_aux, 6);
	Nrs2 <= conv_std_logic_vector(rs2_aux, 6);
	Nrd <= conv_std_logic_vector(rd_aux, 6);
	Ncwp <= Ncwp_aux;

end Behavioral;
