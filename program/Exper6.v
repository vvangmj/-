module detectMach(data_in,clk,rst,data_out);
input data_in,clk,rst;
output data_out;
reg data_out;
reg [3:0] sta;
reg [3:0] count;
parameter 	s0=4'b1000,
			s1=4'b0100,
			s2=4'b0010,
			s3=4'b0001;
always@(sta)
	begin
	case(sta)
	s0:
	data_out=1'b0;
	s1:
	data_out=1'b0;
	s2:
	data_out=1'b0;
	s3:
	data_out=1'b1;
	default:
	data_out=1'b0;
	endcase
	end
	
always@(posedge clk or negedge rst)
	begin
	if(!rst)
	begin
	sta<=s0;
    count<=4'd0;
	end
	else
	case(sta)
	s0:
	if(data_in==1'b0) sta<=s0;
	else sta<=s1;
	s1:
	if(data_in==1'b0) sta<=s2;
	else sta<=s1;
	s2:
	if(data_in==1'b0) sta<=s0;
	else 
		begin
		sta<=s3;
		count=count+4'd1;
		end
	s3:
	if(data_in==1'b0) sta<=s1;
	else sta<=s1;
	default:
	sta<=s0;
	endcase
	end
endmodule


`timescale 1ns/1ps
module Exper6;
reg clk,rst,data_in;
wire data_out;
reg [3:0]i;


detectMach e6(
				data_in,
				clk,
				rst,				
				data_out
);
always
	begin
		#5 clk = ~clk;
	end
 
initial 
begin
$dumpfile("Ex6.vcd");
$dumpvars(0,e6);
  i=0;data_in=0;rst=0;clk=1'b0;
  #5 rst=1;
  #5 data_in=1;
  #10 data_in=0;
  #10 data_in=1;
  #10 data_in=0;
  #10 data_in=1;
  #10 data_in=0;
  #10 data_in=1;
  #10 data_in=0;
  #10 data_in=0;
  #10 data_in=1;
  #20 clk=0;  
  #30 $finish;
  
end



endmodule