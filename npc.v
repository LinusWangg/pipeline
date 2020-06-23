module npc(
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

input wire[15:0] immediate;
input wire[2:0] cp0op;
input wire jump;
input wire zero;  //zero-alu??????
input wire branch_beq,branch_bne,bgez,bgtz,blez,bltz,jalr,jal,zbgez,zbgtz,zbeq,zbne;
input wire[25:0] target;
input wire[29:0] cur_pc;
input wire[29:0] jal_pc,cp0_pcout;
output reg[29:0] next_pc;

reg [29:0] branch_next;
wire [29:0] new_immediate;
reg [29:0] jump_next;
initial begin
	next_pc = 30'd0;
end

always@(jump or immediate or zero or branch_beq or branch_bne or target or cur_pc or jal_pc or jump or bgez or bgtz or blez or bltz or zbgez or zbgtz or zbne or zbeq or jalr or jal)
begin
	if(jalr == 1) //jalr
		next_pc = jal_pc;
	else if(jal == 1)  //jal
		next_pc = {cur_pc[29:26],target[25:0]};
	else if(branch_bne == 1)  //bne
		next_pc = (zbne)?cur_pc-1+{14'b0,immediate}:cur_pc+1;
	else if(branch_beq == 1)  //beq
		next_pc = (zbeq)?cur_pc-1+{14'b0,immediate}:cur_pc+1;
	else if(bgez == 1)  //bgez
		next_pc = (zbgez==1)?cur_pc-1+{14'b0,immediate}:cur_pc+1;
	else if(bltz == 1)  //bltz
		next_pc = (zbgez==0)?cur_pc-1+{14'b0,immediate}:cur_pc+1;
	else if(bgtz == 1)  //bgtz
		next_pc = (zbgtz==1)?cur_pc-1+{14'b0,immediate}:cur_pc+1;
	else if(blez == 1)  //blez
		next_pc = (zbgtz==0)?cur_pc-1+{14'b0,immediate}:cur_pc+1;
	else if(jump == 1)  //jump
		next_pc = {cur_pc[29:26],target[25:0]};
	else if(cp0op == 3'b011)  //syscall
		next_pc = 30'd0;
	else if(cp0op == 3'b100)  //eret
		next_pc = cp0_pcout;
	else
		next_pc = cur_pc+1;
end

endmodule
