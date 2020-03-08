`timescale 1ns/1ps
module TestBench;
	reg CLK;
	reg Reset_n;
	wire[31:0] PC_Q; 
    wire[31:0] PC_D; 
    wire[31:0] Inst; 
    wire[31:0] rf_R_data1; 
    wire[31:0] rf_R_data2; 
    wire[31:0] alu_result; 
    wire[31:0] Data2; 
	SingleCycleCPU cpu(CLK, Reset_n, PC_Q, PC_D, Inst, rf_R_data1, rf_R_data2, alu_result,Data2);
	always
	begin
		#50 CLK = ~CLK;
	end
	initial begin
        $dumpfile("tcpu.vcd");
        $dumpvars(0,cpu);
    end
	initial begin
        CLK=0;
        Reset_n=0;      
        #50;
        Reset_n=1; 
		#1000 $finish;
    end
endmodule