module regfile(
	clk,
	rs,
	rt,
	rw,
	op,
	cp0op,
	cp0_dout,
	addr,
	regWe,
	r31We,
	multWe,
	r31,
	Lowin,
	Highin,
	busW,
	busmult,
	busA,
	busB,
	Highout,
	Lowout,
	jalpc
);

input wire clk,regWe,r31We,multWe,Highin,Lowin;
input wire[2:0] cp0op;
input wire[4:0] rs,rt,rw;
input wire[5:0] op;
input wire[11:0] addr;
input wire[31:0] busW,cp0_dout;
input wire[63:0] busmult;
input wire[29:0] r31;
output reg[31:0] busA,busB,Highout,Lowout;
output reg[29:0] jalpc;

reg [31:0]registers[31:0];
reg [31:0]High;
reg [31:0]Low;
integer i;
initial begin
	for(i=0;i<32;i=i+1)
		registers[i]=0;
	High=0;
	Low=0;
end

always@(*) begin
	busA = registers[rs];
	busB = registers[rt];
	jalpc = registers[rs][31:2];
	Highout = High[31:0];
	Lowout = Low[31:0];
end

always@(negedge clk) begin
	if(regWe)
	begin
		registers[rw] = busW;
		$display("%h->reg[%d]",busW,rw);
	end
	if(r31We) begin
		registers[31] = {r31,2'b0};
		$display("%h->reg[31]",{r31,2'b0});
	end
	if(multWe)
	begin
		High = busmult[63:32];
		Low = busmult[31:0];
		$display("%h->Hign",busmult[63:32]);
		$display("%h->Low",{{24'b0},busmult[31:0]});
	end
	if(Highin)
	begin
		High = busW;
		$display("%h->Hign",busW);
	end
	if(Lowin)
	begin
		Low = busW;
		$display("%h->Low",busW);
	end
	if(cp0op == 3'b001)
	begin
		registers[rw] = cp0_dout;
		$display("%h->reg[%d]",cp0_dout,rw);
	end
end

endmodule
