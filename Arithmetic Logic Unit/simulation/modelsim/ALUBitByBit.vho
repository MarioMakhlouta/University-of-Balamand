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

-- DATE "03/26/2024 11:33:10"

-- 
-- Device: Altera EP4CE115F29C7 Package FBGA780
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_ASDO_DATA1~	=>  Location: PIN_F4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_FLASH_nCE_nCSO~	=>  Location: PIN_E2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DCLK~	=>  Location: PIN_P3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DATA0~	=>  Location: PIN_N7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCEO~	=>  Location: PIN_P28,	 I/O Standard: 2.5 V,	 Current Strength: 8mA


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~padout\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~padout\ : std_logic;
SIGNAL \~ALTERA_DATA0~~padout\ : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_DATA0~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
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

-- Design Ports Information
-- Cout	=>  Location: PIN_J15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- V	=>  Location: PIN_H19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[3]	=>  Location: PIN_F21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[2]	=>  Location: PIN_E19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[1]	=>  Location: PIN_F19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[0]	=>  Location: PIN_G19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[3]	=>  Location: PIN_AB25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- C[2]	=>  Location: PIN_AA23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[3]	=>  Location: PIN_AD27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[2]	=>  Location: PIN_AC25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[2]	=>  Location: PIN_AC27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[1]	=>  Location: PIN_AB26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[1]	=>  Location: PIN_AC28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a[0]	=>  Location: PIN_AB28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- b[0]	=>  Location: PIN_AD26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- C[0]	=>  Location: PIN_AB23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- C[1]	=>  Location: PIN_AA24,	 I/O Standard: 2.5 V,	 Current Strength: Default


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
SIGNAL \b[2]~input_o\ : std_logic;
SIGNAL \a[2]~input_o\ : std_logic;
SIGNAL \b[0]~input_o\ : std_logic;
SIGNAL \a[0]~input_o\ : std_logic;
SIGNAL \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\ : std_logic;
SIGNAL \a[1]~input_o\ : std_logic;
SIGNAL \b[1]~input_o\ : std_logic;
SIGNAL \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~1_combout\ : std_logic;
SIGNAL \inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\ : std_logic;
SIGNAL \b[3]~input_o\ : std_logic;
SIGNAL \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\ : std_logic;
SIGNAL \C[0]~input_o\ : std_logic;
SIGNAL \inst8589|inst18|LPM_MUX_component|auto_generated|result_node[0]~0_combout\ : std_logic;
SIGNAL \C[1]~input_o\ : std_logic;
SIGNAL \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|sum_eqn[0]~0_combout\ : std_logic;
SIGNAL \inst4~0_combout\ : std_logic;
SIGNAL \inst155~combout\ : std_logic;
SIGNAL \inst8589|inst3|LPM_MUX_component|auto_generated|result_node[0]~0_combout\ : std_logic;
SIGNAL \inst8589|inst3|LPM_MUX_component|auto_generated|result_node[0]~1_combout\ : std_logic;
SIGNAL \inst8589|inst2|LPM_MUX_component|auto_generated|result_node[0]~3_combout\ : std_logic;
SIGNAL \inst8589|inst2|LPM_MUX_component|auto_generated|result_node[0]~2_combout\ : std_logic;
SIGNAL \inst8589|inst1|LPM_MUX_component|auto_generated|result_node[0]~3_combout\ : std_logic;
SIGNAL \inst8589|inst1|LPM_MUX_component|auto_generated|result_node[0]~2_combout\ : std_logic;
SIGNAL \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~11_combout\ : std_logic;
SIGNAL \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~8_combout\ : std_logic;
SIGNAL \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~9_combout\ : std_logic;
SIGNAL \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~10_combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

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
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: IOOBUF_X60_Y73_N23
\Cout~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\,
	devoe => ww_devoe,
	o => \Cout~output_o\);

-- Location: IOOBUF_X72_Y73_N2
\V~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst8589|inst18|LPM_MUX_component|auto_generated|result_node[0]~0_combout\,
	devoe => ww_devoe,
	o => \V~output_o\);

-- Location: IOOBUF_X107_Y73_N16
\y[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst8589|inst3|LPM_MUX_component|auto_generated|result_node[0]~1_combout\,
	devoe => ww_devoe,
	o => \y[3]~output_o\);

