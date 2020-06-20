module mips(clk,rst);
	input clk;
	input rst;

	wire[29:0] NPC,PC,PC_plus_4,jalpc,jalpc1;
	wire[31:0] if_ins;

	wire branch_beq,branch_bne,bgez,blez,bgtz,bltz,zbgez,zbgtz,zbeq,zbne,jump,jal,jalr;
	wire branchbubble,r31Wr;
	wire[1:0] branchforwardA,branchforwardB,jalforward;
	wire[31:0] id_ins;
	wire[29:0] id_PC_plus_4;
	wire[31:0] id_busA,id_busA_mux2,id_busB,id_busB_mux2,mem_forward,wr_forward;
	wire[4:0] id_ra,id_rb,id_rw;
	wire[31:0] id_imm32;
	wire[15:0] id_imm16;
	wire[4:0] id_shamt;
	wire[5:0] id_func;
	wire[25:0] target;

	wire id_regWr,id_regDst,id_Extop,id_alusrc,id_branch_beq,id_branch_bne,id_bltz,id_blez,id_bgez,id_bgtz,id_jalr,id_jal,id_jump,id_memWr,id_memtoreg,id_checkover;
	wire[4:0] id_aluop;
	wire[5:0] id_op;
	//ex
	wire ex_zero,ex_overflow;
	wire[31:0] ex_result,ex_busA,ex_busB,ex_forwardbusB;
	wire[4:0] ex_ra,ex_rb,ex_rw,ex_rw_mux2,ex_shamt;
	
	wire ex_regWr,ex_regDst,ex_alusrc,ex_memwr,ex_memtoreg,ex_checkover;
	wire[4:0] ex_aluop;
	wire[5:0] ex_op;
	
	wire[31:0] ex_imm32,ex_alu_busA,ex_alu_busA_mux2,ex_alu_busB;
	//mem
	wire[31:0] mem_Dataout;
	wire[31:0] mem_result;
	wire[4:0] mem_rw;
	wire[31:0] mem_busB;

	wire mem_regWr,mem_memWr,mem_memtoreg,mem_zero;
	wire[5:0] mem_op;
	//wr
	wire[31:0] wr_Dataout;
	wire[31:0] wr_result;
	wire[4:0] wr_rw;
	wire[31:0] wr_busW;
	wire[5:0] wr_op;

	wire wr_regWr;
	wire wr_memtoreg;
	//foward
	wire[1:0] forwardA,forwardB;

	wire hazard;

	pc get_pc(clk,NPC,rst,PC,hazard,branchbubble);

	jalforward jalforward1(id_ra,ex_rw,ex_regWr,ex_result,mem_rw,mem_regWr,mem_result,wr_rw,wr_regWr,wr_result,jalforward);
	
	mux4 mux_jalpc(jalpc1,ex_result[31:2],mem_result[31:2],wr_result[31:2],jalforward,jalpc);
	
	npc get_npc(PC,target,id_imm16,jalpc,id_branch_beq,id_branch_bne,id_bgez,id_bgtz,id_blez,id_bltz,zbgez,zbgtz,zbeq,zbne,id_jalr,id_jal,mem_zero,id_jump,NPC);
	assign PC_plus_4 = PC+1;
	im_4k get_im(PC[9:0],if_ins);

	IFIDReg ifidreg(clk,PC_plus_4,if_ins,id_branch_beq,id_branch_bne,id_bgez,id_bgtz,id_blez,id_bltz,zbeq,zbne,zbgez,zbgtz,id_jalr,id_jal,id_jump,hazard,branchbubble,id_PC_plus_4,id_ins);

	decoder decoder(id_ins,id_op,id_ra,id_rb,id_rw,id_shamt,id_func,id_imm16,target);

	Control ctr(id_op,id_rb,id_func,id_regWr,id_regDst,id_Extop,id_alusrc,id_aluop,id_memWr,id_memtoreg,id_checkover,id_jump,id_branch_beq,id_branch_bne,id_bgez,id_bgtz,id_blez,id_bltz,id_jalr,id_jal,r31Wr);

	regfile rf(clk,id_ra,id_rb,wr_rw,wr_op,wr_result[11:0],wr_regWr,r31Wr,id_PC_plus_4,wr_busW,id_busA,id_busB,jalpc1);
	
	SignExt SignExt(id_imm16,id_Extop,id_imm32);

	mux_rw mux_rw(ex_rb,ex_rw,ex_regDst,ex_rw_mux2);
	
	HazardUnit hazard1(ex_memtoreg&ex_regWr,ex_rw_mux2,id_ra,id_rb,hazard);

	branchforward branchforward(id_ra,id_rb,ex_rw_mux2,ex_regWr,mem_rw,mem_regWr,mem_memtoreg,wr_rw,wr_regWr,wr_memtoreg,branchforwardA,branchforwardB);

	mux_memtoreg mux_memforward(mem_result,mem_Dataout,mem_memtoreg,mem_forward);

	mux_memtoreg mux_wrforward(wr_result,wr_Dataout,wr_memtoreg,wr_forward);

	mux4 mux_judgeA(id_busA,ex_result,mem_forward,wr_forward,branchforwardA,id_busA_mux2);

	mux4 mux_judgeB(id_busB,ex_result,mem_forward,wr_forward,branchforwardB,id_busB_mux2);
	
	branchjudge branchjudge(id_busA_mux2,id_busB_mux2,id_bgez,id_bgtz,id_blez,id_bltz,id_branch_beq,id_branch_bne,zbgez,zbgtz,zbeq,zbne);

	branchbubble branchbubble1(id_ra,id_rb,ex_regWr,ex_rw_mux2,ex_memtoreg,mem_regWr,mem_memtoreg,mem_rw,id_branch_beq,id_branch_bne,id_bgez,id_bgtz,id_blez,id_bltz,branchbubble);

	id_ex idexreg(clk,hazard,branchbubble,id_busA,id_busB,id_ra,id_rb,id_rw,id_imm32,id_regWr,id_regDst,id_alusrc,id_memWr,id_memtoreg,id_checkover,id_aluop,id_shamt,id_op,
					ex_busA,ex_busB,ex_ra,ex_rb,ex_rw,ex_imm32,ex_regWr,ex_regDst,ex_alusrc,ex_memwr,ex_memtoreg,ex_checkover,ex_aluop,ex_shamt,ex_op);

	forwardunit forwardunit(ex_ra,ex_rb,mem_rw,mem_regWr,wr_rw,wr_regWr,forwardA,forwardB);

	mux3 mux_alubusA(ex_busA,wr_busW,mem_result,forwardA,ex_alu_busA);
	
	mux3 mux_alubusB(ex_busB,wr_busW,mem_result,forwardB,ex_forwardbusB);
	
	mux_memtoreg mux_alusrc_to_busB(ex_forwardbusB,ex_imm32,ex_alusrc,ex_alu_busB);

	alu alu(ex_checkover,ex_aluop,ex_shamt,ex_alu_busA,ex_alu_busB,ex_zero,ex_overflow,ex_result);
	
	ex_mem exmemreg(clk,ex_zero,ex_result,ex_forwardbusB,ex_rw_mux2,ex_regWr,ex_memwr,ex_memtoreg,ex_op,mem_zero,mem_result,mem_busB,mem_rw,mem_regWr,mem_memWr,mem_memtoreg,mem_op);
	
	dm_4k dm_4k(clk,mem_op,mem_memWr,mem_result[11:0],mem_busB,mem_Dataout);

	mem_wr mem_wr(clk,mem_Dataout,mem_result,mem_rw,mem_regWr,mem_memtoreg,mem_op,wr_Dataout,wr_result,wr_rw,wr_regWr,wr_memtoreg,wr_op);

	mux_memtoreg mux(wr_result,wr_Dataout,wr_memtoreg,wr_busW);
endmodule
