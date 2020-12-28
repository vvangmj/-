# Research on Computer System Construction and Performance Improvement Method Based on GEM5
Component Organization and Architecture Laboratory
Based on the GEM5 simulator, this experiment implements the construction of a multi-CPU, multi-level cache computer system under x86 architecture and ARM architecture. Under the ARM architecture, the simulation of Cortex-A9 processor and Cortex-A15 processor is completed. The performance differences between the same computer system in the system call mode and the whole system mode are summarized. The performance differences between x86 and ARM architecture computers are compared. By analyzing the data files output by the simulator, the method for improving the performance of the computer is summarized. Increasing the number of CPUs and the appropriate amount of Cache in the computer system can effectively improve the efficiency of the computer's execution of the program and save time; using superscalar technology and adding arithmetic logic units can effectively improve computer performance.

language：verilog
environment：iverilog


In “cpu.rar”：
the code of single-cycle cpu. 
Exper10.v compose all parts of cpu. 
TestBench realize the implementation of cpu

In “program.rar”：
The code of several unit experiment, the corresponding experiment reports are in “report.rar”

In “report.rar”：
All of the experiment report including final task.