-- Location: IOOBUF_X94_Y73_N9
\y[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst8589|inst2|LPM_MUX_component|auto_generated|result_node[0]~2_combout\,
	devoe => ww_devoe,
	o => \y[2]~output_o\);

-- Location: IOOBUF_X94_Y73_N2
\y[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst8589|inst1|LPM_MUX_component|auto_generated|result_node[0]~2_combout\,
	devoe => ww_devoe,
	o => \y[1]~output_o\);

-- Location: IOOBUF_X69_Y73_N16
\y[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~10_combout\,
	devoe => ww_devoe,
	o => \y[0]~output_o\);

-- Location: IOIBUF_X115_Y13_N8
\a[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(3),
	o => \a[3]~input_o\);

-- Location: IOIBUF_X115_Y10_N8
\C[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_C(2),
	o => \C[2]~input_o\);

-- Location: IOIBUF_X115_Y4_N22
\b[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(2),
	o => \b[2]~input_o\);

-- Location: IOIBUF_X115_Y15_N8
\a[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(2),
	o => \a[2]~input_o\);

-- Location: IOIBUF_X115_Y10_N1
\b[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(0),
	o => \b[0]~input_o\);

-- Location: IOIBUF_X115_Y17_N1
\a[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(0),
	o => \a[0]~input_o\);

