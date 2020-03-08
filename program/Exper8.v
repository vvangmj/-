module ALU(
	input clk,
	input signed [31:0] alu_a,//signed 表示有符号数
	input signed [31:0] alu_b,
	input 		 [4:0] alu_op,
	output [31:0]alu_out,
	output [63:0] alu_out2
	);
	reg   [31:0]alu_out;
	reg   [63:0] alu_out2;
	parameter A_NOP = 5'h00;
	parameter A_ADD = 5'h01;
	parameter A_SUB = 5'h02;
	parameter A_AND = 5'h03;
	parameter A_OR = 5'h04;
	parameter A_XOR = 5'h05;
	parameter A_NOR = 5'h06;
	parameter A_MUL = 5'h07;
	parameter A_DIV = 5'h08;
	parameter A_ROL = 5'h09;//循环左移
	
	always@(posedge clk)
	begin
	case (alu_op)
		A_NOP:alu_out = 32'b0;
		A_ADD:alu_out = alu_a+alu_b;
		A_SUB:alu_out = alu_a-alu_b;
		A_AND:alu_out = alu_a&alu_b;
		A_OR:alu_out = alu_a|alu_b;
		A_XOR:alu_out = alu_a^alu_b;
		A_NOR:alu_out = alu_a~^alu_b;
		A_MUL:alu_out2 = alu_a*alu_b;//保存在alu-out2
		A_DIV:alu_out = alu_a/alu_b;
		A_ROL:
			begin
			alu_out[31:0] = {alu_a[30:0],alu_a[31]};
			end
	endcase
	end
endmodule

module Exper8;
 
	reg [31:0] alu_a;
	reg [31:0] alu_b;
	reg clk;
	reg [4:0] alu_op;
	wire [31:0] alu_out;
	wire [63:0] alu_out2;
	ALU e8(clk,alu_a,alu_b,alu_op,alu_out,alu_out2);
	
	always
	begin
		#50 clk = ~clk;
	end
	 
	//initialization
	initial
	begin
		$dumpfile("Ex8.vcd");
		$dumpvars(0,e8);
		clk <= 1;
		
		#65  alu_a<=32'h25;alu_b<=32'h12;alu_op<=5'h01;
		#100 alu_op<=5'h09;
		#100 alu_op<=5'h02;		
		#100 alu_op<=5'h03;
		#100 alu_op<=5'h04;
		#100 alu_op<=5'h05;
		#100 alu_op<=5'h06;
		#100 alu_op<=5'h07;
		#100 alu_op<=5'h08;
		#100 alu_op<=5'h09;
		#100 $finish;
	end

endmodule