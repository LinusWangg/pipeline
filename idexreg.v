module id_ex(clk,hazard,BranchBubble,id_busA,id_busB,id_ra,id_rb,id_rw,id_imm32,id_regWr,id_regDst,id_alusrc,id_memwr,id_memtoreg,id_checkover,id_aluop,id_shamt,id_op,
					ex_busA,ex_busB,ex_ra,ex_rb,ex_rw,ex_imm32,ex_regWr,ex_regDst,ex_alusrc,ex_memwr,ex_memtoreg,ex_checkover,ex_aluop,ex_shamt,ex_op);

input wire clk,hazard,BranchBubble,id_regWr,id_regDst,id_alusrc,id_memwr,id_memtoreg,id_checkover;
input wire[31:0] id_busA,id_busB,id_imm32;
input wire[4:0] id_ra,id_rb,id_rw;
input wire[4:0] id_aluop,id_shamt;
input wire[5:0] id_op;

output reg ex_regWr,ex_regDst,ex_alusrc,ex_memwr,ex_memtoreg,ex_checkover;
output reg[31:0] ex_busA,ex_busB,ex_imm32;
output reg[4:0] ex_ra,ex_rb,ex_rw;
output reg[4:0] ex_aluop,ex_shamt;
output reg[5:0] ex_op;

initial begin
	ex_ra = 5'd0;
	ex_rb = 5'd0;
	ex_rw = 5'd0;
	ex_busA = 32'd0;
	ex_busB = 32'd0;
	ex_imm32 = 32'd0;
	ex_aluop = 5'd0;
	ex_shamt = 5'd0;
	ex_regWr = 0;
	ex_regDst = 0;
	ex_alusrc = 0;
	ex_memwr = 0;
	ex_memtoreg = 0;
	ex_op = 6'd0;
	ex_checkover = 0;
end

always@(posedge clk)
begin
	if(hazard || BranchBubble) begin
		ex_regWr = 0;
		ex_regDst = 0;
		ex_alusrc = 0;
		ex_memwr = 0;
		ex_memtoreg = 0;
		ex_checkover = 0;
		ex_aluop = 5'd0;
	end
	else begin
		ex_ra = id_ra;
		ex_rb = id_rb;
		ex_rw = id_rw;
		ex_busA = id_busA;
		ex_busB = id_busB;
		ex_imm32 = id_imm32;
		ex_aluop = id_aluop;
		ex_shamt = id_shamt;
		ex_regWr = id_regWr;
		ex_regDst = id_regDst;
		ex_alusrc = id_alusrc;
		ex_memwr = id_memwr;
		ex_memtoreg = id_memtoreg;
		ex_op = id_op;
		ex_checkover = id_checkover;
	end
end
endmodule

