//10 bit right shift register
module loop_register(clk, in, out);
input clk;
input [5:0] in;
output [5:0] out;
reg [5:0] out;
//reg [5:0] temp;
always@(posedge clk)
begin
	//out<=in;
	out <= {in[0], in[5:1]};
end
endmodule

//testbench file for 10 bit right shift register
`timescale 1ns/1ps
module Exper3_2;
 
	reg clk;
	reg [5:0] in;
	wire [5:0] out; 
	loop_register e3_2(clk,in,out);
	//clock generation of period 20 ns
	always
	begin
		#10 clk = ~clk;
		#10 clk = ~clk;
	end
	 
	//initialization
	initial
	begin
		$dumpfile("Ex3_2.vcd");
		$dumpvars(0,e3_2);
		clk = 1'b0;
		in = 6'b110110;
		#100 in = 6'b001010;
		#100 $finish;
	end

endmodule