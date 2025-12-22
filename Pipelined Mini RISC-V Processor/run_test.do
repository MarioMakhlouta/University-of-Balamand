# ModelSim DO file for ALU Testbench
# This file can be run with: vsim -do run_test.do

# Create work library (if needed)
vlib work

# Compile SystemVerilog files
vlog -sv alu.sv
vlog -sv alu_tb.sv

# Load the testbench
vsim alu_tb

# Run all tests (will run until $finish)
run -all

# Exit ModelSim
quit -f

