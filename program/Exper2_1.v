//Experiment2_1
module DECODE (out,in);
	output[7:0] out;
	input[2:0] in;
	reg[7:0] out;
	always @(in)		
	case(in)
		3'b000 : out = 8'b0000_0001;
        3'b001 : out = 8'b0000_0010;
        3'b010 : out = 8'b0000_0100;
        3'b011 : out = 8'b0000_1000;
        3'b100 : out = 8'b0001_0000;
        3'b101 : out = 8'b0010_0000;
        3'b110 : out = 8'b0100_0000;
        3'b111 : out = 8'b1000_0000;
		default:out=8'bx;
	endcase
		
endmodule

module Exper2_1;
	reg [2:0]in;
	wire [7:0]out;
	DECODE e2_1 (out,in);
	initial
	begin
		$dumpfile("Ex2_1.vcd");
		$dumpvars(0,e2_1);
		in[0]=0;in[1]=0;in[2]=0;
		#5 in[0]=1;
		#5 in[0]=0;
		#5 in[1]=1;
		#5 in[1]=0;
		#5 in[2]=1;
		#5 in[2]=0;
		#5 $finish;
	end
endmodule
/*module DECODE(
                        in,
                        out
                             );

input [2:0] in;
output [7:0] out;

reg [7:0] out;

//case”Ôæ‰ µœ÷
always@(in)
    case(in)
        3'b000 : out = 8'b0000_0001;
        3'b001 : out = 8'b0000_0010;
        3'b010 : out = 8'b0000_0100;
        3'b011 : out = 8'b0000_1000;
        3'b100 : out = 8'b0001_0000;
        3'b101 : out = 8'b0010_0000;
        3'b110 : out = 8'b0100_0000;
        3'b111 : out = 8'b1000_0000;
    endcase

endmodule*/

/*module Exper2_1
	reg [2:0]in;
	wire [7:0]out;
	DECODE e2_1 (out,in);
	initial
	begin
		$dumpfile("Ex2_1.vcd");
		$dumpvars(0,e2_1);
		in[0]=0;in[1]=0;in[2]=0;
		#5 in[0]=1;
		#5 in[0]=0;
		#5 in[1]=1;
		#5 in[1]=0;
		#5 in[2]=1;
		#5 in[2]=0;
		#5 $finish;
	end*/