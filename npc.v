module npc(
	clk,
	rst,
	Hazard,
	Brunchbubble,
	cur_pc,
	target,
	immediate,
	jal_pc,
	cp0op,
	cp0_pcout,
	branch_beq,
	branch_bne,
	bgez,
	bgtz,
	blez,
	bltz,
	zbgez,
	zbgtz,
	zbeq,
	zbne,
	jalr,
	jal,
	zero,
	jump,
	next_pc
);
input wire clk,rst,Hazard,Brunchbubble;
input wire[15:0] immediate;
input wire[2:0] cp0op;
input wire jump;
input wire zero;  //zero-alu??????
input wire branch_beq,branch_bne,bgez,bgtz,blez,bltz,jalr,jal,zbgez,zbgtz,zbeq,zbne;
input wire[25:0] target;
input wire[29:0] cur_pc;
input wire[29:0] jal_pc,cp0_pcout;
output reg[29:0] next_pc;
wire[31:0] temp = 32'h00003034;

reg [29:0] branch_next;
wire [29:0] new_immediate;
reg [29:0] jump_next;
initial begin
	next_pc <= temp[31:2];
end

always@(posedge clk or negedge clk)
begin
	if(!Hazard && !Brunchbubble) begin
	if(rst == 1 && !clk)
		next_pc <= temp[31:2];
	else if(jalr == 1 && !clk) //jalr
		next_pc <= jal_pc;
	else if(jal == 1 && !clk)  //jal
		next_pc <= {cur_pc[29:26],target[25:0]};
	else if(branch_bne == 1 && !clk)  //bne
		next_pc <= (zbne)?cur_pc-1+{14'b0,immediate}:cur_pc;
	else if(branch_beq == 1 && !clk)  //beq
		next_pc <= (zbeq)?cur_pc-1+{14'b0,immediate}:cur_pc;
	else if(bgez == 1 && !clk)  //bgez
		next_pc <= (zbgez==1)?cur_pc-1+{14'b0,immediate}:cur_pc;
	else if(bltz == 1 && !clk)  //bltz
		next_pc <= (zbgez==0)?cur_pc-1+{14'b0,immediate}:cur_pc;
	else if(bgtz == 1 && !clk)  //bgtz
		next_pc <= (zbgtz==1)?cur_pc-1+{14'b0,immediate}:cur_pc;
	else if(blez == 1 && !clk)  //blez
		next_pc <= (zbgtz==0)?cur_pc-1+{14'b0,immediate}:cur_pc;
	else if(jump == 1 && !clk)  //jump
		next_pc <= {cur_pc[29:26],target[25:0]};
	else if(cp0op == 3'b011 && !clk)  //syscall
		next_pc <= 30'd0;
	else if(cp0op == 3'b100 && !clk)  //eret
		next_pc <= cp0_pcout;
	else if(clk)
		next_pc = cur_pc+1;
	end
end

endmodule
