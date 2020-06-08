module branchbubble(id_rs,id_rt,ex_regWr,ex_rw,mem_regWr,mem_memtoreg,mem_rw,id_branch_beq,id_branch_bne,id_bgez,id_bgtz,id_blez,id_bltz,id_jalr,id_jal,branchbubble);

input wire[4:0] id_rs,id_rt,ex_rw,mem_rw;
input wire ex_regWr,mem_regWr,mem_memtoreg,id_branch_beq,id_branch_bne,id_bgez,id_bgtz,id_blez,id_bltz,id_jalr,id_jal;
output reg branchbubble;

initial begin
	branchbubble = 0;
end

always@(*) begin
	if(id_jalr == 1) begin //jalr,jr
		if(((ex_regWr==1)&&(ex_rw!=0&&ex_rw==id_rs))||((mem_memtoreg==1)&&(mem_rw!=0&&mem_rw==id_rs))) begin
			branchbubble = 1;
		end
		else begin
			branchbubble = 0;
		end
	end
	else if(id_branch_beq == 1 || id_branch_bne == 1) begin
		if(((ex_regWr==1)&&(ex_rw!=0&&(ex_rw==id_rs||ex_rw==id_rt)))||((mem_memtoreg==1)&&(mem_rw!=0&&(mem_rw==id_rs||mem_rw==id_rt)))) begin
			branchbubble = 1;
		end
		else begin
			branchbubble = 0;
		end
	end
	else if(id_blez == 1 || id_bltz == 1 || id_bgez == 1 || id_bgtz == 1) begin
		if(((ex_regWr==1)&&(ex_rw!=0&&ex_rw==id_rs))||((mem_memtoreg==1)&&(mem_rw!=0&&mem_rw==id_rs))) begin
			branchbubble = 1;
		end
		else begin
			branchbubble = 0;
		end
	end
end

endmodule

		
	