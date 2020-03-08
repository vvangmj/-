module CALCOMP(a,b,c,d,out);
	input a,b,c,d;
	output out;
	reg out;
always@(a or b or c or d)
	begin
		case({a,b,c,d})
		4'b0000:out=1'b1;
		4'b0001:out=1'b1;
		4'b0010:out=1'b1;
		4'b0011:out=1'b0;
		4'b0100:out=1'b1;
		4'b0101:out=1'b1;
		4'b0110:out=1'b1;
		4'b0111:out=1'b0;
		4'b1000:out=1'b1;
		4'b1001:out=1'b1;
		4'b1010:out=1'b1;
		4'b1011:out=1'b0;
		4'b1100:out=1'b0;
		4'b1101:out=1'b0;
		4'b1110:out=1'b0;
		4'b1111:out=1'b0;
		default: out=1'b0;
		endcase
	end
endmodule

`timescale 1ns/1ps
module Exper4_1; 
	reg a,b,c,d;
	wire out;
	CALCOMP e4_1(a,b,c,d,out);	 
	//initialization
	initial
	begin
		$dumpfile("Ex4_1.vcd");
		$dumpvars(0,e4_1);
		a=1'b0;b=1'b0;c=1'b0;d=1'b0;
		#20 a=1'b1;
		#20 b=1'b1;
		#20 c=1'b1;
		#20 d=1'b1;
		#20 c=1'b0;
		#20 c=1'b1;b=1'b0;
		#20 b=1'b1;a=1'b0;c=1'b0;
		#20 a=1'b1;
		#20 $finish;
	end
endmodule