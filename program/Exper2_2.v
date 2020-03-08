//Experiment2_2
module CODE (out,in);
	input[7:0] in;
	output[2:0] out;
	reg[2:0] out;
	always @(in)		
	case(in)
		8'b0000_0001 : out = 3'b000;
        8'b0000_0010 : out = 3'b001;
        8'b0000_0100 : out = 3'b010;
        8'b0000_1000 : out = 3'b011;
        8'b0001_0000 : out = 3'b100;
        8'b0010_0000 : out = 3'b101;
        8'b0100_0000 : out = 3'b110;
        8'b1000_0000 : out = 3'b111;
		default:out=8'bx;
	endcase
		
endmodule

module Exper2_2;
	reg [7:0]in;
	wire [2:0]out;
	CODE e2_2 (out,in);
	initial
	begin
		$dumpfile("Ex2_2.vcd");
		$dumpvars(0,e2_2);
		in[0]=0;in[1]=0;in[2]=0;in[3]=0;in[4]=0;in[5]=0;in[6]=0;in[7]=0;
		#2 in[0]=1;
		#2 in[0]=0;
		#2 in[1]=1;
		#2 in[1]=0;
		#2 in[2]=1;
		#2 in[2]=0;
		#2 in[3]=1;
		#2 in[3]=0;
		#2 in[4]=1;
		#2 in[4]=0;
		#2 in[5]=1;
		#2 in[5]=0;
		#2 in[6]=1;
		#2 in[6]=0;
		#2 in[7]=1;
		#2 in[7]=0;
		#2 $finish;
	end
endmodule