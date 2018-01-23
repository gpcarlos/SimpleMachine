----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:38:36 01/23/2018 
-- Design Name: 
-- Module Name:    Memo_Datapath - Structural 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Memo_Datapath is
    Port ( Clk, Reset : in  STD_LOGIC;
	        CW0, CW1, CW2, CW3 : in STD_LOGIC;
			  Address : in STD_LOGIC_VECTOR(2 downto 0);
			  SelALU : in STD_LOGIC_VECTOR(1 downto 0);
			  SalREGA : out STD_LOGIC_VECTOR(7 downto 0);
			  SalREGB : out STD_LOGIC_VECTOR(7 downto 0);
			  SalALU : out STD_LOGIC_VECTOR(7 downto 0);
			  SalFZ : out STD_LOGIC;
			  DataBus : out STD_LOGIC_VECTOR(7 downto 0));
end Memo_Datapath;

architecture Structural of Memo_Datapath is

	COMPONENT Datapath
   GENERIC (nBits : integer);
	PORT(
		Clk : IN std_logic;
		Reset : IN std_logic;
		DataBus : IN std_logic_vector(nBits-1 downto 0);
		SelALU : IN std_logic_vector(1 downto 0);
		CW0 : IN std_logic;
		CW1 : IN std_logic;
		CW2 : IN std_logic;          
		SalREGA : OUT std_logic_vector(nBits-1 downto 0);
		SalREGB : OUT std_logic_vector(nBits-1 downto 0);
		SalALU : OUT std_logic_vector(nBits-1 downto 0);
		SalFZ : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT Memo_8x8
	PORT(
		Clk : IN std_logic;
		CW3 : IN std_logic;
		Address : IN std_logic_vector(2 downto 0);
		DataIn : IN std_logic_vector(7 downto 0);          
		DataOut : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	signal signal_DataBus : STD_LOGIC_VECTOR (7 downto 0);
	signal signal_SalALU : STD_LOGIC_VECTOR (7 downto 0);

begin

	Inst_Datapath: Datapath 
	GENERIC MAP(nBits => 8)
	PORT MAP(
		Clk => Clk,
		Reset => Reset,
		DataBus => signal_DataBus,
		SelALU => SelALU,
		CW0 => CW0,
		CW1 => CW1,
		CW2 => CW2,
		SalREGA => SalREGA,
		SalREGB => SalREGB,
		SalALU => signal_SalALU,
		SalFZ => SalFZ
	);

	Inst_Memo_8x8: Memo_8x8 PORT MAP(
		Clk => Clk,
		CW3 => CW3,
		Address => Address,
		DataIn => signal_SalALU,
		DataOut => signal_DataBus
	);
	
	SalALU <= signal_SalALU;
	DataBus <= signal_DataBus;
	
end Structural;

