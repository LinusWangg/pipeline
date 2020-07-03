module branchbubble(id_rs,id_rt,ex_regWr,ex_rw,ex_memtoreg,branchbubble);

input wire[4:0] id_rs,id_rt,ex_rw;
input wire ex_regWr,ex_memtoreg;
output reg branchbubble;

initial begin
	branchbubble = 0;
end

always@(*) begin
	if((ex_regWr==1&&ex_memtoreg==1)&&(ex_rw!=0)&&(ex_rw==id_rs||ex_rw==id_rt)) begin
		branchbubble = 1;
	end
	else begin
		branchbubble = 0;
	end

end

endmodule

		
	