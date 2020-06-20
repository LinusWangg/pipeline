module branchbubble(id_rs,id_rt,ex_regWr,ex_rw,ex_memtoreg,mem_regWr,mem_memtoreg,mem_rw,id_branch_beq,id_branch_bne,id_bgez,id_bgtz,id_blez,id_bltz,branchbubble);

input wire[4:0] id_rs,id_rt,mem_rw,ex_rw;
input wire ex_regWr,mem_regWr,ex_memtoreg,mem_memtoreg,id_branch_beq,id_branch_bne,id_bgez,id_bgtz,id_blez,id_bltz;
output reg branchbubble;

initial begin
	branchbubble = 0;
end

always@(*) begin
	if(id_branch_beq == 1 || id_branch_bne == 1) begin
		if((ex_regWr==1&&ex_memtoreg==1)&&(ex_rw!=0)&&(ex_rw==id_rs||ex_rw==id_rt)) begin
			branchbubble = 1;
		end
		else begin
			branchbubble = 0;
		end
	end
	else if(id_blez == 1 || id_bltz == 1 || id_bgez == 1 || id_bgtz == 1) begin
		if((ex_regWr==1&&ex_memtoreg==1)&&(ex_rw!=0)&&(ex_rw==id_rs||ex_rw==id_rt)) begin
			branchbubble = 1;
		end
		else begin
			branchbubble = 0;
		end
	end
end

endmodule

		
	