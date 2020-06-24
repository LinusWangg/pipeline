module forwardunit(ex_rs,ex_rt,mem_rw,mem_regWr,mem_cp0op,wr_rw,wr_regWr,wr_cp0op,forwardA,forwardB);  

input wire[4:0] ex_rs,ex_rt,mem_rw,wr_rw;
input wire[2:0] mem_cp0op,wr_cp0op;
input wire mem_regWr,wr_regWr;

output reg[1:0] forwardA,forwardB;

initial begin
	forwardA = 2'd0;
	forwardB = 2'd0;
end

always@(*) begin
	assign forwardA = 2'd0;
	assign forwardB = 2'd0;

	if(mem_regWr == 1 && mem_rw != 0 && mem_rw == ex_rs)
	begin
		assign forwardA = 2'b10;
	end
	else if(wr_regWr == 1 && wr_rw != 0 && wr_rw == ex_rs)
	begin
		assign forwardA = 2'b01;
	end
	else if((mem_cp0op == 3'b001||wr_cp0op == 3'b001) && (mem_rw == ex_rs || wr_rw == ex_rs) && (mem_rw != 0 || wr_rw != 0))
	begin
		assign forwardA = 2'b11;
	end

	if(mem_regWr == 1 && mem_rw != 0 && mem_rw == ex_rt)
	begin
		assign forwardB = 2'b10;
	end
	else if(wr_regWr == 1 && wr_rw != 0 && wr_rw == ex_rt)
	begin
		assign forwardB = 2'b01;
	end
	else if((mem_cp0op == 3'b001||wr_cp0op == 3'b001) && (mem_rw == ex_rs || wr_rw == ex_rs) && (mem_rw != 0 || wr_rw != 0))
	begin
		assign forwardB = 2'b11;
	end
end

endmodule
