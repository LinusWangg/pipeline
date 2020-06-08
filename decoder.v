module decoder(
	ir,
	op,
	rs,
	rt,
	rd,
	shamt,
	func,
	immediate,
	target
);

input wire[31:0] ir;
output reg[5:0] op;
output reg[4:0] rs;
output reg[4:0] rt;
output reg[4:0] rd;
output reg[4:0] shamt;
output reg[5:0] func;
output reg[15:0] immediate;
output reg[25:0] target;

initial begin
	op = 6'b000000;
	rs = 5'b00000;
	rt = 5'b00000;
	rd = 5'b00000;
end

always@(*)
begin
	op = ir[31:26];
	rs = ir[25:21];
	rt = ir[20:16];
	rd = ir[15:11];
	shamt = ir[10:6];
	func = ir[5:0];
	immediate = ir[15:0];
	target = ir[25:0];
end

endmodule

