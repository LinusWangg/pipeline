module ex_mem(clk,ex_zero,ex_result,ex_busB,ex_rw,ex_regWr,ex_memwr,ex_memtoreg,ex_op,mem_zero,mem_result,mem_busB,mem_rw,mem_regWr,mem_memwr,mem_memtoreg,mem_op);

input wire clk;
input wire ex_zero;
input wire[31:0] ex_result,ex_busB;
input wire[4:0] ex_rw;
input wire ex_regWr,ex_memwr,ex_memtoreg;
input wire[5:0] ex_op;

output reg mem_zero;
output reg[31:0] mem_result,mem_busB;
output reg[4:0] mem_rw;
output reg mem_regWr,mem_memwr,mem_memtoreg;
output reg[5:0] mem_op;


initial begin
	mem_zero = 0;
	mem_result = 32'd0;
	mem_busB = 32'd0;
	mem_rw = 5'd0;
	mem_regWr = 0;
	mem_memwr = 0;
	mem_memtoreg = 0;
	mem_op = 6'd0;
end

always@(posedge clk)
begin
	mem_result = ex_result;
	mem_zero = ex_zero;
	mem_busB = ex_busB;
	mem_rw = ex_rw;
	mem_regWr = ex_regWr;
	mem_memwr = ex_memwr;
	mem_memtoreg = ex_memtoreg;
	mem_op = ex_op;
end

endmodule