module CP0(clk,id_cs,id_sel,wr_cs,wr_sel,busB,PC,cp0_dout,cp0_pcout,wr_cp0op,id_cp0op);
input wire clk;
input wire[4:0] id_cs,wr_cs;
input wire[2:0] id_sel,wr_sel,wr_cp0op,id_cp0op;
input wire[31:0] busB;
input wire[29:0] PC;
output reg[31:0] cp0_dout,cp0_pcout;

reg[31:0] cp0[0:255];

integer i;
initial begin
	for(i=0;i<=255;i=i+1)
		cp0[i]=0;
	cp0_dout = 32'd0;
	cp0_pcout = 30'd0;
end

always@(negedge clk) begin
	if(wr_cp0op == 3'b010)
		cp0[{wr_cs,wr_sel}] = busB;
end

always@(*) begin
	if(id_cp0op == 3'b001)
		cp0_dout = cp0[{id_cs,id_sel}];
	if(id_cp0op == 3'b011) begin
		cp0[112] = {PC,2'b0};
		cp0[104][6:2] = 5'b01000;
		cp0[96][1] = 1;
	end

	if(id_cp0op == 3'b100)  begin
		cp0[96][1] = 0;
	end

	cp0_pcout = cp0[112];
end

endmodule
