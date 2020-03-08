//experiment 1.1
module CALCOM(out,a,b,c);
	output out;
	input a,b,c;
	wire a,b,c,out;
	wire a_,c_,b_,a1,b1,a2,b2;
	not (a_,a);
	not (b_,b);
	not (c_,c);
	and (a1,a_,b);
	and (a2,a1,c_);	
	or (b1,b_,c);
	and (b2,b1,a);
	or (out,a2,b2);	
endmodule

module Exper1_1;
	reg a,b,c;
	wire out;
	CALCOM e1_2 (out,a,b,c);
	initial
	begin
		$dumpfile("Ex1_2.vcd");
		$dumpvars(0,e1_2);
		a=0;b=1;c=1;
		#5 b=0;
		#5 b=1;
		#5 a=1;
		#5 a=0;
		#5 c=0;
		#5 c=1;
		#5 $finish;
	end
endmodule