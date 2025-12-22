@echo off
REM ModelSim Test Script for ALU Testbench
REM This script compiles and runs the ALU testbench

echo ========================================
echo Creating work library...
echo ========================================
vlib work

echo.
echo ========================================
echo Compiling ALU and Testbench...
echo ========================================

REM Compile the ALU module
vlog -sv alu.sv
if %errorlevel% neq 0 (
    echo ERROR: Failed to compile alu.sv
    pause
    exit /b 1
)

REM Compile the testbench
vlog -sv alu_tb.sv
if %errorlevel% neq 0 (
    echo ERROR: Failed to compile alu_tb.sv
    pause
    exit /b 1
)

echo.
echo ========================================
echo Starting Simulation...
echo ========================================
echo.

REM Run simulation (non-gui mode)
vsim -c -do "run -all; quit -f" alu_tb

echo.
echo ========================================
echo Simulation Complete
echo ========================================
pause

