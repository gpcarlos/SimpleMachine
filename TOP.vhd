----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:31:16 01/23/2018 
-- Design Name: 
-- Module Name:    TOP - Structural 
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

entity TOP is
    Port ( Clk, Reset : in  STD_LOGIC;
			  Push : in STD_LOGIC;
			  SalRI : out STD_LOGIC_VECTOR(7 downto 0);
			  SalFZ : out STD_LOGIC;
			  AddressBus : out STD_LOGIC_VECTOR(2 downto 0);
           Anode : out  STD_LOGIC_VECTOR (3 downto 0);
           Cathode : out  STD_LOGIC_VECTOR (6 downto 0));			  
end TOP;

architecture Structural of TOP is

	COMPONENT SimpleMachine
	PORT(
		Clk : IN std_logic;
		Reset : IN std_logic;
		Push : IN std_logic;          
		SalREGA : OUT std_logic_vector(7 downto 0);
		SalREGB : OUT std_logic_vector(7 downto 0);
		SalFZ : OUT std_logic;
		SalRI : OUT std_logic_vector(7 downto 0);
		AddressBus : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	COMPONENT Display7Seg_4ON
	PORT(
		Disp1 : IN std_logic_vector(3 downto 0);
		Disp2 : IN std_logic_vector(3 downto 0);
		Disp3 : IN std_logic_vector(3 downto 0);
		Disp4 : IN std_logic_vector(3 downto 0);
		Clk : IN std_logic;
		Reset : IN std_logic;          
		Anode : OUT std_logic_vector(3 downto 0);
		Cathode : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;
	
	signal signal_SalREGA : STD_LOGIC_VECTOR(7 downto 0);
	signal signal_SalREGB : STD_LOGIC_VECTOR(7 downto 0);

begin

	Inst_SimpleMachine: SimpleMachine PORT MAP(
		Clk => Clk,
		Reset => Reset,
		Push => Push,
		SalREGA => signal_SalREGA,
		SalREGB => signal_SalREGB,
		SalFZ => SalFZ,
		SalRI => SalRI,
		AddressBus => AddressBus
	);
	
	Inst_Display7Seg_4ON: Display7Seg_4ON PORT MAP(
		Disp1 => signal_SalREGA(7 downto 4),
		Disp2 => signal_SalREGA(3 downto 0),
		Disp3 => signal_SalREGB(7 downto 4),
		Disp4 => signal_SalREGB(3 downto 0),
		Clk => Clk,
		Reset => Reset,
		Anode => Anode,
		Cathode => Cathode
	);
	
end Structural;

