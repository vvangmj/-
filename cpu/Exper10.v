`timescale 1ns/1ps
//中央控制单元MCU
module MCU(
	input[5:0] Op,
	output RegDst,
	output ALUSrc,
	output MemtoReg,
	output RegWr,
	output MemWr,
	output MemRd,
	output Branch,
	output Jump,
	output ALUOp1,
	output ALUOp0
	);
	wire [5:0] Op;
	wire Op0_,Op1_,Op2_,Op3_,Op4_,Op5_;
	wire intr234_,intr015,intr015_,intr23_,intr01_,intr01,intr2_3,intr2_34_,intr34_,intr23_4_;
	wire intr0_1,intr0_15_,or1,or2;
	wire RegDst;
	wire ALUSrc;
	wire MemtoReg;
	wire RegWr;
	wire MemWr;
	wire MemRd;
	wire Branch;
	wire Jump;
	wire ALUOp1;
	wire ALUOp0;
	not (Op0_,Op[0]);
	not (Op1_,Op[1]);
	not (Op2_,Op[2]);
	not (Op3_,Op[3]);
	not (Op4_,Op[4]);
	not (Op5_,Op[5]);
	and (intr01_,Op0_,Op1_);
	and (intr015_,intr01_,Op5_);
	and (intr01,Op[0],Op[1]);
	and (intr015,intr01,Op[5]);
	and (intr23_,Op2_,Op3_);
	and (intr234_,intr23_,Op4_);
	and (intr2_3,Op2_,Op[3]);
	and (intr2_34_,intr2_3,Op4_);
	and (intr34_,Op3_,Op4_);
	and (intr23_4_,intr34_,Op[2]);
	and (intr0_1,Op0_,Op[1]);
	and (intr0_15_,intr0_1,Op5_);
	and (RegDst,intr234_,intr015_);
	and (MemtoReg,intr015,intr234_);
	and (MemWr,intr015,intr2_34_);
	and (MemRd,intr015,intr234_);
	and (Branch,intr015_,intr23_4_);
	and (Jump,intr0_15_,intr234_);
	and (ALUOp1,intr234_,intr015_);
	and (ALUOp0,intr23_4_,intr015_);
	or(ALUSrc,MemtoReg,MemWr);
	or(RegWr,RegDst,MemtoReg);
endmodule

//多路选择器MUX
module MUX(
	input [31:0]IN0,
	input [31:0]IN1, 
	input SEL,
	output [31:0]OUT
	);
reg  [31:0] OUT;

always @(SEL or IN0 or IN1)
begin
case (SEL )
0: OUT = IN0;
1: OUT = IN1;
default: OUT = 32'bz;
endcase
end
endmodule 

//4位多路选择器
module MUX_special(
	input [4:0]IN0,
	input [4:0]IN1, 
	input SEL,
	output [4:0]OUT
	);
reg  [4:0] OUT;

always @(SEL or IN0 or IN1)
begin
case (SEL)
0: OUT = IN0;
1: OUT = IN1;
default: OUT = 4'bz;
endcase
end

endmodule 

//加法器
module ADD(
    input [31:0] Data1, 
    input [31:0] Data2,
    output [31:0] C
    );
	reg [31:0] C;
    wire [31:0] A;
    wire [31:0] B;
    assign A = Data1;
    assign B = Data2;
	always @(Data1 or Data2)
		begin
		C=A+B;
		end
endmodule 

//指令寄存器
module InstructionMemory(
	input [31:0] Addr,
	output [31:0] Inst,
	output [5:0] Op_Code,
	output [4:0] Rs,
	output [4:0] Rt,
	output [4:0] Rd,
	output [4:0] Sa,
	output [5:0] func,
	output [15:0] immediate,
	output [25:0] address
	);
	reg [7:0] mem[0:43];

    reg [31:0] Inst;
	
	
	initial begin 
		
		mem[0]=8'b00000000;
		mem[1]=8'b00000000;
		mem[2]=8'b00001000;
		mem[3]=8'b00100000;
		mem[4]=8'b00000000;
		mem[5]=8'b00000001;
		mem[6]=8'b00010000;
		mem[7]=8'b00100001;
		mem[8]=8'b00000000;
		mem[9]=8'b00000010;
		mem[10]=8'b00011000;
		mem[11]=8'b00100010;
		mem[12]=8'b00000000;
		mem[13]=8'b00000011;
		mem[14]=8'b00100000;
		mem[15]=8'b00100100;
		mem[16]=8'b00000000;
		mem[17]=8'b00000001;
		mem[18]=8'b00101000;
		mem[19]=8'b00100101;
		mem[20]=8'b00000000;
		mem[21]=8'b00000010;
		mem[22]=8'b00110000;
		mem[23]=8'b00101010;
		mem[24]=8'b10001100;
		mem[25]=8'b00100111;
		mem[26]=8'b00000000;
		mem[27]=8'b01010100;
		mem[28]=8'b10101100;
		mem[29]=8'b00101000;
		mem[30]=8'b00000000;
		mem[31]=8'b00000111;
		mem[32]=8'b00010000;
		mem[33]=8'b00000000;
		mem[34]=8'b00000000;
		mem[35]=8'b00000001;
		mem[36]=8'b00001000;
		mem[37]=8'b00000000;
		mem[38]=8'b00000000;
		mem[39]=8'b00000001;
		mem[40]=8'b00001000;
		mem[41]=8'b00000000;
		mem[42]=8'b00000000;
		mem[43]=8'b00000001;
        Inst = 0; 
    end
	always @(Addr) begin
         Inst = {mem[Addr],mem[Addr+1],mem[Addr+2],mem[Addr+3]};
         
    end	
	assign Op_Code=Inst[31:26];
	assign Rs=Inst[25:21];
	assign Rt=Inst[20:16];
	assign Rd=Inst[15:11];
	assign Sa=Inst[10:6];
	assign func=Inst[5:0];
	assign immediate=Inst[15:0];
	assign address=Inst[25:0];
endmodule

//寄存器堆
module RF(
	input CLK,
	input w,
	input [31:0]W_data,
	input [4:0]R_Reg1,
	input [4:0]R_Reg2,
	input [4:0]W_Reg,
	output [31:0]R_data1,
	output [31:0]R_data2
	);
	
	reg [31:0] register[63:0];
integer i;
//read op
assign R_data1 = register[R_Reg1];
assign R_data2 = register[R_Reg2];
//write op
initial begin
    register[0]=32'd1;
	register[1]=32'd1;
	register[2]=32'd2;
	register[3]=32'd3;
	register[4]=32'd4;
	register[5]=32'd5;
	register[6]=32'd6;
	register[7]=32'd7;
	register[8]=32'd8;
	register[9]=32'd9;
	register[10]=32'd10;
end
always@(posedge CLK)
	begin
		if(W_Reg!=0)
		begin
		register[W_Reg] <= W_data;
		end
	end
endmodule

//算术逻辑运算单元	
module ALU(
    input [31:0] DataA, 
    input [31:0] DataB,
    input [3:0] ALUOp,
    output zero,
    output [31:0] result
    );
	reg zero;
	reg [31:0] result;

    wire [31:0] A;
    wire [31:0] B;

    assign A = DataA;
    assign B = DataB;

	wire signed [31:0] temp;   
    assign temp = DataA;    
    always @(DataA or DataB or ALUOp or A or B)  
        begin  
             case(ALUOp)                  
                    4'b0000: begin  
                        result = A & B;  
                        zero = (result == 0)? 1 : 0;  
                    end
					4'b0001: begin  
                        result = A | B;  
                        zero = (result == 0)? 1 : 0;  
                    end  
                    4'b0010: begin  
                        result = B << A;  
                        zero = (result == 0)? 1 : 0;  
                    end   
					4'b0011: begin  
                        result = A - B;  
                        zero = (result < 0)? 1 : 0;  
                    end 
					4'b0100: begin  
                        result = A + B;  
                        zero = (result == 0)? 1 : 0;  
                    end 
                    4'b0101: begin  
                        result = A + B;  
                        zero = (result == 0)? 1 : 0;  
                    end  
					4'b0110: begin  
                        result = A - B;  
                        zero = (result == 0)? 1 : 0;  
                    end  
                    4'b0111: begin  
                        result = A ^~ B;  
                        zero = (result == 0)? 1 : 0;  
                    end 
					4'b1000: begin  
                        result = A << B;  
                        zero = (result == 0)? 1 : 0;  
                    end 
					4'b1001: begin  
                        result = A >> B;  
                        zero = (result == 0)? 1 : 0;  
                    end 
					4'b1010: begin  
                        result = temp >>> B;  
                        zero = (result == 0)? 1 : 0;  
                    end 
					4'b1011: begin  
                        result = {B[15:0], 16'd0};  
                        zero = (result == 0)? 1 : 0;  
                    end 
					
             endcase  
         end  
endmodule

//16位扩展到32位
module SigExt16_32(
	input [15:0] imme,
    input en,
    output [31:0] out
	);
	assign out[15:0] = imme;  
    assign out[31:16] = en? (imme[15]? 16'hffff : 16'h0000) : 16'h0000; 
endmodule

//算术逻辑运算控制单元
module ALUCU(
	input ALUOp1,
	input ALUOp0,
	input [5:0]Funct,
	output [3:0]ALUCtrl
	);
	reg ALUCtrl;
	wire Op1;
    wire Op0;
	wire [5:0]Funct;
	assign Op1=ALUOp1;
	assign Op0=ALUOp0;
	always @(ALUOp1 or ALUOp0 or Funct)  
        begin  
            case(ALUOp1)
				1'b0:begin
				if(ALUOp0==0)
				begin
					ALUCtrl=4'b0100;
				end
				else if(ALUOp0==1)
				begin
					ALUCtrl=4'b0110;
				end
				end
				1'b1:begin
					case(Funct)
						6'b100000:
						begin
							ALUCtrl=4'b0100;
						end
						6'b100001:
						begin
							ALUCtrl=4'b0101;
						end
						6'b100010:
						begin
							ALUCtrl=4'b0110;
						end
						6'b100100:
						begin
							ALUCtrl=4'b0000;
						end
						6'b100101:
						begin
							ALUCtrl=4'b0001;
						end
						6'b101010:
						begin
							ALUCtrl=4'b0011;
						end
					endcase
				
				end
			endcase
		end
endmodule

//数据存储器
module DataMemory(
	input [31:0]W_data,
	input [31:0]Addr,
	input R,
	input W,
	output [31:0]R_data
	);

	reg [7:0] bram[255:0];
	reg [31:0] R_data;
	
	initial begin
		
		bram[0]=8'b00000000;
		bram[1]=8'b00000000;
		bram[2]=8'b00001000;
		bram[3]=8'b00100000;
		bram[4]=8'b00000000;
		bram[5]=8'b00000001;
		bram[6]=8'b00010000;
		bram[7]=8'b00100001;
		bram[8]=8'b00000000;
		bram[9]=8'b00000010;
		bram[10]=8'b00011000;
		bram[11]=8'b00100010;
		bram[12]=8'b00000000;
		bram[13]=8'b00000011;
		bram[14]=8'b00100000;
		bram[15]=8'b00100100;
		bram[16]=8'b00000000;
		bram[17]=8'b00000001;
		bram[18]=8'b00101000;
		bram[19]=8'b00100101;
		bram[20]=8'b00000000;
		bram[21]=8'b00000010;
		bram[22]=8'b00110000;
		bram[23]=8'b00101010;
		bram[24]=8'b10001100;
		bram[25]=8'b00100111;
		bram[26]=8'b00000000;
		bram[27]=8'b01010100;
		bram[28]=8'b10101100;
		bram[29]=8'b00101000;
		bram[30]=8'b00000000;
		bram[31]=8'b00000111;
		bram[32]=8'b00010000;
		bram[33]=8'b00000000;
		bram[34]=8'b00000000;
		bram[35]=8'b00000001;
		bram[36]=8'b00001000;
		bram[37]=8'b00000000;
		bram[38]=8'b00000000;
		bram[39]=8'b00000001;
		bram[40]=8'b00000000;
		bram[41]=8'b00000000;
		bram[42]=8'b00001000;
		bram[43]=8'b00100000;
		bram[44]=8'b00000000;
		bram[45]=8'b00000001;
		bram[46]=8'b00010000;
		bram[47]=8'b00100001;
		bram[48]=8'b00000000;
		bram[49]=8'b00000010;
		bram[50]=8'b00011000;
		bram[51]=8'b00100010;
		bram[52]=8'b00000000;
		bram[53]=8'b00000011;
		bram[54]=8'b00100000;
		bram[55]=8'b00100100;
		bram[56]=8'b00010000;
		bram[57]=8'b00000001;
		bram[58]=8'b00101000;
		bram[59]=8'b00100101;
		bram[60]=8'b00000000;
		bram[61]=8'b00000010;
		bram[62]=8'b00110000;
		bram[63]=8'b00101010;
		bram[64]=8'b10001100;
		bram[65]=8'b00100111;
		bram[66]=8'b00000000;
		bram[67]=8'b01010100;
		bram[68]=8'b10101100;
		bram[69]=8'b00101000;
		bram[70]=8'b00000000;
		bram[71]=8'b00000111;
		bram[72]=8'b00010000;
		bram[73]=8'b00000000;
		bram[74]=8'b00000000;
		bram[75]=8'b00000001;
		bram[76]=8'b00001000;
		bram[77]=8'b00000000;
		bram[78]=8'b00000000;
		bram[79]=8'b00000001;
         
    end
	always@(R or Addr)begin
        if(R)begin
            R_data[7:0]=bram[Addr+3];
            R_data[15:8]=bram[Addr+2];
            R_data[23:16]=bram[Addr+1];
            R_data[31:24]=bram[Addr];
        end
    end
    always@(W or Addr)begin
        if(W)begin
            bram[Addr+3]<=W_data[7:0];
            bram[Addr+2]<=W_data[15:8];
            bram[Addr+1]<=W_data[23:16];
            bram[Addr]<=W_data[31:24];
        end
    end
endmodule

//程序计数器
module PC(
	input CLK,
	input Reset_n,
	input [31:0]D,
	output [31:0]Q
	);  
    reg [31:0] Q;  
	 initial 
	 begin
	 Q<=0;
	 end

     always @(posedge CLK or negedge Reset_n)  
        begin  
              if (Reset_n == 0) begin  
                    Q = 0;  
                end  
                else begin
                    Q<=D;
					end
                  
        end 
endmodule

//针对跳转指令的逻辑左移
module SHL2_J(
	input [31:0]pc_value,
	input [25:0]inst,
	output [31:0]pc_new
	);

	assign pc_new[31:28] =pc_value[31:28]; 
    assign pc_new[27:2] =inst; 
	assign pc_new[1:0] =2'b00;
endmodule

//普适的逻辑左移
module SHL2_G(
	input [31:0]value,
	output [31:0]value_new
	);
	assign value_new [31:2]= value[29:0];  
	assign value_new [1:0] =  2'b00;
endmodule

//单周期CPU模块
module SingleCycleCPU(
    input CLK, 
	input Reset_n,
	output[31:0] PC_Q, 
    output[31:0] PC_D, 
    output[31:0] Inst, 
    output[31:0] rf_R_data1, 
    output[31:0] rf_R_data2, 
    output[31:0] alu_result, 
    output[31:0] Data2 
);

    wire [31:0]PC_Q;
	wire [31:0]Add1_C;
	wire [31:0]Inst;
	wire [5:0]Op_Code;
	wire [4:0]Rs;
	wire [4:0]Rt;
	wire [4:0]Rd;
	wire [4:0]Sa;
	wire [5:0] func;
	wire [15:0] immediate;
	wire [25:0] address;
	wire [31:0] PC_new;
	wire [31:0] Data2;
	wire RegDst;
	wire ALUSrc;
	wire MemtoReg;
	wire RegWr;
	wire MemWr;
	wire MemRd;
	wire Branch;
	wire Jump;
	wire ALUOp1;
	wire ALUOp0;
	wire [4:0]rf_W_reg;
	wire [31:0]rf_R_data1;
	wire [31:0]rf_R_data2;
	wire [31:0]ex_out;
	wire [3:0]ALUCtrl;
	wire [31:0]mux4_out;
	wire alu_zero;
    wire [31:0]alu_result;
	wire select_mux1;
	wire [31:0]Add2_B;
	wire [31:0]Add2_C;
	wire [31:0]mux2_in;
	wire [31:0]dm_R_data;
	wire [31:0]PC_D;

	PC pc(CLK,Reset_n,PC_D,PC_Q);
	ADD Add1(32'd4,PC_Q,Add1_C);
	InstructionMemory IM(PC_Q,Inst,Op_Code,Rs,Rt,Rd,Sa,func,immediate,address);
	MCU mcu(Op_Code,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,MemRd,Branch,Jump,ALUOp1,ALUOp0);
	MUX_special mux3(Rt,Rd,RegDst,rf_W_reg);
	RF rf(CLK,RegWr,Data2,Rs,Rt,rf_W_reg,rf_R_data1,rf_R_data2);
	SigExt16_32 extend(immediate,1'b1,ex_out);
	ALUCU alucu(ALUOp1,ALUOp0,func,ALUCtrl);
	MUX mux4(rf_R_data2,ex_out,ALUSrc,mux4_out);
	ALU alu(rf_R_data1, mux4_out,ALUCtrl,alu_zero,alu_result);
	SHL2_J shl2_j(Add1_C,address,PC_new);
	and(select_mux1,Branch,alu_zero);
	SHL2_G shl2_g(ex_out,Add2_B);
	ADD Add2(Add1_C,Add2_B,Add2_C);
	MUX mux1(Add1_C,Add2_C,select_mux1,mux2_in);
	MUX mux2(mux2_in,PC_new,Jump,PC_D);
	DataMemory dm(rf_R_data2,alu_result,MemRd,MemWr,dm_R_data);
	MUX mux5(alu_result,dm_R_data,MemtoReg,Data2);

endmodule
