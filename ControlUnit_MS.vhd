----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:14:24 01/23/2018 
-- Design Name: 
-- Module Name:    ControlUnit_MS - Behavioral 
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

entity ControlUnit_MS is
    Port ( Clk, Reset : in  STD_LOGIC;
           COP : in  STD_LOGIC_VECTOR (1 downto 0);
           Push : in  STD_LOGIC;
           FlagZero : in  STD_LOGIC;
           CW : out  STD_LOGIC_VECTOR (9 downto 0));
end ControlUnit_MS;

architecture Behavioral of ControlUnit_MS is

	------------------------------------------------------
	-- DEFINITION of STATES
	------------------------------------------------------
	type States_FSM is (Idle,LoadInst,Deco,LoadA,LoadB,Beq,MovB,AaddB,CMPAB);
	signal Next_State: States_FSM;
	------------------------------------------------------
	-- DEFINITION of the OUTPUTS for each STATE
	------------------------------------------------------   CW = 9876543210
	constant Outputs_Idle : std_logic_vector (9 downto 0)     := "0000000000";
	constant Outputs_LoadInst : std_logic_vector (9 downto 0) := "0010010000"; 
	constant Outputs_Deco : std_logic_vector (9 downto 0)     := "0000000000"; 
	constant Outputs_LoadB : std_logic_vector (9 downto 0)    := "0001100010";
	constant Outputs_LoadA : std_logic_vector (9 downto 0)    := "0001000001";
	constant Outputs_Beq : std_logic_vector (9 downto 0)      := "0111010000";
	constant Outputs_MovB : std_logic_vector (9 downto 0)     := "0001001100"; 
	constant Outputs_AaddB : std_logic_vector (9 downto 0)    := "1001001100"; 
	constant Outputs_CMPAB : std_logic_vector (9 downto 0)    := "1101000100"; 

begin

	process (Clk,Reset)
	begin
		if (Reset='1') then 
			Next_State <= Idle;
		elsif rising_edge (CLK) then 
			case (Next_State) is
			---------------------
			-- State "Idle"
			---------------------
				when Idle =>
					if (Push = '1') then 
						Next_State <= LoadInst;
					end if;
			---------------------
			-- State "LoadInst"
			---------------------
				when LoadInst =>
					if (Push = '1') then
						Next_State <= Deco;
					end if;
			---------------------
			-- State "Deco"
			---------------------
				when Deco =>
					if (Push = '1') then
						case (COP) is
							when "00" | "10" | "11" =>
								Next_State <= LoadB;
							when "01" =>
								if (FlagZero = '1') then
									Next_State <= Beq;
								else
									Next_State <= LoadInst;
								end if;
							when others => Next_State <= Idle;
						end case;
					end if;
			---------------------
			-- State "Beq"
			---------------------
				when Beq =>
					if (Push = '1') then
						Next_State <= Deco;
					end if;
			---------------------
			-- State "LoadB"
			---------------------
				when LoadB =>
					if (Push = '1') then
						case (COP) is
							when "00" =>
								Next_State <= MovB;
							when "10" | "11" =>
								Next_State <= LoadA;
							when others => Next_State <= Idle;
						end case;
					end if;
			---------------------
			-- State "MovB"
			---------------------
				when MovB =>
					if (Push = '1') then
						Next_State <= LoadInst;
					end if;
			---------------------
			-- State "LoadB"
			---------------------
				when LoadA =>
					if (Push = '1') then
						case (COP) is
							when "11" =>
								Next_State <= CMPAB;
							when "10" =>
								Next_State <= AaddB;
							when others => Next_State <= Idle;
						end case;					
					end if;
			---------------------
			-- State "AaddB"
			---------------------
				when AaddB =>
					if (Push = '1') then
						Next_State <= LoadInst;
					end if;
			---------------------
			-- State "CMPAB"
			---------------------
				when CMPAB =>
					if (Push = '1') then
						Next_State <= LoadInst;
					end if;
			---------------------
				when others =>
					Next_State <= Idle;
			end case;
		end if;
	end process;
	
	with Next_State select
		CW <= Outputs_Idle		when Idle,
				Outputs_LoadInst  when LoadInst,
				Outputs_Deco  		when Deco,
				Outputs_LoadA  	when LoadA,
				Outputs_LoadB  	when LoadB,
				Outputs_CMPAB 		when CMPAB,
				Outputs_AaddB 		when AaddB,
				Outputs_MovB		when MovB,
				Outputs_Beq			when Beq,
				Outputs_Idle		when others;
end Behavioral;