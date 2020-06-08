`timescale 1ns / 1ps
module SignExt(
	immediate,
	ExtSel,
	Extimmediate
);

input wire[15:0] immediate;
input ExtSel;

output [31:0] Extimmediate;

always@(Extimmediate)
begin
	
end

assign Extimmediate[15:0] = immediate;
assign Extimmediate[31:16] = ExtSel ? (immediate[15] ? 16'hffff : 16'h0000) : 16'h0000;

endmodule
