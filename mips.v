
module mips(clk,rst);
	input clk;
	input rst;

	wire[29:0] NPC,PC,PC_plus_4,id_jalpc,jalpc1,ex_jalpc;
	wire[31:0] if_ins;
	wire[29:0] branch_predict,predict_pc;

	wire branch_beq,branch_bne,bgez,blez,bgtz,bltz,zbgez,zbgtz,zbeq,zbne,jump,jal,jalr;
	wire branchbubble,id_r31Wr;
	wire flush,pc_sel;
	wire[1:0] branchforwardA,branchforwardB,jalforward;
	wire[31:0] id_ins;
	wire[29:0] id_PC_plus_4,id_cp0_pcout,id_cp0_pcoutmux;
	wire[31:0] id_busA,id_busA_mux2,id_busB,id_busB_mux2,mem_forward,wr_forward,id_Highout,id_Lowout,id_HL,id_Highoutmux4,id_Lowoutmux4,id_HL_mux4,id_cp0_dout,id_cp0_doutmux;
	wire[4:0] id_ra,id_rb,id_rw,id_cs;
	wire[31:0] id_imm32;
	wire[15:0] id_imm16;
	wire[4:0] id_shamt;
	wire[5:0] id_func;
	wire[25:0] id_target,ex_target;
	wire[2:0] id_cp0op,id_sel;

	wire id_regWr,id_multWr,id_hlsel,id_regDst,id_Extop,id_alusrc,id_branch_beq,id_branch_bne,id_bltz,id_blez,id_bgez,id_bgtz,id_jalr,id_jal,id_jump,id_memWr,id_checkover,id_Highin,id_Lowin;
	wire[1:0] id_memtoreg;
	wire[4:0] id_aluop;
	wire[5:0] id_op;
	//ex
	wire ex_zero,ex_overflow,ex_r31Wr;
	wire[31:0] ex_result,ex_busA,ex_busB,ex_forwardbusB,ex_HL,ex_busA_mux2,ex_busB_mux2,ex_cp0_dout;
	wire[4:0] ex_ra,ex_rb,ex_rw,ex_rw_mux2,ex_shamt,ex_cs;
	wire[63:0] ex_mult;
	
	wire ex_regWr,ex_multWr,ex_regDst,ex_alusrc,ex_memwr,ex_checkover,ex_Highin,ex_Lowin,ex_branch_beq,ex_branch_bne,ex_bltz,ex_blez,ex_bgez,ex_bgtz,ex_jalr,ex_jal,ex_jump;
	wire[1:0] ex_memtoreg;
	wire[4:0] ex_aluop;
	wire[5:0] ex_op;
	wire[2:0] ex_cp0op,ex_sel;
	
	wire[31:0] ex_imm32,ex_alu_busA,ex_alu_busA_mux2,ex_alu_busB;
	//mem
	wire[31:0] mem_Dataout,mem_HL,mem_busA_mux2,mem_cp0_dout,mem_busB_mux2;
	wire[31:0] mem_result;
	wire[63:0] mem_mult;
	wire[4:0] mem_rw,mem_cs,mem_ra;
	wire[31:0] mem_busB;
	wire[2:0] mem_sel,mem_cp0op;

	wire mem_regWr,mem_multWr,mem_memWr,mem_zero,mem_Highin,mem_Lowin;
	wire[1:0] mem_memtoreg;
	wire[5:0] mem_op;
	//wr
	wire[31:0] wr_Dataout;
	wire[31:0] wr_result,wr_HL,wr_busA_mux2,wr_busB_mux2,wr_cp0_dout;
	wire[63:0] wr_mult;
	wire[4:0] wr_rw,wr_cs,wr_ra;
	wire[31:0] wr_busW;
	wire[5:0] wr_op;
	wire[2:0] wr_cp0op,wr_sel;

	wire wr_regWr,wr_multWr,wr_Highin,wr_Lowin;
	wire[1:0] wr_memtoreg;
	//foward
	wire[1:0] forwardA,forwardB;
	wire[1:0] multforward,cp0forward;
	

	wire hazard;
	wire[1:0] cp0bubble;
	pc get_pc(clk,pc_sel,NPC,predict_pc,rst,PC,hazard,branchbubble);
	
	npc get_npc(clk,rst,flush,hazard,branchbubble,PC,id_PC_plus_4,branch_predict,ex_target,id_imm16,ex_imm32[15:0],ex_jalpc,id_cp0op,id_cp0_pcoutmux,id_branch_beq,id_branch_bne,id_bgez,id_bgtz,id_blez,id_bltz,ex_branch_beq,ex_branch_bne,ex_bgez,ex_bgtz,ex_blez,ex_bltz,zbgez,zbgtz,zbeq,zbne,ex_jalr,ex_jal,ex_jump,NPC,predict_pc,branch_predict,pc_sel,flush);
	assign PC_plus_4 = PC+1;
	im_4k get_im(PC[9:0],if_ins);

	IFIDReg ifidreg(clk,flush,PC_plus_4,if_ins,hazard,branchbubble,id_PC_plus_4,id_ins);

	decoder decoder(id_ins,id_op,id_ra,id_rb,id_rw,id_shamt,id_func,id_cs,id_sel,id_imm16,id_target);

	Control ctr(id_op,id_rb,id_ra,id_func,id_regWr,id_multWr,id_Lowin,id_Highin,id_hlsel,id_regDst,id_Extop,id_alusrc,id_aluop,id_memWr,id_memtoreg,id_checkover,id_jump,id_branch_beq,id_branch_bne,id_bgez,id_bgtz,id_blez,id_bltz,id_jalr,id_jal,id_r31Wr,id_cp0op);

	regfile rf(clk,id_ra,id_rb,wr_rw,wr_op,wr_cp0op,wr_cp0_dout,wr_result[11:0],wr_regWr,ex_r31Wr,wr_multWr,id_PC_plus_4,wr_Lowin,wr_Highin,wr_busW,wr_mult,id_busA,id_busB,id_Highout,id_Lowout,jalpc1);
	
	SignExt SignExt(id_imm16,id_Extop,id_imm32);

	mux_rw mux_rw(ex_rb,ex_rw,ex_regDst,ex_rw_mux2);
	
	HazardUnit hazard1(ex_memtoreg,ex_regWr,ex_rw_mux2,id_ra,id_rb,hazard);

	branchforward branchforward(id_ra,id_rb,ex_rw_mux2,ex_regWr,mem_rw,mem_regWr,mem_memtoreg,wr_rw,wr_regWr,wr_memtoreg,branchforwardA,branchforwardB);

	mux_memtoreg mux_memforward(mem_result,mem_Dataout,mem_memtoreg,mem_forward);

	mux_memtoreg mux_wrforward(wr_result,wr_Dataout,wr_memtoreg,wr_forward);

	mux4 mux_judgeA(id_busA,ex_result,mem_forward,wr_forward,branchforwardA,id_busA_mux2);

	mux4 mux_judgeB(id_busB,ex_result,mem_forward,wr_forward,branchforwardB,id_busB_mux2);
	
	branchjudge branchjudge(ex_busA_mux2,ex_busB_mux2,ex_bgez,ex_bgtz,ex_blez,ex_bltz,ex_branch_beq,ex_branch_bne,zbgez,zbgtz,zbeq,zbne);

	branchbubble branchbubble1(id_ra,id_rb,ex_regWr,ex_rw_mux2,ex_memtoreg,mem_regWr,mem_memtoreg,mem_rw,id_branch_beq,id_branch_bne,id_bgez,id_bgtz,id_blez,id_bltz,branchbubble);

	id_ex idexreg(clk,hazard,cp0bubble,branchbubble,id_busA,id_busA_mux2,id_busB,id_busB_mux2,id_HL_mux4,id_ra,id_rb,id_rw,id_imm32,id_regWr,id_multWr,id_regDst,id_alusrc,id_memWr,id_memtoreg,id_checkover,id_aluop,id_shamt,id_op,id_Lowin,id_Highin,id_cp0op,id_cs,id_sel,id_cp0_doutmux,id_cp0_pcoutmux,id_branch_beq,id_branch_bne,id_bltz,id_blez,id_bgez,id_bgtz,id_jalr,id_jal,id_jump,id_target,id_r31Wr,
					ex_busA,ex_busA_mux2,ex_busB,ex_busB_mux2,ex_HL,ex_ra,ex_rb,ex_rw,ex_imm32,ex_regWr,ex_multWr,ex_regDst,ex_alusrc,ex_memwr,ex_memtoreg,ex_checkover,ex_aluop,ex_shamt,ex_op,ex_Lowin,ex_Highin,ex_cp0op,ex_cs,ex_sel,ex_cp0_dout,ex_cp0_pcout,ex_branch_beq,ex_branch_bne,ex_bltz,ex_blez,ex_bgez,ex_bgtz,ex_jalr,ex_jal,ex_jump,ex_jalpc,ex_target,ex_r31Wr);

	wire[31:0] alu3;
	cp0HLtoalu cp0HLtoalu1(ex_ra,ex_rb,mem_rw,mem_cp0op,mem_memtoreg,mem_regWr,mem_cp0_dout,mem_HL,wr_rw,wr_cp0op,wr_memtoreg,wr_regWr,wr_cp0_dout,wr_HL,alu3);

	forwardunit forwardunit(ex_ra,ex_rb,mem_rw,mem_regWr,mem_memtoreg,mem_cp0op,wr_rw,wr_regWr,wr_memtoreg,wr_cp0op,forwardA,forwardB);

	mux4 mux_alubusA(ex_busA,wr_busW,mem_forward,alu3,forwardA,ex_alu_busA);
	
	mux4 mux_alubusB(ex_busB,wr_busW,mem_forward,alu3,forwardB,ex_forwardbusB);
	
	mux_memtoreg mux_alusrc_to_busB(ex_forwardbusB,ex_imm32,ex_alusrc,ex_alu_busB);

	alu alu(ex_checkover,ex_aluop,ex_shamt,ex_alu_busA,ex_alu_busB,ex_zero,ex_overflow,ex_result,ex_mult);
	
	ex_mem exmemreg(clk,cp0bubble,ex_zero,ex_HL,ex_result,ex_mult,ex_busA_mux2,ex_busB_mux2,ex_forwardbusB,ex_rw_mux2,ex_regWr,ex_multWr,ex_memwr,ex_memtoreg,ex_op,ex_Lowin,ex_Highin,ex_cp0op,ex_cs,ex_sel,ex_cp0_dout,mem_zero,mem_HL,mem_result,mem_mult,mem_busA_mux2,mem_busB_mux2,mem_busB,mem_rw,mem_regWr,mem_multWr,mem_memWr,mem_memtoreg,mem_op,mem_Lowin,mem_Highin,mem_cp0op,mem_cs,mem_sel,mem_cp0_dout);
	
	dm_4k dm_4k(clk,mem_op,mem_memWr,mem_result[11:0],mem_busB,mem_Dataout);

	mem_wr mem_wr(clk,cp0bubble,mem_Dataout,mem_HL,mem_result,mem_mult,mem_busA_mux2,mem_busB_mux2,mem_rw,mem_regWr,mem_multWr,mem_memtoreg,mem_op,mem_Lowin,mem_Highin,mem_cp0op,mem_cs,mem_sel,mem_cp0_dout,wr_Dataout,wr_HL,wr_result,wr_mult,wr_busA_mux2,wr_busB_mux2,wr_rw,wr_regWr,wr_multWr,wr_memtoreg,wr_op,wr_Lowin,wr_Highin,wr_cp0op,wr_cs,wr_sel,wr_cp0_dout);

	mux4 mux(wr_result,wr_Dataout,wr_HL,wr_busA_mux2,wr_memtoreg,wr_busW);

	mux_memtoreg muxHL(id_Lowoutmux4,id_Highoutmux4,id_hlsel,id_HL);

	multforward multforward1(id_multWr,ex_multWr,mem_multWr,wr_multWr,multforward);

	muxHL muxHL1(id_HL,ex_mult,mem_mult,wr_mult,multforward,id_hlsel,id_HL_mux4);

	cp0forwardUnit cp0forwardd(id_cp0op,id_cs,id_sel,ex_cs,ex_sel,ex_cp0op,mem_cs,mem_sel,mem_cp0op,wr_cs,wr_sel,wr_cp0op,cp0forward);

	CP0 cp0(clk,id_cs,id_sel,wr_cs,wr_sel,wr_busB_mux2,id_PC_plus_4-1,id_cp0_dout,id_cp0_pcout,wr_cp0op,id_cp0op);

	mux4 mux_cp0dout(id_cp0_dout,ex_busB_mux2,mem_busB_mux2,wr_busB_mux2,cp0forward,id_cp0_doutmux);

	mux4pc mux_cp0(id_cp0_pcout,ex_busB_mux2[31:2],mem_busB_mux2[31:2],wr_busB_mux2[31:2],cp0forward,id_cp0_pcoutmux);

	cp0bubble cp0bubble1(clk,id_cp0op,ex_cs,ex_sel,ex_cp0op,mem_cs,mem_sel,mem_cp0op,wr_cs,wr_sel,wr_cp0op,cp0bubble);

	wire[1:0]forwardHigh,forwardLow;
	HLforward HLforward1(ex_Highin,ex_Lowin,mem_Highin,mem_Lowin,wr_Highin,wr_lowin,forwardHigh,forwardLow);

	mux4 muxHighout(id_Highout,ex_busA_mux2,mem_busA_mux2,wr_busA_mux2,forwardHigh,id_Highoutmux4);

	mux4 muxLowout(id_Lowout,ex_busA_mux2,mem_busA_mux2,wr_busA_mux2,forwardLow,id_Lowoutmux4);
endmodule
