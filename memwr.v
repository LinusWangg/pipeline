module mem_wr(clk,mem_dout,mem_HL,mem_result,mem_mult,mem_busA_mux2,mem_busB_mux2,mem_rw,mem_regWr,mem_multWr,mem_memtoreg,mem_op,mem_Lowin,mem_Highin,mem_cp0op,mem_cs,mem_sel,mem_cp0_dout,
	wr_dout,wr_HL,wr_result,wr_mult,wr_busA_mux2,wr_busB_mux2,wr_rw,wr_regWr,wr_multWr,wr_memtoreg,wr_op,wr_Lowin,wr_Highin,wr_cp0op,wr_cs,wr_sel,wr_cp0_dout);
input wire clk;
input wire[31:0] mem_dout,mem_result,mem_HL,mem_busA_mux2,mem_cp0_dout,mem_busB_mux2;
input wire[63:0] mem_mult;
input wire[4:0] mem_rw,mem_cs;
input wire mem_regWr,mem_multWr,mem_Lowin,mem_Highin;
input wire[1:0] mem_memtoreg;
input wire[5:0] mem_op;
input wire[2:0] mem_cp0op,mem_sel;

output reg[31:0] wr_dout,wr_result,wr_HL,wr_busA_mux2,wr_cp0_dout,wr_busB_mux2;
output reg[63:0] wr_mult;
output reg[4:0] wr_rw,wr_cs;
output reg wr_regWr,wr_multWr,wr_Lowin,wr_Highin;
output reg[1:0] wr_memtoreg;
output reg[5:0] wr_op;
output reg[2:0] wr_cp0op,wr_sel;

initial begin
	wr_dout = 32'd0;
	wr_result = 32'd0;
	wr_HL = 32'd0;
	wr_rw = 5'd0;
	wr_regWr = 0;
	wr_multWr = 0;
	wr_memtoreg = 2'd0;
	wr_op = 6'd0;
	wr_busA_mux2 = 32'd0;
	wr_Lowin = 0;
	wr_Highin = 0;
	wr_cp0op = 3'd0;
	wr_sel = 3'd0;
	wr_cs = 5'd0;
	wr_cp0_dout = 32'd0;
	wr_busB_mux2 = 32'd0;
	wr_mult = 64'd0;
end


always@(posedge clk)
begin
	wr_dout = mem_dout;
	wr_HL = mem_HL;
	wr_result = mem_result;
	wr_mult = mem_mult;
	wr_rw = mem_rw;
	wr_regWr = mem_regWr;
	wr_multWr = mem_multWr;
	wr_memtoreg = mem_memtoreg;
	wr_op = mem_op;
	wr_busA_mux2 = mem_busA_mux2;
	wr_Lowin = mem_Lowin;
	wr_Highin = mem_Highin;
	wr_cp0op = mem_cp0op;
	wr_sel = mem_sel;
	wr_cs = mem_cs;
	wr_cp0_dout = mem_cp0_dout;
	wr_busB_mux2 = mem_busB_mux2;
end
endmodule

