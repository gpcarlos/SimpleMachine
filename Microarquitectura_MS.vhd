----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:06:46 01/23/2018 
-- Design Name: 
-- Module Name:    Microarquitectura_MS - Structural 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Microarquitectura_MS is
    Port ( Clk, Reset : in  STD_LOGIC;
           CW0, CW1, CW2, CW3, CW4, CW7 : in  STD_LOGIC;
			  SelMPX : in STD_LOGIC_VECTOR(1 downto 0);
			  SelALU : in STD_LOGIC_VECTOR(1 downto 0);
			  SalREGA : out STD_LOGIC_VECTOR(7 downto 0);
			  SalREGB : out STD_LOGIC_VECTOR(7 downto 0);
			  SalFZ : out STD_LOGIC;
			  SalRI : out STD_LOGIC_VECTOR(7 downto 0);
			  AddressBus : out STD_LOGIC_VECTOR(2 downto 0);
			  COP : out STD_LOGIC_VECTOR(1 downto 0));
end Microarquitectura_MS;

architecture Structural of Microarquitectura_MS is

	COMPONENT Memo_Datapath
	PORT(
		Clk : IN std_logic;
		Reset : IN std_logic;
		CW0 : IN std_logic;
		CW1 : IN std_logic;
		CW2 : IN std_logic;
		CW3 : IN std_logic;
		Address : IN std_logic_vector(2 downto 0);
		SelALU : IN std_logic_vector(1 downto 0);          
		SalREGA : OUT std_logic_vector(7 downto 0);
		SalREGB : OUT std_logic_vector(7 downto 0);
		SalALU : OUT std_logic_vector(7 downto 0);
		SalFZ : OUT std_logic;
		DataBus : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	constant ZERO : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
	signal signal_SalRI : STD_LOGIC_VECTOR (7 downto 0);
	signal signal_DataBus : STD_LOGIC_VECTOR (7 downto 0);
	signal signal_MPX_RAM : STD_LOGIC_VECTOR (2 downto 0);
	signal signal_PC_MPX : STD_LOGIC_VECTOR (1 downto 0);
	signal signal_counter : STD_LOGIC_VECTOR (1 downto 0);
	signal signal_COP : STD_LOGIC_VECTOR (1 downto 0);

begin

	Inst_Memo_Datapath: Memo_Datapath PORT MAP(
		Clk => Clk,
		Reset => Reset,
		CW0 => CW0,
		CW1 => CW1,
		CW2 => CW2,
		CW3 => CW3,
		Address => signal_MPX_RAM,
		SelALU => SelALU,
		SalREGA => SalREGA,
		SalREGB => SalREGB,
		SalALU => open,
		SalFZ => SalFZ,
		DataBus => signal_DataBus
	);

	RI: process (Clk, Reset)
	begin
		if (Reset = '1') then
			signal_SalRI <= ZERO;
		elsif rising_edge(Clk) then
			if (CW4='1') then
				signal_SalRI <= signal_DataBus;
			end if;		
		end if;
	end process;	
	
	PC: process (Clk, Reset)
	begin
		if (Reset = '1') then
			signal_PC_MPX <= "00";
		elsif rising_edge(Clk) then
			if (CW7='1') then
				signal_PC_MPX <= signal_counter;
			end if;		
		end if;
	end process;	
	
	signal_counter <= std_logic_vector(unsigned(signal_MPX_RAM(1 downto 0))+1);
	
	SalRI <= signal_SalRI;
	signal_COP <= signal_SalRI(7 downto 6);
	with SelMPX select signal_MPX_RAM <=
		'1'&signal_PC_MPX when "00",
		signal_SalRI(5 downto 3) when "10",
		signal_SalRI(2 downto 0) when "11",
		"000" when others;
		
	AddressBus <= signal_MPX_RAM;
	COP <= signal_COP;

end Structural;

