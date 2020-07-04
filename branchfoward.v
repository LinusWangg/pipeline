module branchforward(id_rs,id_rt,ex_cp0op,ex_rw,ex_regWr,mem_cp0op,mem_rw,mem_regWr,wr_cp0op,wr_rw,wr_regWr,branchforwardA,branchforwardB);

input wire[4:0] id_rs,id_rt,mem_rw,ex_rw,wr_rw;
input mem_regWr,ex_regWr,wr_regWr;
input wire[2:0] ex_cp0op,mem_cp0op,wr_cp0op;
output reg [1:0]branchforwardA,branchforwardB;

initial begin
	branchforwardA = 2'd0;
	branchforwardB = 2'd0;
end

always@(*) begin
	if((ex_regWr == 1||ex_cp0op == 3'b001) && ex_rw != 0 && ex_rw == id_rs)
		branchforwardA = 2'b01;
	else if((mem_regWr == 1||mem_cp0op == 3'b001) && mem_rw != 0 && mem_rw == id_rs)
		branchforwardA = 2'b10;
	else if((wr_regWr == 1||wr_cp0op == 3'b001) && wr_rw != 0 && wr_rw == id_rs)
		branchforwardA = 2'b11;
	else
		branchforwardA = 2'b00;
	
	if((ex_regWr == 1||ex_cp0op == 3'b001) && ex_rw != 0 && ex_rw == id_rt)
		branchforwardB = 2'b01;
	else if((mem_regWr == 1||mem_cp0op == 3'b001) && mem_rw != 0 && mem_rw == id_rt)
		branchforwardB = 2'b10;
	else if((wr_regWr == 1||wr_cp0op == 3'b001) && wr_rw != 0 && wr_rw == id_rt)
		branchforwardB = 2'b11;
	else
		branchforwardB = 2'b00;
end

endmodule

