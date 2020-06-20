module IFIDReg(
	clk,
	pc_plus_4,
	if_ins,
	branch_beq,
	branch_bne,
	bgez,
	bgtz,
	blez,
	bltz,
	zbeq,
	zbne,
	zbgez,
	zbgtz,
	jalr,
	jal,
	jump,
	hazard,
	BranchBubble,
	id_pc_plus_4,
	id_ins
);

input clk,branch_beq,branch_bne,bgez,bgtz,blez,bltz,jalr,jal,jump,hazard,BranchBubble,zbeq,zbne,zbgez,zbgtz;
input wire[29:0] pc_plus_4;
input wire[31:0] if_ins;
output reg[29:0] id_pc_plus_4;
output reg[31:0] id_ins;

always@(posedge clk)
begin
	if(hazard || BranchBubble) begin
	
	end 
	else if((branch_beq&&zbeq) || (branch_bne&&zbne) || (bgez&&zbgez) || (bgtz&&zbgtz) || (blez&&!zbgtz) || (bltz&&!zbgez) || jalr || jal || jump) begin
		id_ins = 32'b0;
		id_pc_plus_4 = pc_plus_4;
	end
	else begin
		id_ins = if_ins;
		id_pc_plus_4 = pc_plus_4;
	end
end

endmodule
