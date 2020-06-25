module HLforward(ex_Highin,ex_Lowin,mem_Highin,mem_Lowin,wr_Highin,wr_Lowin,forwardHigh,forwardLow);

input wire ex_Highin,mem_Highin,wr_Highin,ex_Lowin,mem_Lowin,wr_Lowin;
output reg[1:0] forwardHigh,forwardLow;

initial begin
	forwardHigh = 2'b00;
	forwardLow = 2'b00;
end

always@(*) begin
	if(ex_Highin == 1)
		forwardHigh = 2'b01;
	else if(mem_Highin == 1)
		forwardHigh = 2'b10;
	else if(wr_Highin == 1)
		forwardHigh = 2'b11;
	else
		forwardHigh = 2'b00;

	if(ex_Lowin == 1)
		forwardLow = 2'b01;
	else if(mem_Lowin == 1)
		forwardLow = 2'b10;
	else if(wr_Lowin == 1)
		forwardLow = 2'b11;
	else
		forwardLow = 2'b00;
end

endmodule
