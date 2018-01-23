----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:25:08 01/07/2018 
-- Design Name: 
-- Module Name:    Counter_Nbits - Behavioral 
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

entity Counter_Nbits is
	 GENERIC (nBits: integer := 2);
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Enable : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (nBits-1 downto 0));
end Counter_Nbits;

architecture Behavioral of Counter_Nbits is

	signal Count: unsigned (nBits-1 downto 0);
	constant ZERO : STD_LOGIC_VECTOR (nBits-1 downto 0) := (others => '0');

begin

	process(Clk, Reset)
	begin
		if (Reset='1') then
			Count <= unsigned(ZERO);
		elsif rising_edge(Clk) then
			if (Enable='1') then 
				Count <= Count + 1;
			end if;
		end if;
	end process;

	Q <= std_logic_Vector(Count);
	
end Behavioral;



