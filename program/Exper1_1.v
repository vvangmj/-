//experiment 1.1
module CALAND(out,a,b);
	output out;
	input a,b;
	wire a,b,out;
	and (out,a,b);
endmodule

module Exper1_1;
	reg a,b;
	wire out;
	CALAND e1_1 (out,a,b);
	initial
	begin
		$dumpfile("Ex1_1.vcd");
		$dumpvars(0,e1_1);
		a=0;b=1;
		#5 b=0;
		#5 b=1;
		#5 a=1;
		#5 $finish;
	end
endmodule
