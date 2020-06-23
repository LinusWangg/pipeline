module id_ex(clk,hazard,BranchBubble,id_busA,id_busA_mux2,id_busB,id_busB_mux2,id_HL,id_ra,id_rb,id_rw,id_imm32,id_regWr,id_multWr,id_regDst,id_alusrc,id_memwr,id_memtoreg,id_checkover,id_aluop,id_shamt,id_op,id_Lowin,id_Highin,id_cp0op,id_cs,id_sel,id_cp0_dout,id_cp0_pcout,id_branch_beq,id_branch_bne,id_bltz,id_blez,id_bgez,id_bgtz,id_jalr,id_jal,id_jump,id_jalpc,id_target,
				ex_busA,ex_busA_mux2,ex_busB,ex_busB_mux2,ex_HL,ex_ra,ex_rb,ex_rw,ex_imm32,ex_regWr,ex_multWr,ex_regDst,ex_alusrc,ex_memwr,ex_memtoreg,ex_checkover,ex_aluop,ex_shamt,ex_op,ex_Lowin,ex_Highin,ex_cp0op,ex_cs,ex_sel,ex_cp0_dout,ex_cp0_pcout,ex_branch_beq,ex_branch_bne,ex_bltz,ex_blez,ex_bgez,ex_bgtz,ex_jalr,ex_jal,ex_jump,ex_jalpc,ex_target);

input wire clk,hazard,BranchBubble,id_regWr,id_regDst,id_alusrc,id_memwr,id_checkover,id_multWr,id_Lowin,id_Highin,id_branch_beq,id_branch_bne,id_bltz,id_blez,id_bgez,id_bgtz,id_jalr,id_jal,id_jump;
input wire[31:0] id_busA,id_busB,id_imm32,id_HL,id_busA_mux2,id_cp0_dout,id_busB_mux2;
input wire[4:0] id_ra,id_rb,id_rw,id_cs;
input wire[4:0] id_aluop,id_shamt;
input wire[5:0] id_op;
input wire[1:0] id_memtoreg;
input wire[2:0] id_cp0op,id_sel;
input wire[29:0] id_cp0_pcout,id_jalpc;
input wire[25:0] id_target;

output reg ex_regWr,ex_regDst,ex_alusrc,ex_memwr,ex_checkover,ex_multWr,ex_Lowin,ex_Highin,ex_branch_beq,ex_branch_bne,ex_bltz,ex_blez,ex_bgez,ex_bgtz,ex_jalr,ex_jal,ex_jump;
output reg[31:0] ex_busA,ex_busB,ex_imm32,ex_HL,ex_busA_mux2,ex_cp0_dout,ex_busB_mux2;
output reg[4:0] ex_ra,ex_rb,ex_rw,ex_cs;
output reg[4:0] ex_aluop,ex_shamt;
output reg[5:0] ex_op;
output reg[1:0] ex_memtoreg;
output reg[2:0] ex_cp0op,ex_sel;
output reg[29:0] ex_cp0_pcout,ex_jalpc;
output reg[25:0] ex_target;

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
	ex_cp0op = 3'd0;
	ex_sel = 3'd0;
	ex_cs = 5'd0;
	ex_cp0_dout = 32'd0;
	ex_branch_beq = 0;
	ex_branch_bne = 0;
	ex_bltz = 0;
	ex_blez = 0;
	ex_bgez = 0;
	ex_bgtz = 0;
	ex_jalr = 0;
	ex_jal = 0;
	ex_jump = 0;
	ex_jalpc = 30'd0;
	ex_cp0_pcout = 30'd0;
	ex_target = 26'd0;
	ex_busB_mux2 = 32'd0;
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
		ex_branch_beq = 0;
		ex_branch_bne = 0;
		ex_bltz = 0;
		ex_blez = 0;
		ex_bgez = 0;
		ex_bgtz = 0;
		ex_jalr = 0;
		ex_jal = 0;
		ex_jump = 0;
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
		ex_cp0op = id_cp0op;
		ex_cs = id_cs;
		ex_sel = id_sel;
		ex_cp0_dout = id_cp0_dout;
		ex_branch_beq = id_branch_beq;
		ex_branch_bne = id_branch_bne;
		ex_bltz = id_bltz;
		ex_blez = id_blez;
		ex_bgez = id_bgez;
		ex_bgtz = id_bgtz;
		ex_jalr = id_jalr;
		ex_jal = id_jal;
		ex_jump = id_jump;
		ex_cp0_pcout = id_cp0_pcout;
		ex_jalpc = id_jalpc;
		ex_target = id_target;
		ex_busB_mux2 = id_busB_mux2;
	end
end
endmodule

