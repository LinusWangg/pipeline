module npc(
	clk,
	rst,
	flushbefore,
	Brunchbubble,
	cur_pc,
	pre_pc,
	branch_predict2,
	target,
	id_immediate,
	immediate,
	jal_pc,
	cp0op,
	cp0_pcout,
	id_branch_beq,id_branch_bne,id_bgez,id_bgtz,id_blez,id_bltz,
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
	jump,
	next_pc,
	predict_pc,
	branch_predict,
	pc_sel,
	flush
);
input wire clk,rst,Brunchbubble,flushbefore;
input wire[15:0] immediate,id_immediate;
input wire[2:0] cp0op;
input wire jump;  //zero-alu??????
input wire branch_beq,branch_bne,bgez,bgtz,blez,bltz,jalr,jal,zbgez,zbgtz,zbeq,zbne,id_branch_beq,id_branch_bne,id_bgez,id_bgtz,id_blez,id_bltz;
input wire[25:0] target;
input wire[29:0] cur_pc,pre_pc;
input wire[29:0] jal_pc,cp0_pcout;
output reg[29:0] next_pc,predict_pc;
output reg flush,pc_sel;
wire[31:0] temp = 32'h00003034;
input wire[29:0] branch_predict2;
output reg [29:0] branch_predict;
wire [29:0] new_immediate;
reg [29:0] jump_next;
reg [61:0] BHT[16:0];
reg flag;

integer i,t;
initial begin
	next_pc <= temp[31:2];
	flush <= 0;
	for(i=0;i<=15;i=i+1)
		BHT[i] = 0;
end

always@(id_branch_bne or id_branch_beq or id_bgez or id_bgtz or id_blez or id_bltz) begin
	for(i=0;i<=15;i=i+1) begin
		if(BHT[i][61]==1&&BHT[i][60:31]==cur_pc-1&&BHT[i][30]==1) begin
			flag = 1;
			predict_pc = BHT[i][29:0];
			branch_predict = predict_pc;
			pc_sel = 0;
		end
		else if(BHT[i][61]==1&&BHT[i][60:31]==cur_pc-1&&BHT[i][30]==0) begin
			flag = 1;
			predict_pc = BHT[i][29:0];
			branch_predict = predict_pc;
			pc_sel = 0;
		end
		else if(BHT[i][61]==0) begin
			flag = 0;
			t = i;
			pc_sel = 0;
		end
	end
	if(flag == 0) begin
		if(id_branch_bne||id_branch_beq||id_bgez||id_bgtz||id_blez||id_bltz) begin
			predict_pc = cur_pc+1;
			branch_predict = predict_pc;
			BHT[t][61] = 1;
			BHT[t][60:31] = cur_pc-1;
			pc_sel = 0;
		end
		else begin
			pc_sel = 1;
		end
	end
end

