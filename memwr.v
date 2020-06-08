module mem_wr(clk,mem_dout,mem_result,mem_rw,mem_regWr,mem_memtoreg,mem_op,wr_dout,wr_result,wr_rw,wr_regWr,wr_memtoreg,wr_op);
input wire clk;
input wire[31:0] mem_dout,mem_result;
input wire[4:0] mem_rw;
input wire mem_regWr,mem_memtoreg;
input wire[5:0] mem_op;

output reg[31:0] wr_dout,wr_result;
output reg[4:0] wr_rw;
output reg wr_regWr,wr_memtoreg;
output reg[5:0] wr_op;

initial begin
	wr_dout = 32'd0;
	wr_result = 32'd0;
	wr_rw = 5'd0;
	wr_regWr = 0;
	wr_memtoreg = 0;
	wr_op = 6'd0;
end

always@(posedge clk)
begin
	wr_dout = mem_dout;
	wr_result = mem_result;
	wr_rw = mem_rw;
	wr_regWr = mem_regWr;
	wr_memtoreg = mem_memtoreg;
	wr_op = mem_op;
end
endmodule

