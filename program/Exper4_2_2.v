module full_adder(a,b,cin,sum,cout);
	input a,b,cin;
	output sum,cout;//sum代表和数，cout代表进位
	reg sum,cout;
	always @(a or b or cin)
	begin
		case({a,b,cin})
		3'b000:begin sum=0;cout=0;end
		3'b001:begin sum=1;cout=0;end
		3'b010:begin sum=1;cout=0;end
		3'b011:begin sum=0;cout=1;end
		3'b100:begin sum=1;cout=0;end
		3'b101:begin sum=0;cout=1;end
		3'b110:begin sum=0;cout=1;end
		3'b111:begin sum=1;cout=1;end		
		endcase
	end
endmodule

`timescale 1ns/1ps
module Exper4_2_2; 
	reg a,b,cin;
	wire sum,cout;
	full_adder e4_2_2(a,b,cin,sum,cout);	 
	//initialization
	initial
	begin
		$dumpfile("Ex4_2_2.vcd");
		$dumpvars(0,e4_2_2);
		a=1'b0;b=1'b0;cin=1'b0;
		#20 a=1'b1;
		#20 a=1'b0;b=1'b1;
		#20 a=1'b1;
		#20 cin=1'b1;a=1'b0;b=1'b0;
		#20 a=1'b1;
		#20 a=1'b0;b=1'b1;
		#20 a=1'b1;
		#20 $finish;
	end
endmodule