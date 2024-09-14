-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "03/24/2024 13:38:28"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          FinalSchematic
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY FinalSchematic_vhd_vec_tst IS
END FinalSchematic_vhd_vec_tst;
ARCHITECTURE FinalSchematic_arch OF FinalSchematic_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL a : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL b : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL C : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL Cout : STD_LOGIC;
SIGNAL V : STD_LOGIC;
SIGNAL y : STD_LOGIC_VECTOR(3 DOWNTO 0);
COMPONENT FinalSchematic
	PORT (
	a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	C : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	Cout : OUT STD_LOGIC;
	V : OUT STD_LOGIC;
	y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : FinalSchematic
	PORT MAP (
-- list connections between master ports and signals
	a => a,
	b => b,
	C => C,
	Cout => Cout,
	V => V,
	y => y
	);
-- a[3]
t_prcs_a_3: PROCESS
BEGIN
	a(3) <= '0';
WAIT;
END PROCESS t_prcs_a_3;
-- a[2]
t_prcs_a_2: PROCESS
BEGIN
	a(2) <= '0';
	WAIT FOR 10000 ps;
	a(2) <= '1';
	WAIT FOR 310000 ps;
	a(2) <= '0';
WAIT;
END PROCESS t_prcs_a_2;
-- a[1]
t_prcs_a_1: PROCESS
BEGIN
	a(1) <= '0';
WAIT;
END PROCESS t_prcs_a_1;
-- a[0]
t_prcs_a_0: PROCESS
BEGIN
	a(0) <= '0';
	WAIT FOR 10000 ps;
	a(0) <= '1';
	WAIT FOR 310000 ps;
	a(0) <= '0';
WAIT;
END PROCESS t_prcs_a_0;
-- b[3]
t_prcs_b_3: PROCESS
BEGIN
	b(3) <= '0';
	WAIT FOR 10000 ps;
	b(3) <= '1';
	WAIT FOR 310000 ps;
	b(3) <= '0';
WAIT;
END PROCESS t_prcs_b_3;
-- b[2]
t_prcs_b_2: PROCESS
BEGIN
	b(2) <= '0';
	WAIT FOR 10000 ps;
	b(2) <= '1';
	WAIT FOR 310000 ps;
	b(2) <= '0';
WAIT;
END PROCESS t_prcs_b_2;
-- b[1]
t_prcs_b_1: PROCESS
BEGIN
	b(1) <= '0';
WAIT;
END PROCESS t_prcs_b_1;
-- b[0]
t_prcs_b_0: PROCESS
BEGIN
	b(0) <= '0';
WAIT;
END PROCESS t_prcs_b_0;
-- C[2]
t_prcs_C_2: PROCESS
BEGIN
	C(2) <= '0';
WAIT;
END PROCESS t_prcs_C_2;
-- C[1]
t_prcs_C_1: PROCESS
BEGIN
	C(1) <= '0';
WAIT;
END PROCESS t_prcs_C_1;
-- C[0]
t_prcs_C_0: PROCESS
BEGIN
	C(0) <= '0';
	WAIT FOR 170000 ps;
	C(0) <= '1';
	WAIT FOR 150000 ps;
	C(0) <= '0';
WAIT;
END PROCESS t_prcs_C_0;
END FinalSchematic_arch;
