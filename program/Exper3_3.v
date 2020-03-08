module count41(rst,clk,cnt);
input rst,clk;
output [5:0]cnt;
reg [5:0]cnt;

always@(posedge clk)
begin
	if(rst==1'b0)
		cnt<=6'b000000;
	else 
	if(cnt==6'd40)
		cnt<=6'b000000;
	else
		cnt<=cnt+1;
end
endmodule

`timescale 1ns/1ps
module Exper3_3;
 
	reg clk;
	reg rst;
	wire [5:0]cnt;
	count41 e3_3(rst,clk,cnt);
	//clock generation of period 20 ns
	always
	begin
		#10 clk = ~clk;
	end
	 
	//initialization
	initial
	begin
		$dumpfile("Ex3_3.vcd");
		$dumpvars(0,e3_3);
		clk = 1'b0;
		rst=1'b0;
		#50 rst=1'b1;
		#2000 rst=1'b0;
		#20 $finish;
	end
endmodule