module pc(
	clk,
	adin,
	rst,
	adout,
	Hazard,
	BranchBubble
);
input wire clk,rst,Hazard,BranchBubble;
input wire[29:0] adin;
output reg[29:0] adout;
wire[31:0] temp = 32'h00000000;
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
			adout = adin;
	end
end
endmodule
