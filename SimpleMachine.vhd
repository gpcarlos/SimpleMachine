----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:31:17 01/24/2018 
-- Design Name: 
-- Module Name:    SimpleMachine - Structural 
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

entity SimpleMachine is
    Port ( Clk, Reset : in  STD_LOGIC;
	        Push : in STD_LOGIC;
			  SalREGA : out STD_LOGIC_VECTOR(7 downto 0);
			  SalREGB : out STD_LOGIC_VECTOR(7 downto 0);
			  SalFZ : out STD_LOGIC;
			  SalRI : out STD_LOGIC_VECTOR(7 downto 0);
			  AddressBus : out STD_LOGIC_VECTOR(2 downto 0));
end SimpleMachine;

architecture Structural of SimpleMachine is

	COMPONENT RisingEdge
	PORT(
		Reset : IN std_logic;
		Push : IN std_logic;
		Clk : IN std_logic;          
		Pulse : OUT std_logic
		);
	END COMPONENT;

	COMPONENT ControlUnit_MS
	PORT(
		Clk : IN std_logic;
		Reset : IN std_logic;
		COP : IN std_logic_vector(1 downto 0);
		Push : IN std_logic;
		FlagZero : IN std_logic;          
		CW : OUT std_logic_vector(9 downto 0)
		);
	END COMPONENT;

	COMPONENT Microarquitectura_MS
	PORT(
		Clk : IN std_logic;
		Reset : IN std_logic;
		CW0 : IN std_logic;
		CW1 : IN std_logic;
		CW2 : IN std_logic;
		CW3 : IN std_logic;
		CW4 : IN std_logic;
		CW7 : IN std_logic;
		SelMPX : IN std_logic_vector(1 downto 0);
		SelALU : IN std_logic_vector(1 downto 0);		
		SalREGA : OUT std_logic_vector(7 downto 0);
		SalREGB : OUT std_logic_vector(7 downto 0);
		SalFZ : OUT std_logic;
		SalRI : OUT std_logic_vector(7 downto 0);
		AddressBus : OUT std_logic_vector(2 downto 0);
		COP : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;

	signal signal_CW : std_logic_vector(9 downto 0);
	signal signal_FZ : std_logic;
	signal signal_COP : std_logic_vector(1 downto 0);
	signal signal_Push : std_logic;
	signal signal_CW0 : std_logic;
	signal signal_CW1 : std_logic;
	signal signal_CW2 : std_logic;
	signal signal_CW4 : std_logic;
	signal signal_CW7 : std_logic;
	
begin

	Inst_RisingEdge: RisingEdge PORT MAP(
		Reset => Reset,
		Push => Push,
		Clk => Clk,
		Pulse => signal_Push
	);

	Inst_ControlUnit_MS: ControlUnit_MS PORT MAP(
		Clk => Clk,
		Reset => Reset,
		COP => signal_COP,
		Push => signal_Push,
		FlagZero => signal_FZ,
		CW => signal_CW
	);
	
	signal_CW0 <= signal_CW(0) and signal_Push;
	signal_CW1 <= signal_CW(1) and signal_Push;
	signal_CW2 <= signal_CW(2) and signal_Push;
	signal_CW4 <= signal_CW(4) and signal_Push;
	signal_CW7 <= signal_CW(7) and signal_Push;

	Inst_Microarquitectura_MS: Microarquitectura_MS PORT MAP(
		Clk => Clk,
		Reset => Reset,
		CW0 => signal_CW0,
		CW1 => signal_CW1,
		CW2 => signal_CW2,
		CW3 => signal_CW(3),
		CW4 => signal_CW4,
		CW7 => signal_CW7,
		SelMPX => signal_CW(6 downto 5),
		SelALU => signal_CW(9 downto 8),
		SalREGA => SalREGA,
		SalREGB => SalREGB,
		SalFZ => signal_FZ,
		SalRI => SalRI,
		AddressBus => AddressBus,
		COP => signal_COP
	);

	SalFZ <= signal_FZ;
	
end Structural;

