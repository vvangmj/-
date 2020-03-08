module half_adder(a,b,sum,cout);
	input a,b;
	output sum,cout;//sum代表和数，cout代表进位
	reg sum,cout;
	always @(a or b)
	begin
		case({a,b})
		2'b00:begin sum=0;cout=0;end
		2'b01:begin sum=1;cout=0;end
		2'b10:begin sum=1;cout=0;end
		2'b11:begin sum=0;cout=1;end
		endcase
	end
endmodule

`timescale 1ns/1ps
module Exper4_2_1; 
	reg a,b;
	wire sum,cout;
	half_adder e4_2_1(a,b,sum,cout);	 
	//initialization
	initial
	begin
		$dumpfile("Ex4_2_1.vcd");
		$dumpvars(0,e4_2_1);
		a=1'b0;b=1'b0;
		#20 a=1'b1;
		#20 a=1'b0;b=1'b1;
		#20 a=1'b1;
		#20 $finish;
	end
endmodule