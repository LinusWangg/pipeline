module pc(
	clk,
	pc_sel,
	adin,
	predict_pc,
	rst,
	adout,
	Hazard,
	BranchBubble
);
input wire clk,rst,Hazard,BranchBubble,pc_sel;
input wire[29:0] adin,predict_pc;
output reg[29:0] adout;
wire[31:0] temp = 32'h00003034;
initial begin
	adout=temp[31:2];
end

always@(posedge clk)
begin
	if(!Hazard && !BranchBubble)
	begin
		if(rst == 1)
			adout = temp[31:2];
		else
			adout = (pc_sel==1)?adin:predict_pc;
	end
end
endmodule
