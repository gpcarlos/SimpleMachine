----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    10:27:03 11/22/2017
-- Design Name:
-- Module Name:    Display7Seg_4ON - Structural
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

entity Display7Seg_4ON is
    Port ( Disp1 : in  STD_LOGIC_VECTOR (3 downto 0);
           Disp2 : in  STD_LOGIC_VECTOR (3 downto 0);
           Disp3 : in  STD_LOGIC_VECTOR (3 downto 0);
           Disp4 : in  STD_LOGIC_VECTOR (3 downto 0);
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Anode : out  STD_LOGIC_VECTOR (3 downto 0);
           Cathode : out  STD_LOGIC_VECTOR (6 downto 0));
end Display7Seg_4ON;

architecture Structural of Display7Seg_4ON is

	COMPONENT CLK_1KHz
	PORT(
		Clk : IN std_logic;
		Reset : IN std_logic;
		Out_1KHz : OUT std_logic
		);
	END COMPONENT;

	COMPONENT Counter_Nbits
	GENERIC (nBits : integer);
	PORT(
		Clk : IN std_logic;
		Reset : IN std_logic;
		Enable : IN std_logic;
		Q : OUT std_logic_vector(nBits-1 downto 0)
		);
	END COMPONENT;

	COMPONENT Disp7Seg
	PORT(
		Hex : IN std_logic_vector(3 downto 0);
		Select_Disp : IN std_logic_vector(1 downto 0);
		Seg : OUT std_logic_vector(6 downto 0);
		Anode : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	signal sig_enable : STD_LOGIC;
	signal sig_counter : STD_LOGIC_VECTOR(1 downto 0);
	signal sig_data : STD_LOGIC_VECTOR(3 downto 0);

begin

	Inst_CLK_1KHz: CLK_1KHz PORT MAP(
		Clk => Clk,
		Reset => Reset,
		Out_1KHz => sig_enable
	);

	Inst_Counter_Nbits: Counter_Nbits
	generic map (nBits => 2)
	PORT MAP(
		Clk => Clk,
		Reset => Reset,
		Enable => sig_enable,
		Q => sig_counter
	);

	Inst_Disp7Seg: Disp7Seg PORT MAP(
		Hex => sig_data,
		Select_Disp => sig_counter,
		Seg => Cathode,
		Anode => Anode
	);

	with (sig_counter) select
		sig_data <= Disp1 when "00",
					   Disp2 when "01",
					   Disp3 when "10",
					   Disp4 when others;

end Structural;
