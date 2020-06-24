module dm_4k(
	clk,
	op,
	WrEn,
	Addr,
	DataIn,
	DataOut
);

input wire clk,WrEn;
input wire[11:0] Addr;
input wire[5:0] op;
input wire[31:0] DataIn;
output reg[31:0] DataOut;

reg[31:0] dm[1023:0];
integer i;
initial begin
	for(i=0;i<1024;i=i+1)
		dm[i]=0;
end
always@(*) begin
	DataOut = dm[Addr[11:2]];
end

always@(negedge clk) begin
	if(WrEn)
		begin
		if(op == 6'b101000)
		begin
		if(Addr[1:0] == 2'b00) begin
			dm[Addr[11:2]][7:0] = DataIn[7:0];
			$display("%h->dm[%h][7:0]",DataIn[7:0],Addr[11:0]);
		end
		else if(Addr[1:0] == 2'b01) begin
			dm[Addr[11:2]][15:8] = DataIn[7:0];
			$display("%h->dm[%h][15:8]",DataIn[7:0],Addr[11:0]);
		end
		else if(Addr[1:0] == 2'b10) begin
			dm[Addr[11:2]][23:16] = DataIn[7:0];
			$display("%h->dm[%h][23:16]",DataIn[7:0],Addr[11:0]);
		end
		else if(Addr[1:0] == 2'b11)
			dm[Addr[11:2]][31:24] = DataIn[7:0];
			$display("%h->dm[%h][31:24]",DataIn[7:0],Addr[11:0]);
		end
		else
		begin
			dm[Addr[11:2]] = DataIn;
			$display("%h->dm[%h]",DataIn,Addr[11:0]);
		end
		end
end
endmodule

	
