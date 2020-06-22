module multforward(id_multWr,ex_multWr,mem_multWr,wr_multWr,multforward);

input wire id_multWr,ex_multWr,mem_multWr,wr_multWr;
output reg[1:0] multforward;

initial begin
	multforward = 2'd0;
end

always@(*) begin
	if(ex_multWr == 1)
		multforward = 2'b01;
	else if(mem_multWr == 1)
		multforward = 2'b10;
	else if(wr_multWr == 1)
		multforward = 2'b11;
	else
		multforward = 2'b00;
end
endmodule
