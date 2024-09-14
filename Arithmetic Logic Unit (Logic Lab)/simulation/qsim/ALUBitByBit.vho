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

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

-- DATE "03/24/2024 13:38:30"

-- 
-- Device: Altera 5CSEMA5F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	FinalSchematic IS
    PORT (
	Cout : OUT std_logic;
	C : IN std_logic_vector(2 DOWNTO 0);
	a : IN std_logic_vector(3 DOWNTO 0);
	b : IN std_logic_vector(3 DOWNTO 0);
	V : OUT std_logic;
	y : OUT std_logic_vector(3 DOWNTO 0)
	);
END FinalSchematic;

ARCHITECTURE structure OF FinalSchematic IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_Cout : std_logic;
SIGNAL ww_C : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_a : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_b : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_V : std_logic;
SIGNAL ww_y : std_logic_vector(3 DOWNTO 0);
SIGNAL \Cout~output_o\ : std_logic;
SIGNAL \V~output_o\ : std_logic;
SIGNAL \y[3]~output_o\ : std_logic;
SIGNAL \y[2]~output_o\ : std_logic;
SIGNAL \y[1]~output_o\ : std_logic;
SIGNAL \y[0]~output_o\ : std_logic;
SIGNAL \a[3]~input_o\ : std_logic;
SIGNAL \C[2]~input_o\ : std_logic;
SIGNAL \b[3]~input_o\ : std_logic;
SIGNAL \a[2]~input_o\ : std_logic;
SIGNAL \b[2]~input_o\ : std_logic;
SIGNAL \a[1]~input_o\ : std_logic;
SIGNAL \b[1]~input_o\ : std_logic;
SIGNAL \a[0]~input_o\ : std_logic;
SIGNAL \b[0]~input_o\ : std_logic;
SIGNAL \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ : std_logic;
SIGNAL \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ : std_logic;
SIGNAL \inst8589|inst26|LPM_MUX_component|auto_generated|l1_w2_n0_mux_dataout~0_combout\ : std_logic;
SIGNAL \inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ : std_logic;
SIGNAL \C[0]~input_o\ : std_logic;
SIGNAL \inst8589|inst18|LPM_MUX_component|auto_generated|l1_w0_n0_mux_dataout~0_combout\ : std_logic;
SIGNAL \C[1]~input_o\ : std_logic;
SIGNAL \inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\ : std_logic;
SIGNAL \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~1_combout\ : std_logic;
SIGNAL \inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~1_combout\ : std_logic;
SIGNAL \inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~2_combout\ : std_logic;
SIGNAL \inst8589|inst2|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\ : std_logic;
SIGNAL \inst8589|inst4|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ : std_logic;
SIGNAL \inst8589|inst1|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\ : std_logic;
SIGNAL \inst8589|inst23|LPM_MUX_component|auto_generated|l1_w0_n0_mux_dataout~0_combout\ : std_logic;
SIGNAL \inst8589|inst|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\ : std_logic;
SIGNAL \inst8589|inst23|LPM_MUX_component|auto_generated|ALT_INV_l1_w0_n0_mux_dataout~0_combout\ : std_logic;
SIGNAL \inst8589|inst3|LPM_MUX_component|auto_generated|ALT_INV_l2_w0_n0_mux_dataout~1_combout\ : std_logic;
SIGNAL \inst8589|inst4|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\ : std_logic;
SIGNAL \inst8589|inst3|LPM_MUX_component|auto_generated|ALT_INV_l2_w0_n0_mux_dataout~0_combout\ : std_logic;
SIGNAL \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~1_combout\ : std_logic;
SIGNAL \inst8589|inst18|LPM_MUX_component|auto_generated|ALT_INV_l1_w0_n0_mux_dataout~0_combout\ : std_logic;
SIGNAL \inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\ : std_logic;
SIGNAL \inst8589|inst26|LPM_MUX_component|auto_generated|ALT_INV_l1_w2_n0_mux_dataout~0_combout\ : std_logic;
SIGNAL \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\ : std_logic;
SIGNAL \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\ : std_logic;
SIGNAL \ALT_INV_a[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_C[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_b[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_a[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_C[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_C[1]~input_o\ : std_logic;

BEGIN

Cout <= ww_Cout;
ww_C <= C;
ww_a <= a;
ww_b <= b;
V <= ww_V;
y <= ww_y;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\inst8589|inst23|LPM_MUX_component|auto_generated|ALT_INV_l1_w0_n0_mux_dataout~0_combout\ <= NOT \inst8589|inst23|LPM_MUX_component|auto_generated|l1_w0_n0_mux_dataout~0_combout\;
\inst8589|inst3|LPM_MUX_component|auto_generated|ALT_INV_l2_w0_n0_mux_dataout~1_combout\ <= NOT \inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~1_combout\;
\inst8589|inst4|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\ <= NOT \inst8589|inst4|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\;
\inst8589|inst3|LPM_MUX_component|auto_generated|ALT_INV_l2_w0_n0_mux_dataout~0_combout\ <= NOT \inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\;
\inst8589|inst655|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~1_combout\ <= NOT \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~1_combout\;
\inst8589|inst18|LPM_MUX_component|auto_generated|ALT_INV_l1_w0_n0_mux_dataout~0_combout\ <= NOT \inst8589|inst18|LPM_MUX_component|auto_generated|l1_w0_n0_mux_dataout~0_combout\;
\inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\ <= NOT \inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\;
\inst8589|inst26|LPM_MUX_component|auto_generated|ALT_INV_l1_w2_n0_mux_dataout~0_combout\ <= NOT \inst8589|inst26|LPM_MUX_component|auto_generated|l1_w2_n0_mux_dataout~0_combout\;
\inst8589|inst655|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\ <= NOT \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\;
\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\ <= NOT \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\;
\ALT_INV_a[3]~input_o\ <= NOT \a[3]~input_o\;
\ALT_INV_C[2]~input_o\ <= NOT \C[2]~input_o\;
\ALT_INV_b[3]~input_o\ <= NOT \b[3]~input_o\;
\ALT_INV_b[2]~input_o\ <= NOT \b[2]~input_o\;
\ALT_INV_a[2]~input_o\ <= NOT \a[2]~input_o\;
\ALT_INV_a[1]~input_o\ <= NOT \a[1]~input_o\;
\ALT_INV_b[1]~input_o\ <= NOT \b[1]~input_o\;
\ALT_INV_b[0]~input_o\ <= NOT \b[0]~input_o\;
\ALT_INV_a[0]~input_o\ <= NOT \a[0]~input_o\;
\ALT_INV_C[0]~input_o\ <= NOT \C[0]~input_o\;
\ALT_INV_C[1]~input_o\ <= NOT \C[1]~input_o\;

\Cout~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\,
	devoe => ww_devoe,
	o => \Cout~output_o\);

\V~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst8589|inst18|LPM_MUX_component|auto_generated|ALT_INV_l1_w0_n0_mux_dataout~0_combout\,
	devoe => ww_devoe,
	o => \V~output_o\);

\y[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~2_combout\,
	devoe => ww_devoe,
	o => \y[3]~output_o\);

\y[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst8589|inst2|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\,
	devoe => ww_devoe,
	o => \y[2]~output_o\);

\y[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst8589|inst1|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\,
	devoe => ww_devoe,
	o => \y[1]~output_o\);

\y[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst8589|inst|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\,
	devoe => ww_devoe,
	o => \y[0]~output_o\);

\a[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(3),
	o => \a[3]~input_o\);

\C[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_C(2),
	o => \C[2]~input_o\);

\b[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(3),
	o => \b[3]~input_o\);

\a[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(2),
	o => \a[2]~input_o\);

\b[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(2),
	o => \b[2]~input_o\);

\a[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(1),
	o => \a[1]~input_o\);

\b[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(1),
	o => \b[1]~input_o\);

\a[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(0),
	o => \a[0]~input_o\);

\b[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(0),
	o => \b[0]~input_o\);

\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ = ( \b[0]~input_o\ & ( (!\a[1]~input_o\ & (\a[0]~input_o\ & (!\C[2]~input_o\ $ (!\b[1]~input_o\)))) # (\a[1]~input_o\ & ((!\C[2]~input_o\ $ (!\b[1]~input_o\)) # (\a[0]~input_o\))) ) ) 
-- # ( !\b[0]~input_o\ & ( (!\b[1]~input_o\ & (\C[2]~input_o\)) # (\b[1]~input_o\ & ((\a[1]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011000100100111101101010011010100110001001001111011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_C[2]~input_o\,
	datab => \ALT_INV_a[1]~input_o\,
	datac => \ALT_INV_b[1]~input_o\,
	datad => \ALT_INV_a[0]~input_o\,
	datae => \ALT_INV_b[0]~input_o\,
	combout => \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\);

\inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ = ( \b[2]~input_o\ & ( \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ & ( (!\b[3]~input_o\ & (!\a[3]~input_o\ & ((!\C[2]~input_o\) # (!\a[2]~input_o\)))) # 
-- (\b[3]~input_o\ & (\C[2]~input_o\ & ((!\a[3]~input_o\) # (!\a[2]~input_o\)))) ) ) ) # ( !\b[2]~input_o\ & ( \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ & ( (!\b[3]~input_o\ & (!\C[2]~input_o\ & ((!\a[3]~input_o\) # 
-- (!\a[2]~input_o\)))) # (\b[3]~input_o\ & (!\a[3]~input_o\ & ((!\a[2]~input_o\) # (\C[2]~input_o\)))) ) ) ) # ( \b[2]~input_o\ & ( !\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ & ( (!\b[3]~input_o\ & ((!\a[3]~input_o\) # 
-- ((!\C[2]~input_o\ & !\a[2]~input_o\)))) # (\b[3]~input_o\ & (((!\a[3]~input_o\ & !\a[2]~input_o\)) # (\C[2]~input_o\))) ) ) ) # ( !\b[2]~input_o\ & ( !\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ & ( (!\b[3]~input_o\ & 
-- ((!\C[2]~input_o\) # ((!\a[3]~input_o\ & !\a[2]~input_o\)))) # (\b[3]~input_o\ & ((!\a[3]~input_o\) # ((\C[2]~input_o\ & !\a[2]~input_o\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1110101111001010111010111010001111001010100000101010001110000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_a[3]~input_o\,
	datab => \ALT_INV_C[2]~input_o\,
	datac => \ALT_INV_b[3]~input_o\,
	datad => \ALT_INV_a[2]~input_o\,
	datae => \ALT_INV_b[2]~input_o\,
	dataf => \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\,
	combout => \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\);

\inst8589|inst26|LPM_MUX_component|auto_generated|l1_w2_n0_mux_dataout~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst8589|inst26|LPM_MUX_component|auto_generated|l1_w2_n0_mux_dataout~0_combout\ = !\C[2]~input_o\ $ (!\b[2]~input_o\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0110011001100110011001100110011001100110011001100110011001100110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_C[2]~input_o\,
	datab => \ALT_INV_b[2]~input_o\,
	combout => \inst8589|inst26|LPM_MUX_component|auto_generated|l1_w2_n0_mux_dataout~0_combout\);

\inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|op_1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ = (!\a[2]~input_o\ & (\inst8589|inst26|LPM_MUX_component|auto_generated|l1_w2_n0_mux_dataout~0_combout\ & \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\)) # 
-- (\a[2]~input_o\ & ((\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\) # (\inst8589|inst26|LPM_MUX_component|auto_generated|l1_w2_n0_mux_dataout~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001011100010111000101110001011100010111000101110001011100010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_a[2]~input_o\,
	datab => \inst8589|inst26|LPM_MUX_component|auto_generated|ALT_INV_l1_w2_n0_mux_dataout~0_combout\,
	datac => \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\,
	combout => \inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\);

\C[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_C(0),
	o => \C[0]~input_o\);

\inst8589|inst18|LPM_MUX_component|auto_generated|l1_w0_n0_mux_dataout~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst8589|inst18|LPM_MUX_component|auto_generated|l1_w0_n0_mux_dataout~0_combout\ = !\inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ $ (((!\C[0]~input_o\ & (!\C[2]~input_o\)) # (\C[0]~input_o\ & 
-- ((!\inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101101000111100010110100011110001011010001111000101101000111100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_C[2]~input_o\,
	datab => \inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\,
	datac => \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\,
	datad => \ALT_INV_C[0]~input_o\,
	combout => \inst8589|inst18|LPM_MUX_component|auto_generated|l1_w0_n0_mux_dataout~0_combout\);

\C[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_C(1),
	o => \C[1]~input_o\);

\inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\ = !\C[2]~input_o\ $ (!\C[1]~input_o\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101101001011010010110100101101001011010010110100101101001011010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_C[2]~input_o\,
	datac => \ALT_INV_C[1]~input_o\,
	combout => \inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\);

\inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~1_combout\ = !\a[3]~input_o\ $ (!\C[2]~input_o\ $ (\b[3]~input_o\))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0110100101101001011010010110100101101001011010010110100101101001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_a[3]~input_o\,
	datab => \ALT_INV_C[2]~input_o\,
	datac => \ALT_INV_b[3]~input_o\,
	combout => \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~1_combout\);

\inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~1_combout\ = ( !\C[1]~input_o\ & ( (!\C[2]~input_o\ & ((!\a[3]~input_o\ & (\b[3]~input_o\ & \C[0]~input_o\)) # (\a[3]~input_o\ & ((\C[0]~input_o\) # (\b[3]~input_o\))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000010001001100000000000000000000000100010011000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_a[3]~input_o\,
	datab => \ALT_INV_C[2]~input_o\,
	datac => \ALT_INV_b[3]~input_o\,
	datad => \ALT_INV_C[0]~input_o\,
	datae => \ALT_INV_C[1]~input_o\,
	combout => \inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~1_combout\);

\inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~2_combout\ = ( \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~1_combout\ & ( \inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~1_combout\ ) ) # ( 
-- !\inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~1_combout\ & ( \inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~1_combout\ ) ) # ( \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~1_combout\ & ( 
-- !\inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~1_combout\ & ( (\inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\ & ((!\a[2]~input_o\ & 
-- ((!\inst8589|inst26|LPM_MUX_component|auto_generated|l1_w2_n0_mux_dataout~0_combout\) # (!\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\))) # (\a[2]~input_o\ & 
-- (!\inst8589|inst26|LPM_MUX_component|auto_generated|l1_w2_n0_mux_dataout~0_combout\ & !\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\)))) ) ) ) # ( !\inst8589|inst655|LPM_ADD_SUB_component|auto_generated|op_1~1_combout\ & ( 
-- !\inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~1_combout\ & ( (\inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\ & ((!\a[2]~input_o\ & 
-- (\inst8589|inst26|LPM_MUX_component|auto_generated|l1_w2_n0_mux_dataout~0_combout\ & \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\)) # (\a[2]~input_o\ & ((\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\) # 
-- (\inst8589|inst26|LPM_MUX_component|auto_generated|l1_w2_n0_mux_dataout~0_combout\))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000010111000000001110100011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_a[2]~input_o\,
	datab => \inst8589|inst26|LPM_MUX_component|auto_generated|ALT_INV_l1_w2_n0_mux_dataout~0_combout\,
	datac => \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\,
	datad => \inst8589|inst3|LPM_MUX_component|auto_generated|ALT_INV_l2_w0_n0_mux_dataout~0_combout\,
	datae => \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~1_combout\,
	dataf => \inst8589|inst3|LPM_MUX_component|auto_generated|ALT_INV_l2_w0_n0_mux_dataout~1_combout\,
	combout => \inst8589|inst3|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~2_combout\);

\inst8589|inst2|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst8589|inst2|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\ = ( \C[0]~input_o\ & ( \C[1]~input_o\ & ( (!\C[2]~input_o\ & (!\a[2]~input_o\ $ (!\b[2]~input_o\ $ (\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\)))) 
-- ) ) ) # ( !\C[0]~input_o\ & ( \C[1]~input_o\ & ( (!\C[2]~input_o\ & (!\a[2]~input_o\ $ (!\b[2]~input_o\ $ (\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\)))) ) ) ) # ( \C[0]~input_o\ & ( !\C[1]~input_o\ & ( (!\C[2]~input_o\ & 
-- (((\b[2]~input_o\)) # (\a[2]~input_o\))) # (\C[2]~input_o\ & (!\a[2]~input_o\ $ (!\b[2]~input_o\ $ (!\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\)))) ) ) ) # ( !\C[0]~input_o\ & ( !\C[1]~input_o\ & ( (!\C[2]~input_o\ & 
-- (\a[2]~input_o\ & (\b[2]~input_o\))) # (\C[2]~input_o\ & (!\a[2]~input_o\ $ (!\b[2]~input_o\ $ (!\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100001100010110011010110011111000101000100000100010100010000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_C[2]~input_o\,
	datab => \ALT_INV_a[2]~input_o\,
	datac => \ALT_INV_b[2]~input_o\,
	datad => \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\,
	datae => \ALT_INV_C[0]~input_o\,
	dataf => \ALT_INV_C[1]~input_o\,
	combout => \inst8589|inst2|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\);

\inst8589|inst4|LPM_ADD_SUB_component|auto_generated|op_1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst8589|inst4|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ = (!\b[0]~input_o\ & (\C[2]~input_o\)) # (\b[0]~input_o\ & ((\a[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101001101010011010100110101001101010011010100110101001101010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_C[2]~input_o\,
	datab => \ALT_INV_a[0]~input_o\,
	datac => \ALT_INV_b[0]~input_o\,
	combout => \inst8589|inst4|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\);

\inst8589|inst1|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst8589|inst1|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\ = ( \C[0]~input_o\ & ( \C[1]~input_o\ & ( (!\C[2]~input_o\ & (!\a[1]~input_o\ $ (!\b[1]~input_o\ $ (\inst8589|inst4|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\)))) ) 
-- ) ) # ( !\C[0]~input_o\ & ( \C[1]~input_o\ & ( (!\C[2]~input_o\ & (!\a[1]~input_o\ $ (!\b[1]~input_o\ $ (\inst8589|inst4|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\)))) ) ) ) # ( \C[0]~input_o\ & ( !\C[1]~input_o\ & ( (!\C[2]~input_o\ & 
-- (((\b[1]~input_o\)) # (\a[1]~input_o\))) # (\C[2]~input_o\ & (!\a[1]~input_o\ $ (!\b[1]~input_o\ $ (!\inst8589|inst4|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\)))) ) ) ) # ( !\C[0]~input_o\ & ( !\C[1]~input_o\ & ( (!\C[2]~input_o\ & 
-- (\a[1]~input_o\ & (\b[1]~input_o\))) # (\C[2]~input_o\ & (!\a[1]~input_o\ $ (!\b[1]~input_o\ $ (!\inst8589|inst4|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100001100010110011010110011111000101000100000100010100010000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_C[2]~input_o\,
	datab => \ALT_INV_a[1]~input_o\,
	datac => \ALT_INV_b[1]~input_o\,
	datad => \inst8589|inst4|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\,
	datae => \ALT_INV_C[0]~input_o\,
	dataf => \ALT_INV_C[1]~input_o\,
	combout => \inst8589|inst1|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\);

\inst8589|inst23|LPM_MUX_component|auto_generated|l1_w0_n0_mux_dataout~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst8589|inst23|LPM_MUX_component|auto_generated|l1_w0_n0_mux_dataout~0_combout\ = ( \C[0]~input_o\ & ( (!\a[3]~input_o\ & (!\inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ & (!\C[2]~input_o\ $ (!\b[3]~input_o\)))) # 
-- (\a[3]~input_o\ & ((!\inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\) # (!\C[2]~input_o\ $ (!\b[3]~input_o\)))) ) ) # ( !\C[0]~input_o\ & ( (!\a[3]~input_o\ & 
-- ((!\inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\) # (!\C[2]~input_o\ $ (\b[3]~input_o\)))) # (\a[3]~input_o\ & (!\inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|op_1~0_combout\ & (!\C[2]~input_o\ $ (\b[3]~input_o\)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1110101110000010011111010001010011101011100000100111110100010100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_a[3]~input_o\,
	datab => \ALT_INV_C[2]~input_o\,
	datac => \ALT_INV_b[3]~input_o\,
	datad => \inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|ALT_INV_op_1~0_combout\,
	datae => \ALT_INV_C[0]~input_o\,
	combout => \inst8589|inst23|LPM_MUX_component|auto_generated|l1_w0_n0_mux_dataout~0_combout\);

\inst8589|inst|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst8589|inst|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\ = ( \a[0]~input_o\ & ( \inst8589|inst23|LPM_MUX_component|auto_generated|l1_w0_n0_mux_dataout~0_combout\ & ( (!\b[0]~input_o\ & (((\C[0]~input_o\) # (\C[2]~input_o\)) # 
-- (\C[1]~input_o\))) # (\b[0]~input_o\ & (!\C[1]~input_o\ $ ((\C[2]~input_o\)))) ) ) ) # ( !\a[0]~input_o\ & ( \inst8589|inst23|LPM_MUX_component|auto_generated|l1_w0_n0_mux_dataout~0_combout\ & ( (!\C[1]~input_o\ & (\b[0]~input_o\ & ((\C[0]~input_o\) # 
-- (\C[2]~input_o\)))) # (\C[1]~input_o\ & (((\b[0]~input_o\)) # (\C[2]~input_o\))) ) ) ) # ( \a[0]~input_o\ & ( !\inst8589|inst23|LPM_MUX_component|auto_generated|l1_w0_n0_mux_dataout~0_combout\ & ( (!\C[1]~input_o\ & ((!\C[2]~input_o\ & ((\b[0]~input_o\) # 
-- (\C[0]~input_o\))) # (\C[2]~input_o\ & ((!\b[0]~input_o\))))) # (\C[1]~input_o\ & (!\C[2]~input_o\ & ((!\b[0]~input_o\)))) ) ) ) # ( !\a[0]~input_o\ & ( !\inst8589|inst23|LPM_MUX_component|auto_generated|l1_w0_n0_mux_dataout~0_combout\ & ( (\b[0]~input_o\ 
-- & ((!\C[1]~input_o\ & ((\C[0]~input_o\) # (\C[2]~input_o\))) # (\C[1]~input_o\ & (!\C[2]~input_o\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000001101110011011101000100000010001011111110111111110011001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_C[1]~input_o\,
	datab => \ALT_INV_C[2]~input_o\,
	datac => \ALT_INV_C[0]~input_o\,
	datad => \ALT_INV_b[0]~input_o\,
	datae => \ALT_INV_a[0]~input_o\,
	dataf => \inst8589|inst23|LPM_MUX_component|auto_generated|ALT_INV_l1_w0_n0_mux_dataout~0_combout\,
	combout => \inst8589|inst|LPM_MUX_component|auto_generated|l2_w0_n0_mux_dataout~0_combout\);

ww_Cout <= \Cout~output_o\;

ww_V <= \V~output_o\;

ww_y(3) <= \y[3]~output_o\;

ww_y(2) <= \y[2]~output_o\;

ww_y(1) <= \y[1]~output_o\;

ww_y(0) <= \y[0]~output_o\;
END structure;


