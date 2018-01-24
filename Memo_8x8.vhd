----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:54:34 01/23/2018 
-- Design Name: 
-- Module Name:    Memor_8x8 - Behavioral 
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

entity Memo_8x8 is
    Port ( Clk : in  STD_LOGIC;
           CW3 : in  STD_LOGIC;
           Address : in  STD_LOGIC_VECTOR (2 downto 0);
           DataIn : in  STD_LOGIC_VECTOR (7 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (7 downto 0));
end Memo_8x8;

architecture Behavioral of Memo_8x8 is

	type ram_type is array (7 downto 0) of STD_LOGIC_VECTOR (7 downto 0);
	
	signal RAM: ram_type :=
		( 1 => "00000100",
		  2 => "00001000",
		  4 => "00000001",
		  5 => "10000001",
		  6 => "11000010",
		  7 => "01101000",
		  others => "00000000");
		
begin
	
	process (Clk)
	begin
		if rising_edge(Clk) then
			if (CW3 = '1') then
				-- Write/Read synchronous operation
				RAM(to_integer(unsigned(Address))) <= DataIn;
				DataOut <= DataIn;
			else
				-- Only Read operation of the data in Address
				DataOut <= RAM(to_integer(unsigned(Address)));
			end if;
		end if;
	end process;

end Behavioral;

