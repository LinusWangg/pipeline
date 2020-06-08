`timescale 1ns/1ps
module test_counter;
	reg clk,rst;
initial begin
	rst = 1;
	clk = 0;
	#2 rst = 0;
end

always begin
	#1 clk = ~clk; 
end
mips mips(
	clk,
	rst
);
endmodule
