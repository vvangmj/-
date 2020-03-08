module RAM(
	input clk,
	input rst,
	input wrt,
	input rd,
	input cs,
	input [3:0] addr,
	input [3:0] data_in,
	output [3:0] data_out
	);
	
	reg [3:0] bram[15:0];
	reg [3:0] data;
	integer i;
	
	always@(posedge clk or posedge rst)
	begin
		if(rst)
		begin
		for(i=0;i<15;i++)
		bram[i]<=4'b0000;
		end
		
		else if(wrt)
		begin
		bram[addr]<=data_in;
		end
		
		else if(rd)
		begin
		data<=bram[addr];
		end
		
		else
		begin
		data<=4'hz;
		end
	end
assign data_out=data;
endmodule

module adv_RAM(
	input clk,
	input rst,
	input wrt,
	input rd,
	input [4:0] addr,
	input [7:0] data_in,
	output [7:0] data_out
	);
	
	wire [7:0] t1;
	wire [7:0] t2;
	RAM ralow(clk,rst,wrt,rd,addr[4],addr[3:0],data_in[3:0],t1[3:0]);
	RAM rahign(clk,rst,wrt,rd,addr[4],addr[3:0],data_in[7:4],t1[7:4]);
	RAM rblow(clk,rst,wrt,rd,~addr[4],addr[3:0],data_in[3:0],t2[3:0]);
	RAM rbhigh(clk,rst,wrt,rd,~addr[4],addr[3:0],data_in[7:4],t2[7:4]);
	
	assign data_out=(addr [4])?t1:t2;
endmodule

module Exper5_2;
	reg clk,rst,wrt,rd;
	reg [4:0] addr;
	reg [7:0] data_in;
	wire [7:0] data_out;
	adv_RAM e5_2(
	clk,
	rst,
	wrt,
	rd,
	addr,
	data_in,
	data_out
	); 
	always
	begin
		#50 clk = ~clk;
	end
	
	initial
	begin
		$dumpfile("Ex5_2.vcd");
		$dumpvars(0,e5_2);
		clk = 1'b0;
		rst<=1;
		rd<=0;
		wrt<=0;
		addr<=5'b00000;
		#10 addr = 5'b01010;
		#60 rst<=0;rd=1;
		#120 addr<= 5'b11101;
		#200 rd<=1;data_in<=8'b10101010;wrt<=1;
		#200 wrt<=0;rd=1;
		#300 $finish;
	end

endmodule
	
	