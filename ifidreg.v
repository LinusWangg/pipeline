module IFIDReg(
	clk,
	flush,
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
	cp0op,
	hazard,
	BranchBubble,
	id_pc_plus_4,
	id_ins
);

input clk,branch_beq,branch_bne,bgez,bgtz,blez,bltz,jalr,jal,jump,hazard,BranchBubble,zbeq,zbne,zbgez,zbgtz,flush;
input wire[29:0] pc_plus_4;
input wire[2:0] cp0op;
input wire[31:0] if_ins;
output reg[29:0] id_pc_plus_4;
output reg[31:0] id_ins;

initial begin
	
end

always@(posedge clk)
begin
	if(hazard || BranchBubble) begin
	
	end 
	/*else if((branch_beq&&zbeq) || (branch_bne&&zbne) || (bgez&&zbgez) || (bgtz&&zbgtz) || (blez&&!zbgtz) || (bltz&&!zbgez) || jalr || jal || jump || cp0op == 3'b011 || cp0op == 3'b100) begin
	end*/
	else if(flush) begin
		id_ins = 0;
	end
	else begin
		id_ins = if_ins;
		id_pc_plus_4 = pc_plus_4;
	end
end

endmodule
