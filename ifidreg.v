module IFIDReg(
	clk,
	flush,
	pc_plus_4,
	if_ins,
	BranchBubble,
	id_pc_plus_4,
	id_ins
);

input clk,BranchBubble,flush;
input wire[29:0] pc_plus_4;
input wire[31:0] if_ins;
output reg[29:0] id_pc_plus_4;
output reg[31:0] id_ins;

initial begin
	
end

always@(posedge clk)
begin
	if(BranchBubble) begin
	
	end 
	else if(flush) begin
		id_ins = 0;
	end
	else begin
		id_ins = if_ins;
		id_pc_plus_4 = pc_plus_4;
	end
end

endmodule
