module id_ex(clk,hazard,BranchBubble,id_busA,id_busA_mux2,id_busB,id_HL,id_ra,id_rb,id_rw,id_imm32,id_regWr,id_multWr,id_regDst,id_alusrc,id_memwr,id_memtoreg,id_checkover,id_aluop,id_shamt,id_op,id_Lowin,id_Highin,
					ex_busA,ex_busA_mux2,ex_busB,ex_HL,ex_ra,ex_rb,ex_rw,ex_imm32,ex_regWr,ex_multWr,ex_regDst,ex_alusrc,ex_memwr,ex_memtoreg,ex_checkover,ex_aluop,ex_shamt,ex_op,ex_Lowin,ex_Highin);

input wire clk,hazard,BranchBubble,id_regWr,id_regDst,id_alusrc,id_memwr,id_checkover,id_multWr,id_Lowin,id_Highin;
input wire[31:0] id_busA,id_busB,id_imm32,id_HL,id_busA_mux2;
input wire[4:0] id_ra,id_rb,id_rw;
input wire[4:0] id_aluop,id_shamt;
input wire[5:0] id_op;
input wire[1:0] id_memtoreg;

output reg ex_regWr,ex_regDst,ex_alusrc,ex_memwr,ex_checkover,ex_multWr,ex_Lowin,ex_Highin;
output reg[31:0] ex_busA,ex_busB,ex_imm32,ex_HL,ex_busA_mux2;
output reg[4:0] ex_ra,ex_rb,ex_rw;
output reg[4:0] ex_aluop,ex_shamt;
output reg[5:0] ex_op;
output reg[1:0] ex_memtoreg;

initial begin
	ex_ra = 5'd0;
	ex_rb = 5'd0;
	ex_rw = 5'd0;
	ex_busA = 32'd0;
	ex_busB = 32'd0;
	ex_imm32 = 32'd0;
	ex_HL = 32'b0;
	ex_aluop = 5'd0;
	ex_shamt = 5'd0;
	ex_regWr = 0;
	ex_multWr = 0;
	ex_regDst = 0;
	ex_alusrc = 0;
	ex_memwr = 0;
	ex_memtoreg = 2'd0;
	ex_op = 6'd0;
	ex_checkover = 0;
	ex_busA_mux2 = 32'd0;
	ex_Lowin = 0;
	ex_Highin = 0;
end

always@(posedge clk)
begin
	if(hazard || BranchBubble) begin
		ex_regWr = 0;
		ex_multWr = 0;
		ex_regDst = 0;
		ex_alusrc = 0;
		ex_memwr = 0;
		ex_memtoreg = 2'd0;
		ex_checkover = 0;
		ex_aluop = 5'd0;
		ex_Lowin = 0;
		ex_Highin = 0;
	end
	else begin
		ex_ra = id_ra;
		ex_rb = id_rb;
		ex_rw = id_rw;
		ex_busA = id_busA;
		ex_busB = id_busB;
		ex_imm32 = id_imm32;
		ex_HL = id_HL;
		ex_aluop = id_aluop;
		ex_shamt = id_shamt;
		ex_regWr = id_regWr;
		ex_multWr = id_multWr;
		ex_regDst = id_regDst;
		ex_alusrc = id_alusrc;
		ex_memwr = id_memwr;
		ex_memtoreg = id_memtoreg;
		ex_op = id_op;
		ex_checkover = id_checkover;
		ex_busA_mux2 = id_busA_mux2;
		ex_Lowin = id_Lowin;
		ex_Highin = id_Highin;
	end
end
endmodule

