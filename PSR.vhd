library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PSR is
Port(
	clk   : in std_logic;
	reset : in std_logic;
	nzvc  : in  std_logic_vector(3 downto 0);
	Ncwp : in std_logic;
	Carry : out std_logic;
	cwp : out std_logic
);
end PSR;
architecture Behavorial of PSR is


signal PSR_Data : std_logic_vector (3 downto 0) := "0000";

begin

process(clk,nzvc,Ncwp,reset)
begin

	if (reset='1') then
		PSR_Data<= "0000";
		Carry<= '0';
		cwp <= '0';
	else	
		if (rising_edge(clk))then
			PSR_Data<= nzvc;
			Carry<=PSR_Data(0);
			cwp <= Ncwp;
		end if;
	end if;
end process;

end Behavorial;

