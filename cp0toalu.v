module cp0toalu(ex_rs,ex_rt,mem_rw,mem_cp0op,mem_cp0_dout,wr_rw,wr_cp0op,wr_cp0_dout,alu3);

input wire[4:0] ex_rs,ex_rt,mem_rw,wr_rw;
input wire[2:0] mem_cp0op,wr_cp0op;
input wire[31:0] mem_cp0_dout,wr_cp0_dout;
output reg[31:0] alu3;

initial begin
	alu3 = 32'd0;
end

always@(*) begin
	if(mem_rw != 0 && mem_cp0op == 3'b001 && (mem_rw == ex_rs || mem_rw == ex_rt))
		alu3 = mem_cp0_dout;
	else if(wr_rw != 0 && wr_cp0op == 3'b001 && (wr_rw == ex_rs || wr_rw == ex_rt))
		alu3 = wr_cp0_dout;
end

endmodule
