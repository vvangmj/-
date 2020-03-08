module YIMA(
	input clk,
	input rst,
	input IRWr,
	input [31:0] D,

	//output [5:0] OP_CODE,
	output [4:0] Rs,
	output [4:0] Rt,
	output [4:0] Rd,
	output [4:0] Sa,
	output [5:0] func,
	output [15:0] immediate,
	output [25:0] address 
);

reg [4:0] numb[3:0];
reg [5:0] func_1;
reg [15:0] inns;
reg [25:0] addr_1;
integer i;

assign Rs=numb[3];
assign Rt=numb[2];
assign Rd=numb[1];
assign Sa=numb[0];
assign func=func_1;
assign immediate=inns;
assign address=addr_1;
always@(posedge clk or posedge rst)
	begin	
	if(rst == 1) 
		begin
		numb[3]<=0;numb[2]<=0;numb[1]<=0;numb[0]<=0;func_1<=0;inns<=0;addr_1<=0;
		end
	else if(IRWr == 1)
	 begin
		if((D[31]==0)&&(D[30]==0))
			begin
			numb[3]=D[25:21];
			numb[2]=D[20:16];
			numb[1]=D[15:11];
			numb[0]=D[10:6];
			func_1=D[5:0];
			inns=16'bz;
			addr_1=26'bz;
			end
		else if ((D[31]==0)&&(D[30]==1))
			begin
			numb[3]=D[25:21];
			numb[2]=D[20:16];
			numb[1]=5'bz;
			numb[0]=5'bz;
			func_1=6'bz;
			inns=D[15:0];
			addr_1=26'bz;
			end
		else if ((D[31]==1)&&(D[30]==0))
			begin
			numb[3]=5'bz;
			numb[2]=5'bz;
			numb[1]=5'bz;
			numb[0]=5'bz;
			func_1=5'bz;
			inns=16'bz;
			addr_1=D[25:0];
			end
		else
			begin
			numb[3]=5'bz;
			numb[2]=5'bz;
			numb[1]=5'bz;
			numb[0]=5'bz;
			func_1=5'bz;
			inns=16'bz;
			addr_1=26'bz;
			end
		end
	end

endmodule

module Exper9;
	reg clk;
	reg rst;
	reg IRWr;
	reg [31:0] D;
	wire [4:0] Rs;
	wire [4:0] Rt;
	wire [4:0] Rd;
	wire [4:0] Sa;
	wire [5:0] func;
	wire [15:0] immediate;
	wire [25:0] address;
	YIMA e9(
	clk,
	rst,
	IRWr,
	D,
	Rs,
	Rt,
	Rd,
	Sa,
	func,
	immediate,
	address
	);
	always
	begin
		#30 clk = ~clk;
	end
	
	initial
	begin
		$dumpfile("Ex9.vcd");
		$dumpvars(0,e9);
		clk = 1'b0;
		rst<=1;
		IRWr<=0;
		D=32'b00111110101101000011110000000000;//运算指令
		#10 rst<=0;IRWr<=1;
		#100 D=32'b01010111111000001110001110001111;//存储指令
		#100 D=32'b10000010110101011101001101010101;//转移指令
		#300 $finish;
	end

endmodule
