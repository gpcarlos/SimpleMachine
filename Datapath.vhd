----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:40:02 01/23/2018 
-- Design Name: 
-- Module Name:    Datapath - Behavioral 
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

entity Datapath is
	 generic (nBits : integer := 8);
    Port ( Clk, Reset : in STD_LOGIC;
			  DataBus : in  STD_LOGIC_VECTOR (nBits-1 downto 0);
           SelALU : in  STD_LOGIC_VECTOR (1 downto 0);
			  CW0, CW1, CW2 : in STD_LOGIC;
			  SalREGA, SalREGB, SalALU : out STD_LOGIC_VECTOR (nBits-1 downto 0);
			  SalFZ : out STD_LOGIC);
end Datapath;

architecture Behavioral of Datapath is

	constant ZERO : STD_LOGIC_VECTOR (nBits-1 downto 0) := (others => '0');
	signal sA, sB, sResult : unsigned (nBits-1 downto 0);

	signal signal_SalREGA : STD_LOGIC_VECTOR (nBits-1 downto 0);
	signal signal_SalREGB : STD_LOGIC_VECTOR (nBits-1 downto 0);
	signal signal_SalALU : STD_LOGIC_VECTOR (nBits-1 downto 0);
	signal signal_SalFZ : STD_LOGIC;

begin
	
	REGA: process (Clk, Reset)
	begin
		if (Reset = '1') then
			signal_SalREGA <= ZERO;
		elsif rising_edge(Clk) then
			if (CW0='1') then
				signal_SalREGA <= DataBus;
			end if;		
		end if;
	end process;
	
	REGB: process (Clk, Reset)
	begin
		if (Reset = '1') then
			signal_SalREGB <= ZERO;
		elsif rising_edge(Clk) then
			if (CW1='1') then
				signal_SalREGB <= DataBus;
			end if;		
		end if;
	end process;
	
	FZ: process (Clk, Reset)
	begin
		if (Reset = '1') then 
			SalFZ <= '0';
		elsif rising_edge(Clk) then
			if (CW2='1') then
				SalFZ <= signal_SalFZ;
			end if;		
		end if;
	end process;
	
	sA <= unsigned(signal_SalREGA);
	sB <= unsigned(signal_SalREGB);
	with (SelALU) select
		sResult <= sB when "00",		-- MovB
					  sA + sB when "10",	--	A+B
					  sA - sB when "11",	--	A-B
					  unsigned(ZERO) when others;
					  
	signal_SalALU <= STD_LOGIC_VECTOR(sResult);
	signal_SalFZ <= '1' when sResult = unsigned(ZERO) else '0';
	
	SalREGA <= signal_SalREGA;
	SalREGB <= signal_SalREGB;
	SalALU <= signal_SalALU;


end Behavioral;

