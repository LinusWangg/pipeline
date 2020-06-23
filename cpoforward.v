module cp0forwardUnit(id_cp0op,id_cs,id_sel,ex_cs,ex_sel,ex_cp0op,mem_cs,mem_sel,mem_cp0op,wr_cs,wr_sel,wr_cp0op,cp0forward);
input wire[2:0] id_cp0op,ex_cp0op,mem_cp0op,wr_cp0op,id_sel,ex_sel,mem_sel,wr_sel;
input wire[4:0] id_cs,ex_cs,mem_cs,wr_cs;
output reg[1:0] cp0forward;

initial begin
	cp0forward = 2'b00;
end

always@(*) begin
	if((id_cp0op==3'b001&&ex_cp0op==3'b010&&id_cs==ex_cs&&id_sel==ex_sel)||(id_cp0op==3'b100&&ex_cp0op==3'b010&&id_cs==14&&id_sel==0))
		cp0forward = 2'b01;
	else if((id_cp0op==3'b001&&mem_cp0op==3'b010&&id_cs==mem_cs&&id_sel==mem_sel)||(id_cp0op==3'b100&&mem_cp0op==3'b010&&id_cs==14&&id_sel==0))
		cp0forward = 2'b10;
	else if((id_cp0op==3'b001&&wr_cp0op==3'b010&&id_cs==wr_cs&&id_sel==wr_sel)||(id_cp0op==3'b100&&wr_cp0op==3'b010&&id_cs==14&&id_sel==0))
		cp0forward = 2'b11;
	else
		cp0forward = 2'b00;
end

endmodule
