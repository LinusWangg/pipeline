module ex_mem(clk,ex_zero,ex_HL,ex_result,ex_mult,ex_busA_mux2,ex_busB,ex_rw,ex_regWr,ex_multWr,ex_memwr,ex_memtoreg,ex_op,ex_Lowin,ex_Highin,mem_zero,mem_HL,mem_result,mem_mult,mem_busA_mux2,mem_busB,mem_rw,mem_regWr,mem_multWr,mem_memwr,mem_memtoreg,mem_op,mem_Lowin,mem_Highin);

input wire clk;
input wire ex_zero;
input wire[31:0] ex_result,ex_busB,ex_HL,ex_busA_mux2;
input wire[63:0] ex_mult;
input wire[4:0] ex_rw;
input wire ex_regWr,ex_memwr,ex_multWr,ex_Lowin,ex_Highin;
input wire[1:0] ex_memtoreg;
input wire[5:0] ex_op;

output reg mem_zero;
output reg[31:0] mem_result,mem_busB,mem_HL,mem_busA_mux2;
output reg[63:0] mem_mult;
output reg[4:0] mem_rw;
output reg mem_regWr,mem_memwr,mem_multWr,mem_Lowin,mem_Highin;
output reg[1:0] mem_memtoreg;
output reg[5:0] mem_op;


initial begin
	mem_zero = 0;
	mem_result = 32'd0;
	mem_busB = 32'd0;
	mem_HL = 32'd0;
	mem_rw = 5'd0;
	mem_regWr = 0;
	mem_multWr = 0;
	mem_memwr = 0;
	mem_memtoreg = 2'd0;
	mem_op = 6'd0;
	mem_busA_mux2 = 32'd0;
	mem_Lowin = 0;
	mem_Highin = 0;
end

always@(posedge clk)
begin
	mem_HL = ex_HL;
	mem_result = ex_result;
	mem_mult = ex_mult;
	mem_zero = ex_zero;
	mem_busB = ex_busB;
	mem_rw = ex_rw;
	mem_regWr = ex_regWr;
	mem_multWr = ex_multWr;
	mem_memwr = ex_memwr;
	mem_memtoreg = ex_memtoreg;
	mem_op = ex_op;
	mem_busA_mux2 = ex_busA_mux2;
	mem_Lowin = ex_Lowin;
	mem_Highin = ex_Highin;
end

endmodule
