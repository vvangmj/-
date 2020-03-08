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

module REGS(
	input clk,
	input rst,
	input [3:0] R_addr_A,
	input [3:0] R_addr_B,
	input [3:0] Wt_addr,
	input [3:0] Wt_data,
	input L_S,
	output [3:0] rdata_A,
	output [3:0] rdata_B
);

reg [3:0] register[9:1];
integer i;
//read op
assign rdata_A = (R_addr_A == 0)? 0:register[R_addr_A];
assign rdata_B = (R_addr_B == 0)? 0:register[R_addr_B];
//write op
always@(posedge clk or posedge rst)
	begin
	
	if(rst == 1) begin
		for(i=1;i<10;i=i+1)
		register[i]<=0;
		end
	else begin
		if((Wt_addr!=0)&&(L_S == 1))
		register[Wt_addr] <= Wt_data;
		end
	end
endmodule

module COMB(
	input clk,
	input rst,
	input wrt,
	input rd,
	input rstm,
	input [3:0] R_addr_A,
	input [3:0] R_addr_B,
	input [3:0] Wt_addr,
	input [3:0] Wt_data,
	input L_S,
	output [3:0] data_out
);

wire [3:0] rdata_A;
wire [3:0] rdata_B;
wire [3:0] mdata_out;
REGS regi(clk,rst,R_addr_A,R_addr_B,Wt_addr,Wt_data,L_S,rdata_A,rdata_B);
RAM  memo(clk,rstm,wrt,rd,cs,rdata_A,rdata_B,mdata_out);
assign data_out=(rd)?mdata_out:4'hz;
endmodule


module Exper7;
	reg clk,rstm,wrt,rd,cs;
	reg [3:0] addr;
	reg [3:0] data_in;
	reg rst;
	reg [3:0] R_addr_A;
	reg [3:0] R_addr_B;
	reg [3:0] Wt_addr;
	reg [3:0] Wt_data;
	reg L_S;
	wire [3:0] data_out;
	COMB e7(
	clk,//m,r
	rst,//r
	wrt,//m
	rd,//m
	rstm,//m
	R_addr_A,//r
	R_addr_B,//r
	Wt_addr,//r
	Wt_data,//r
	L_S,//r
	data_out
	);
	always
	begin
		#50 clk = ~clk;
	end
	
	initial
	begin
		$dumpfile("Ex7.vcd");
		$dumpvars(0,e7);
		clk = 1'b0;
		L_S<=0;
		rst<=1;
		rstm<=1;
		rd<=0;
		wrt<=0;
		Wt_data<=4'b0111;
		Wt_addr<=4'b0011;//在寄存器的0011地址中写入数据0111；
		#10 L_S<=1;rst<=0;rstm<=0;
		#70 Wt_data<=4'b0100;Wt_addr<=4'b0101;//在寄存器的0100地址中写入数据0101；
		//下面还要改！！！！！
		#100 wrt<=1;R_addr_A<=4'b0011;R_addr_B<=4'b0101;
		#100 wrt<=0;rd<=1;
		#300 $finish;
	end

endmodule

