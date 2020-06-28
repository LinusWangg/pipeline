module cp0HLtoalu(ex_rs,ex_rt,mem_rw,mem_cp0op,mem_memtoreg,mem_regWr,mem_cp0_dout,mem_HL,wr_rw,wr_cp0op,wr_memtoreg,wr_regWr,wr_cp0_dout,wr_HL,alu3);

input wire[4:0] ex_rs,ex_rt,mem_rw,wr_rw;
input wire[2:0] mem_cp0op,wr_cp0op;
input wire[1:0] mem_memtoreg,wr_memtoreg;
input wire mem_regWr,wr_regWr;
input wire[31:0] mem_cp0_dout,wr_cp0_dout,mem_HL,wr_HL;
output reg[31:0] alu3;

initial begin
	alu3 = 32'd0;
end

always@(*) begin
	if(mem_rw != 0 && mem_cp0op == 3'b001 && (mem_rw == ex_rs || mem_rw == ex_rt))
		alu3 = mem_cp0_dout;
	else if(wr_rw != 0 && wr_cp0op == 3'b001 && (wr_rw == ex_rs || wr_rw == ex_rt))
		alu3 = wr_cp0_dout;
	else if(wr_rw != 0 && wr_memtoreg == 2'd2 && wr_regWr == 1 && (wr_rw == ex_rs || wr_rw == ex_rt))
		alu3 = wr_HL;
	else if(mem_rw != 0 && mem_memtoreg == 2'd2 && mem_regWr == 1 && (mem_rw == ex_rs || mem_rw == ex_rt))
		alu3 = mem_HL;
end

endmodule
