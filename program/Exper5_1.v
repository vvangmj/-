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


module Exper5_1;
 
	reg clk,rst,wrt,rd,cs;
	reg [3:0] addr;
	reg [3:0] data_in;
	wire [3:0] data_out;
	//RAM e5_1(.clk(clk),.rst(rst),.wrt(wrt),.rd(rd),.cs(cs),.addr(addr),.data_in(data_in),.data_out(data_out)
		//	);
	RAM e5_1(clk,rst,wrt,rd,cs,addr,data_in,data_out
			);
	
	always
	begin
		#50 clk = ~clk;
	end
	 
	//initialization
	initial
	begin
		$dumpfile("Ex5_1.vcd");
		$dumpvars(0,e5_1);
		clk <= 0;
		rst <= 0;
		
		#100 cs<=1;rst<=1;wrt<=0;rd<=1;
		#200 rst<=0;addr <= 4'b0000;rd<=1;
		#200 rd<=0;wrt<=1;data_in<=4'b1010;
		#300 wrt<=0;rd<=1;
		#100 cs<=1;rst<=1;wrt<=0;rd<=1;
		#200 rst<=0;addr <= 4'b0001;rd<=1;
		#200 rd<=0;wrt<=1;data_in<=4'b1010;
		#300 wrt<=0;rd<=1;
		#100 cs<=1;rst<=1;wrt<=0;rd<=1;
		#200 rst<=0;addr <= 4'b0011;rd<=1;
		#200 rd<=0;wrt<=1;data_in<=4'b1010;
		#300 wrt<=0;rd<=1;
		#100 cs<=1;rst<=1;wrt<=0;rd<=1;
		#200 rst<=0;addr <= 4'b0101;rd<=1;
		#200 rd<=0;wrt<=1;data_in<=4'b1010;
		#300 wrt<=0;rd<=1;
		#100 cs<=1;rst<=1;wrt<=0;rd<=1;
		#200 rst<=0;addr <= 4'b0111;rd<=1;
		#200 rd<=0;wrt<=1;data_in<=4'b1010;
		#300 wrt<=0;rd<=1;
		#100 cs<=1;rst<=1;wrt<=0;rd<=1;
		#200 rst<=0;addr <= 4'b1001;rd<=1;
		#200 rd<=0;wrt<=1;data_in<=4'b1010;
		#200 wrt<=0;rd<=1;
		#300 $finish;
	end

endmodule