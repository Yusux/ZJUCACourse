@echo off
REM ****************************************************************************
REM Vivado (TM) v2022.2 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Thu Dec 21 17:16:21 +0800 2023
REM SW Build 3671981 on Fri Oct 14 05:00:03 MDT 2022
REM
REM IP Build 3669848 on Fri Oct 14 08:30:02 MDT 2022
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
REM simulate design
echo "xsim sim_top_behav -key {Behavioral:sim_1:Functional:sim_top} -tclbatch sim_top.tcl -view C:/Users/flyme/Documents/Course/Vivado/Arch/arch-fa23/src/lab5/Exp5_NEXYS_A7/code/sim/sim_top_behav.wcfg -log simulate.log"
call xsim  sim_top_behav -key {Behavioral:sim_1:Functional:sim_top} -tclbatch sim_top.tcl -view C:/Users/flyme/Documents/Course/Vivado/Arch/arch-fa23/src/lab5/Exp5_NEXYS_A7/code/sim/sim_top_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