-- Location: LCCOMB_X114_Y14_N24
\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\ = (\b[0]~input_o\ & (\C[2]~input_o\ $ (\a[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \C[2]~input_o\,
	datac => \b[0]~input_o\,
	datad => \a[0]~input_o\,
	combout => \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\);

-- Location: IOIBUF_X115_Y14_N1
\a[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_a(1),
	o => \a[1]~input_o\);

-- Location: IOIBUF_X115_Y15_N1
\b[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(1),
	o => \b[1]~input_o\);

-- Location: LCCOMB_X113_Y14_N8
\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~1_combout\ = (\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\ & ((\b[1]~input_o\ & (!\C[2]~input_o\)) # (!\b[1]~input_o\ & ((\a[1]~input_o\))))) # 
-- (!\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\ & ((\b[1]~input_o\ & ((\a[1]~input_o\))) # (!\b[1]~input_o\ & (\C[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111010011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C[2]~input_o\,
	datab => \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\,
	datac => \a[1]~input_o\,
	datad => \b[1]~input_o\,
	combout => \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~1_combout\);

-- Location: LCCOMB_X114_Y14_N26
\inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\ = (\a[2]~input_o\ & ((\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~1_combout\) # (\b[2]~input_o\ $ (\C[2]~input_o\)))) # (!\a[2]~input_o\ & 
-- (\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~1_combout\ & (\b[2]~input_o\ $ (\C[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b[2]~input_o\,
	datab => \a[2]~input_o\,
	datac => \C[2]~input_o\,
	datad => \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~1_combout\,
	combout => \inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\);

-- Location: IOIBUF_X115_Y16_N8
\b[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_b(3),
	o => \b[3]~input_o\);

-- Location: LCCOMB_X114_Y14_N20
\inst8589|inst655|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\ = (\a[3]~input_o\ & ((\inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\) # (\C[2]~input_o\ $ (\b[3]~input_o\)))) # (!\a[3]~input_o\ & 
-- (\inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\ & (\C[2]~input_o\ $ (\b[3]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \a[3]~input_o\,
	datab => \C[2]~input_o\,
	datac => \inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\,
	datad => \b[3]~input_o\,
	combout => \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\);

-- Location: IOIBUF_X115_Y7_N15
\C[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_C(0),
	o => \C[0]~input_o\);

-- Location: LCCOMB_X114_Y14_N22
\inst8589|inst18|LPM_MUX_component|auto_generated|result_node[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst18|LPM_MUX_component|auto_generated|result_node[0]~0_combout\ = \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\ $ (((\C[0]~input_o\ & 
-- ((\inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\))) # (!\C[0]~input_o\ & (\C[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001101111100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C[0]~input_o\,
	datab => \C[2]~input_o\,
	datac => \inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\,
	datad => \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\,
	combout => \inst8589|inst18|LPM_MUX_component|auto_generated|result_node[0]~0_combout\);

-- Location: IOIBUF_X115_Y9_N22
\C[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_C(1),
	o => \C[1]~input_o\);

-- Location: LCCOMB_X114_Y14_N28
\inst8589|inst655|LPM_ADD_SUB_component|auto_generated|sum_eqn[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|sum_eqn[0]~0_combout\ = \a[3]~input_o\ $ (\C[2]~input_o\ $ (\inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\ $ (\b[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \a[3]~input_o\,
	datab => \C[2]~input_o\,
	datac => \inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\,
	datad => \b[3]~input_o\,
	combout => \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|sum_eqn[0]~0_combout\);

-- Location: LCCOMB_X113_Y14_N2
\inst4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst4~0_combout\ = (!\C[1]~input_o\ & !\C[2]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \C[1]~input_o\,
	datad => \C[2]~input_o\,
	combout => \inst4~0_combout\);

-- Location: LCCOMB_X114_Y14_N8
inst155 : cycloneive_lcell_comb
-- Equation(s):
-- \inst155~combout\ = (\C[1]~input_o\ & (\C[2]~input_o\)) # (!\C[1]~input_o\ & (!\C[2]~input_o\ & \C[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C[1]~input_o\,
	datab => \C[2]~input_o\,
	datac => \C[0]~input_o\,
	combout => \inst155~combout\);

-- Location: LCCOMB_X114_Y14_N2
\inst8589|inst3|LPM_MUX_component|auto_generated|result_node[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst3|LPM_MUX_component|auto_generated|result_node[0]~0_combout\ = (\inst4~0_combout\ & ((\b[3]~input_o\ & ((\inst155~combout\) # (\a[3]~input_o\))) # (!\b[3]~input_o\ & (\inst155~combout\ & \a[3]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst4~0_combout\,
	datab => \b[3]~input_o\,
	datac => \inst155~combout\,
	datad => \a[3]~input_o\,
	combout => \inst8589|inst3|LPM_MUX_component|auto_generated|result_node[0]~0_combout\);

-- Location: LCCOMB_X114_Y14_N6
\inst8589|inst3|LPM_MUX_component|auto_generated|result_node[0]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst3|LPM_MUX_component|auto_generated|result_node[0]~1_combout\ = (\inst8589|inst3|LPM_MUX_component|auto_generated|result_node[0]~0_combout\) # ((\inst8589|inst655|LPM_ADD_SUB_component|auto_generated|sum_eqn[0]~0_combout\ & (\C[1]~input_o\ $ 
-- (\C[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C[1]~input_o\,
	datab => \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|sum_eqn[0]~0_combout\,
	datac => \C[2]~input_o\,
	datad => \inst8589|inst3|LPM_MUX_component|auto_generated|result_node[0]~0_combout\,
	combout => \inst8589|inst3|LPM_MUX_component|auto_generated|result_node[0]~1_combout\);

-- Location: LCCOMB_X114_Y14_N0
\inst8589|inst2|LPM_MUX_component|auto_generated|result_node[0]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst2|LPM_MUX_component|auto_generated|result_node[0]~3_combout\ = \a[2]~input_o\ $ (((\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~1_combout\ & (!\C[2]~input_o\ & \C[1]~input_o\)) # 
-- (!\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~1_combout\ & (\C[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001101101100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~1_combout\,
	datab => \C[2]~input_o\,
	datac => \C[1]~input_o\,
	datad => \a[2]~input_o\,
	combout => \inst8589|inst2|LPM_MUX_component|auto_generated|result_node[0]~3_combout\);

-- Location: LCCOMB_X114_Y14_N16
\inst8589|inst2|LPM_MUX_component|auto_generated|result_node[0]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst2|LPM_MUX_component|auto_generated|result_node[0]~2_combout\ = (\inst8589|inst2|LPM_MUX_component|auto_generated|result_node[0]~3_combout\ & (\inst4~0_combout\ $ (((!\inst155~combout\ & !\b[2]~input_o\))))) # 
-- (!\inst8589|inst2|LPM_MUX_component|auto_generated|result_node[0]~3_combout\ & (\b[2]~input_o\ & (\inst4~0_combout\ $ (!\inst155~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100110010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst4~0_combout\,
	datab => \inst155~combout\,
	datac => \inst8589|inst2|LPM_MUX_component|auto_generated|result_node[0]~3_combout\,
	datad => \b[2]~input_o\,
	combout => \inst8589|inst2|LPM_MUX_component|auto_generated|result_node[0]~2_combout\);

-- Location: LCCOMB_X113_Y14_N6
\inst8589|inst1|LPM_MUX_component|auto_generated|result_node[0]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst1|LPM_MUX_component|auto_generated|result_node[0]~3_combout\ = \a[1]~input_o\ $ (((\inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\ & ((\C[1]~input_o\) # (\C[2]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110001111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C[1]~input_o\,
	datab => \inst8589|inst555|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\,
	datac => \a[1]~input_o\,
	datad => \C[2]~input_o\,
	combout => \inst8589|inst1|LPM_MUX_component|auto_generated|result_node[0]~3_combout\);

-- Location: LCCOMB_X113_Y14_N28
\inst8589|inst1|LPM_MUX_component|auto_generated|result_node[0]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst1|LPM_MUX_component|auto_generated|result_node[0]~2_combout\ = (\inst8589|inst1|LPM_MUX_component|auto_generated|result_node[0]~3_combout\ & (\inst4~0_combout\ $ (((!\inst155~combout\ & !\b[1]~input_o\))))) # 
-- (!\inst8589|inst1|LPM_MUX_component|auto_generated|result_node[0]~3_combout\ & (\b[1]~input_o\ & (\inst4~0_combout\ $ (!\inst155~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100110000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst8589|inst1|LPM_MUX_component|auto_generated|result_node[0]~3_combout\,
	datab => \inst4~0_combout\,
	datac => \inst155~combout\,
	datad => \b[1]~input_o\,
	combout => \inst8589|inst1|LPM_MUX_component|auto_generated|result_node[0]~2_combout\);

-- Location: LCCOMB_X114_Y14_N10
\inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~11_combout\ = (\C[2]~input_o\ & \C[1]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \C[2]~input_o\,
	datac => \C[1]~input_o\,
	combout => \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~11_combout\);

-- Location: LCCOMB_X114_Y14_N18
\inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~8_combout\ = (\C[0]~input_o\ & (\inst8589|inst655|LPM_ADD_SUB_component|auto_generated|sum_eqn[0]~0_combout\ $ 
-- (!\inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000001010000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C[0]~input_o\,
	datab => \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|sum_eqn[0]~0_combout\,
	datac => \inst8589|inst5466|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\,
	combout => \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~8_combout\);

-- Location: LCCOMB_X114_Y14_N4
\inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~9_combout\ = (\b[0]~input_o\ & (\inst4~0_combout\ $ (((!\inst155~combout\ & !\a[0]~input_o\))))) # (!\b[0]~input_o\ & (\a[0]~input_o\ & (\inst4~0_combout\ $ (!\inst155~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100110000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst4~0_combout\,
	datab => \b[0]~input_o\,
	datac => \inst155~combout\,
	datad => \a[0]~input_o\,
	combout => \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~9_combout\);

-- Location: LCCOMB_X114_Y14_N14
\inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~10_combout\ = (\inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~11_combout\ & (!\inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~9_combout\ & 
-- (\inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~8_combout\ $ (!\inst8589|inst655|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\)))) # (!\inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~11_combout\ & 
-- (((\inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~9_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101100001010010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~11_combout\,
	datab => \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~8_combout\,
	datac => \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~9_combout\,
	datad => \inst8589|inst655|LPM_ADD_SUB_component|auto_generated|carry_eqn[0]~0_combout\,
	combout => \inst8589|inst|LPM_MUX_component|auto_generated|result_node[0]~10_combout\);

ww_Cout <= \Cout~output_o\;

ww_V <= \V~output_o\;

ww_y(3) <= \y[3]~output_o\;

ww_y(2) <= \y[2]~output_o\;

ww_y(1) <= \y[1]~output_o\;

ww_y(0) <= \y[0]~output_o\;
END structure;


