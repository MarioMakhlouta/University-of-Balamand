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
-- Generated on "03/24/2024 13:18:34"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          ALUBitByBit
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY ALUBitByBit_vhd_vec_tst IS
END ALUBitByBit_vhd_vec_tst;
ARCHITECTURE ALUBitByBit_arch OF ALUBitByBit_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL a : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL AddSub : STD_LOGIC;
SIGNAL b : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Cout : STD_LOGIC;
SIGNAL S : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL su : STD_LOGIC;
SIGNAL V : STD_LOGIC;
SIGNAL y : STD_LOGIC_VECTOR(3 DOWNTO 0);
COMPONENT ALUBitByBit
	PORT (
	a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	AddSub : IN STD_LOGIC;
	b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	Cout : OUT STD_LOGIC;
	S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	su : IN STD_LOGIC;
	V : OUT STD_LOGIC;
	y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : ALUBitByBit
	PORT MAP (
-- list connections between master ports and signals
	a => a,
	AddSub => AddSub,
	b => b,
	Cout => Cout,
	S => S,
	su => su,
	V => V,
	y => y
	);
-- a[3]
t_prcs_a_3: PROCESS
BEGIN
	a(3) <= '0';
	WAIT FOR 160000 ps;
	a(3) <= '1';
	WAIT FOR 160000 ps;
	a(3) <= '0';
WAIT;
END PROCESS t_prcs_a_3;
-- a[2]
t_prcs_a_2: PROCESS
BEGIN
	a(2) <= '0';
	WAIT FOR 10000 ps;
	a(2) <= '1';
	WAIT FOR 150000 ps;
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
	WAIT FOR 150000 ps;
	b(3) <= '0';
WAIT;
END PROCESS t_prcs_b_3;
-- b[2]
t_prcs_b_2: PROCESS
BEGIN
	b(2) <= '0';
	WAIT FOR 160000 ps;
	b(2) <= '1';
	WAIT FOR 160000 ps;
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
	WAIT FOR 160000 ps;
	b(0) <= '1';
	WAIT FOR 160000 ps;
	b(0) <= '0';
WAIT;
END PROCESS t_prcs_b_0;
-- S[1]
t_prcs_S_1: PROCESS
BEGIN
	S(1) <= '0';
	WAIT FOR 10000 ps;
	S(1) <= '1';
	WAIT FOR 310000 ps;
	S(1) <= '0';
WAIT;
END PROCESS t_prcs_S_1;
-- S[0]
t_prcs_S_0: PROCESS
BEGIN
	S(0) <= '0';
	WAIT FOR 10000 ps;
	S(0) <= '1';
	WAIT FOR 310000 ps;
	S(0) <= '0';
WAIT;
END PROCESS t_prcs_S_0;

-- AddSub
t_prcs_AddSub: PROCESS
BEGIN
	AddSub <= '0';
	WAIT FOR 10000 ps;
	AddSub <= '1';
	WAIT FOR 310000 ps;
	AddSub <= '0';
WAIT;
END PROCESS t_prcs_AddSub;

-- su
t_prcs_su: PROCESS
BEGIN
	su <= '0';
	WAIT FOR 10000 ps;
	su <= '1';
	WAIT FOR 310000 ps;
	su <= '0';
WAIT;
END PROCESS t_prcs_su;
END ALUBitByBit_arch;
