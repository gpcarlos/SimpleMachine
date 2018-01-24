--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:07:48 01/24/2018
-- Design Name:   
-- Module Name:   C:/Xilinx/Proyectos/Py_SimpleMachine/ControlUnit_MS_tb.vhd
-- Project Name:  Py_SimpleMachine
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ControlUnit_MS
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ControlUnit_MS_tb IS
END ControlUnit_MS_tb;
 
ARCHITECTURE behavior OF ControlUnit_MS_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ControlUnit_MS
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         COP : IN  std_logic_vector(1 downto 0);
         Push : IN  std_logic;
         FlagZero : IN  std_logic;
         CW : OUT  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal COP : std_logic_vector(1 downto 0) := (others => '0');
   signal Push : std_logic := '0';
   signal FlagZero : std_logic := '0';

 	--Outputs
   signal CW : std_logic_vector(9 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ControlUnit_MS PORT MAP (
          Clk => Clk,
          Reset => Reset,
          COP => COP,
          Push => Push,
          FlagZero => FlagZero,
          CW => CW
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
			
		Reset <= '1'; wait for 40 ns;
		-- hold reset state for 40 ns.
		Reset <= '0'; wait for 40 ns;

		--------------------------------
		-- MovB Instruction COP=00
		--------------------------------
		
		COP <= "00"; wait for 20 ns;
		
		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;
		
		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;


		--------------------------------
		-- AaddB Instruction COP=10
		--------------------------------

		COP <= "10"; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;


		--------------------------------
		-- CMPAB Instruction COP=11
		--------------------------------

		COP <= "11"; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		--------------------------------
		-- Beq Instruction COP=01 FZ=1
		--------------------------------		
		
		COP <= "01"; wait for 20 ns;
		FlagZero <= '1'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

		--------------------------------
		-- COP=01 FZ=0
		--------------------------------		

		COP <= "01"; wait for 20 ns;
		FlagZero <= '0'; wait for 20 ns;

		Push <= '1'; wait for 20 ns;
		Push <= '0'; wait for 20 ns;

      wait;
   end process;

END;
