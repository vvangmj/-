`timescale 1ns/1ps
module d_ff(
			clk,
			rst_n,
			en_n,
			din,
			q,
			q_n
            );
input clk;
input rst_n;
input en_n;
input din;

output q;
output q_n;

reg q;
reg q_n;


always@(posedge clk)
if(!en_n)
    if(!rst_n)            //Õ¨≤Ω«Â¡„
        begin
            q <= 1'b0;
            q_n <= 1'b1;
        end

    else
        begin
            q <= din;
            q_n <= ~din;
        end
	
        
endmodule

module Exper3_1;
	reg clk,cl,en_n,d;
	wire q,q_n;
	d_ff e3_1 (clk,cl,en_n,d,q,q_n);
	initial
	begin
		$dumpfile("Ex3_1.vcd");
		$dumpvars(0,e3_1);
		clk=0;en_n=0;d=0;cl=1;
		#2 clk=1;
		#2 clk=0;d=1;
		#2 clk=1;
		#2 clk=0;d=0;
		#2 clk=1;
		#2 clk=0;
		#2 clk=1;en_n=1;d=1;
		#2 clk=0;
		#2 clk=1;cl=1;d=0;
		#2 clk=0;d=1;en_n=0;
		#2 clk=1;
		#2 clk=0;en_n=0;
		#2 clk=1;cl=0;
		//#2 clk=0;
		//#2 clk=1;
		//#2 clk=0;
		#2 $finish;
	end
endmodule