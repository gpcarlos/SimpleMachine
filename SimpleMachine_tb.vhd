--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:25:59 01/24/2018
-- Design Name:   
-- Module Name:   C:/Xilinx/Proyectos/Py_SimpleMachine/SimpleMachine_tb.vhd
-- Project Name:  Py_SimpleMachine
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SimpleMachine
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
 
ENTITY SimpleMachine_tb IS
END SimpleMachine_tb;
 
ARCHITECTURE behavior OF SimpleMachine_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SimpleMachine
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Push : IN  std_logic;
         SalREGA : OUT  std_logic_vector(7 downto 0);
         SalREGB : OUT  std_logic_vector(7 downto 0);
         SalFZ : OUT  std_logic;
         SalRI : OUT  std_logic_vector(7 downto 0);
         AddressBus : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Push : std_logic := '0';

 	--Outputs
   signal SalREGA : std_logic_vector(7 downto 0);
   signal SalREGB : std_logic_vector(7 downto 0);
   signal SalFZ : std_logic;
   signal SalRI : std_logic_vector(7 downto 0);
   signal AddressBus : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SimpleMachine PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Push => Push,
          SalREGA => SalREGA,
          SalREGB => SalREGB,
          SalFZ => SalFZ,
          SalRI => SalRI,
          AddressBus => AddressBus
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
		
		for I in 1 to 100 loop
			Push <= '1'; wait for 30 ns;	
			Push <= '0'; wait for 30 ns;
		end loop;

      wait;
   end process;

END;
