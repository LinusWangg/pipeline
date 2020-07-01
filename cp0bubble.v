module cp0bubble(clk,id_cp0op,ex_cs,ex_sel,ex_cp0op,mem_cs,mem_sel,mem_cp0op,wr_cs,wr_sel,wr_cp0op,cp0bubble);
input wire[2:0] id_cp0op,ex_sel,mem_sel,wr_sel,ex_cp0op,mem_cp0op,wr_cp0op;
input wire[4:0] ex_cs,mem_cs,wr_cs;
input wire clk;

output reg [1:0]cp0bubble;

always@(*) begin
	if(id_cp0op == 3'b011 && ex_cp0op == 3'b010 && ex_sel == 0 && ex_cs == 14)
		cp0bubble = 1;
	else if(id_cp0op == 3'b011 && mem_cp0op == 3'b010 && mem_sel == 0 && mem_cs == 14)
		cp0bubble = 2;
	else if(id_cp0op == 3'b011 && wr_cp0op == 3'b010 && wr_sel == 0 && wr_cs == 14)
		cp0bubble = 3;
	else 
		cp0bubble = 0;
end

endmodule