always@(posedge clk or negedge clk) begin
	if(clk) begin
		if(Brunchbubble) begin
		if(flushbefore==1)
			flush = 1;
		end
		flush = 0;
	end
	if(!clk) begin
	if(!Brunchbubble) begin
	end
	if(rst == 1 && !clk)
		next_pc = temp[31:2];
	else if(jalr == 1 && !clk) begin//jalr
		next_pc = jal_pc;
		flush = 1;
	end
	else if(jal == 1 && !clk)  begin//jal
		next_pc = {pre_pc[29:26],target[25:0]};
		flush = 1;
	end
	else if(branch_bne == 1 && !clk)  begin//bne 
		BHT[t][29:0] = predict_pc;
		next_pc = (zbne)?pre_pc-1+{{14{immediate[15]}},immediate}:pre_pc;
		if(next_pc != branch_predict2) begin
			for(i=0;i<=15;i=i+1) begin
				if(BHT[i][61]==1&&BHT[i][60:31]==pre_pc-2) begin
					BHT[i][30] = !BHT[i][30];
					BHT[i][29:0] = next_pc;
					flush = 1;
				end
			end	
		end
		else begin
			next_pc = next_pc+1;
			flush = 0;
		end
	end
	else if(branch_beq == 1 && !clk)  begin//beq
		BHT[t][29:0] = predict_pc;
		next_pc = (zbeq)?pre_pc-1+{{14{immediate[15]}},immediate}:pre_pc;
		if(next_pc != branch_predict2) begin
			for(i=0;i<=15;i=i+1) begin
				if(BHT[i][61]==1&&BHT[i][60:31]==pre_pc-2) begin
					BHT[i][30] = !BHT[i][30];
					BHT[i][29:0] = next_pc;
					flush = 1;
				end
			end	
		end
		else begin
			next_pc = next_pc+1;
			flush = 0;
		end
	end
	else if(bgez == 1 && !clk)  begin//bgez
		BHT[t][29:0] = predict_pc;
		next_pc = (zbgez==1)?pre_pc-1+{{14{immediate[15]}},immediate}:pre_pc;
		if(next_pc != branch_predict2) begin
			for(i=0;i<=15;i=i+1) begin
				if(BHT[i][61]==1&&BHT[i][60:31]==pre_pc-2) begin
					BHT[i][30] = !BHT[i][30];
					BHT[i][29:0] = next_pc;
					flush = 1;
				end
			end	
		end
		else begin
			next_pc = next_pc+1;
			flush = 0;
		end
	end
	else if(bltz == 1 && !clk)  begin//bltz
		BHT[t][29:0] = predict_pc;
		next_pc = (zbgez==0)?pre_pc-1+{{14{immediate[15]}},immediate}:pre_pc;
		if(next_pc != branch_predict2) begin
			for(i=0;i<=15;i=i+1) begin
				if(BHT[i][61]==1&&BHT[i][60:31]==pre_pc-2) begin
					BHT[i][30] = !BHT[i][30];
					BHT[i][29:0] = next_pc;
					flush = 1;
				end
			end	
		end
		else begin
			next_pc = next_pc+1;
			flush = 0;
		end
	end
	else if(bgtz == 1 && !clk)  begin//bgtz
		BHT[t][29:0] = predict_pc;
		next_pc = (zbgtz==1)?pre_pc-1+{{14{immediate[15]}},immediate}:pre_pc;
		if(next_pc != branch_predict2) begin
			for(i=0;i<=15;i=i+1) begin
				if(BHT[i][61]==1&&BHT[i][60:31]==pre_pc-2) begin
					BHT[i][30] = !BHT[i][30];
					BHT[i][29:0] = next_pc;
					flush = 1;
				end
			end	
		end
		else begin
			next_pc = next_pc+1;
			flush = 0;
		end
	end
	else if(blez == 1 && !clk)  begin//blez
		BHT[t][29:0] = predict_pc;
		next_pc = (zbgtz==0)?pre_pc-1+{{14{immediate[15]}},immediate}:pre_pc;
		if(next_pc != branch_predict2) begin
			for(i=0;i<=15;i=i+1) begin
				if(BHT[i][61]==1&&BHT[i][60:31]==pre_pc-2) begin
					BHT[i][30] = !BHT[i][30];
					BHT[i][29:0] = next_pc;
					flush = 1;
				end
			end	
		end
		else begin
			next_pc = next_pc+1;
			flush = 0;
		end
	end
	else if(jump == 1 && !clk)  begin//jump
		next_pc = {pre_pc[29:26],target[25:0]};
		flush = 1;
	end
	else if(cp0op == 3'b011 && !clk)  begin//syscall
		next_pc = 30'd0;
		flush = 1;
	end
	else if(cp0op == 3'b100 && !clk)  begin//eret
		next_pc = cp0_pcout;
		flush = 1;
	end
	else if(!id_bgtz&&!id_bgez&&!id_blez&&!id_bltz&&!id_branch_beq&&!id_branch_bne) begin
		next_pc = cur_pc+1;
	end
	end
end
/*always@(id_branch_bne or id_branch_beq or id_bgez or id_bgtz or id_blez or id_bltz) begin
	for(i=0;i<=15;i=i+1) begin
		if(BHT[i][61]==1&&BHT[i][60:31]==cur_pc-1&&BHT[i][30]==1) begin
			flag = 1;
			next_pc = BHT[i][29:0];
			branch_predict = next_pc;
			flag = 1;
			i = 16;
		end
		else if(BHT[i][61]==1&&BHT[i][60:31]==cur_pc-1&&BHT[i][30]==0) begin
			flag = 1;
			next_pc = cur_pc+1;
			branch_predict = next_pc;
			flag = 1;
			i = 16;
		end
		else if(BHT[i][61]==0) begin
			flag = 0;
			t = i;
			i = 16;
		end
	end
	if(flag == 0) begin
		if(id_branch_bne||id_branch_beq||id_bgez||id_bgtz||id_blez||id_bltz) begin
			next_pc = cur_pc+{{14{id_immediate[15]}},id_immediate};
			branch_predict = next_pc;
			BHT[t][61] = 1;
			BHT[t][60:31] = cur_pc-1;
			BHT[t][30] = 0;
			BHT[t][29:0] = next_pc;
		end
	end
end

always@(posedge clk) begin
	if(Hazard && Brunchbubble) begin
		if(flush==1)
			flush = 1;
	end
	flush = 0;
end

always@(negedge clk)
begin
	if(!Hazard && !Brunchbubble) begin
	end
	if(rst == 1 && !clk)
		next_pc = temp[31:2];
	else if(jalr == 1 && !clk) begin//jalr
		next_pc = jal_pc;
		flush = 1;
	end
	else if(jal == 1 && !clk)  begin//jal
		next_pc = {pre_pc[29:26],target[25:0]};
		flush = 1;
	end
	else if(branch_bne == 1 && !clk)  begin//bne 
		next_pc = (zbne)?pre_pc-1+{{14{immediate[15]}},immediate}:pre_pc;
		if(next_pc != branch_predict2) begin
			for(i=0;i<=15;i=i+1) begin
				if(BHT[i][61]==1&&BHT[i][60:31]==pre_pc-2) begin
					BHT[i][30] = !BHT[i][30];
					BHT[i][29:0] = next_pc;
					flush = 1;
				end
			end	
		end
		else begin
			next_pc = next_pc+1;
			flush = 0;
		end
	end
	else if(branch_beq == 1 && !clk)  begin//beq
		next_pc = (zbeq)?pre_pc-1+{{14{immediate[15]}},immediate}:pre_pc;
		if(next_pc != branch_predict2) begin
			for(i=0;i<=15;i=i+1) begin
				if(BHT[i][61]==1&&BHT[i][60:31]==pre_pc-2) begin
					BHT[i][30] = !BHT[i][30];
					BHT[i][29:0] = next_pc;
					flush = 1;
				end
			end	
		end
		else begin
			next_pc = next_pc+1;
			flush = 0;
		end
	end
	else if(bgez == 1 && !clk)  begin//bgez
		next_pc = (zbgez==1)?pre_pc-1+{{14{immediate[15]}},immediate}:pre_pc;
		if(next_pc != branch_predict2) begin
			for(i=0;i<=15;i=i+1) begin
				if(BHT[i][61]==1&&BHT[i][60:31]==pre_pc-2) begin
					BHT[i][30] = !BHT[i][30];
					BHT[i][29:0] = next_pc;
					flush = 1;
				end
			end	
		end
		else begin
			next_pc = next_pc+1;
			flush = 0;
		end
	end
	else if(bltz == 1 && !clk)  begin//bltz
		next_pc = (zbgez==0)?pre_pc-1+{{14{immediate[15]}},immediate}:pre_pc;
		if(next_pc != branch_predict2) begin
			for(i=0;i<=15;i=i+1) begin
				if(BHT[i][61]==1&&BHT[i][60:31]==pre_pc-2) begin
					BHT[i][30] = !BHT[i][30];
					BHT[i][29:0] = next_pc;
					flush = 1;
				end
			end	
		end
		else begin
			next_pc = next_pc+1;
			flush = 0;
		end
	end
	else if(bgtz == 1 && !clk)  begin//bgtz
		next_pc = (zbgtz==1)?pre_pc-1+{{14{immediate[15]}},immediate}:pre_pc;
		if(next_pc != branch_predict2) begin
			for(i=0;i<=15;i=i+1) begin
				if(BHT[i][61]==1&&BHT[i][60:31]==pre_pc-2) begin
					BHT[i][30] = !BHT[i][30];
					BHT[i][29:0] = next_pc;
					flush = 1;
				end
			end	
		end
		else begin
			next_pc = next_pc+1;
			flush = 0;
		end
	end
	else if(blez == 1 && !clk)  begin//blez
		next_pc = (zbgtz==0)?pre_pc-1+{{14{immediate[15]}},immediate}:pre_pc;
		if(next_pc != branch_predict2) begin
			for(i=0;i<=15;i=i+1) begin
				if(BHT[i][61]==1&&BHT[i][60:31]==pre_pc-2) begin
					BHT[i][30] = !BHT[i][30];
					BHT[i][29:0] = next_pc;
					flush = 1;
				end
			end	
		end
		else begin
			next_pc = next_pc+1;
			flush = 0;
		end
	end
	else if(jump == 1 && !clk)  begin//jump
		next_pc = {pre_pc[29:26],target[25:0]};
		flush = 1;
	end
	else if(cp0op == 3'b011 && !clk)  begin//syscall
		next_pc = 30'd0;
		flush = 1;
	end
	else if(cp0op == 3'b100 && !clk)  begin//eret
		next_pc = cp0_pcout;
		flush = 1;
	end
	else if(!id_bgtz&&!id_bgez&&!id_blez&&!id_bltz&&!id_branch_beq&&!id_branch_bne) begin
		next_pc = cur_pc+1;
	end
end*/

endmodule
