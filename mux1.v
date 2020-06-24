module mux_memtoreg(result,Dataout,memtoreg,busW);
	input wire memtoreg;
	input wire[31:0] result,Dataout;
	output wire[31:0] busW;

	assign busW=(memtoreg==0)?result:Dataout;
endmodule

module mux_rw(rt,rd,regDst,rw);
	input wire[4:0] rt,rd;
	input wire regDst;
	output wire[4:0] rw;

	assign rw=(regDst==0)?rt:rd;
endmodule

module mux3(result,C1,C2,s,y);
	input wire[31:0] result,C1,C2;
	input wire[1:0] s;
	output wire[31:0] y;

	assign y=(s==2'b00)?result:(s==2'b01)?C1:C2;
endmodule

module mux4(C1,C2,C3,C4,s,y);
	input wire[31:0] C1,C2,C3,C4;
	input wire[1:0] s;
	output wire[31:0] y;

	assign y=(s==2'b00)?C1:(s==2'b01)?C2:(s==2'b10)?C3:C4;
endmodule

module mux4pc(C1,C2,C3,C4,s,y);
	input wire[29:0] C1,C2,C3,C4;
	input wire[1:0] s;
	output wire[29:0] y;

	assign y=(s==2'b00)?C1:(s==2'b01)?C2:(s==2'b10)?C3:C4;
endmodule

module muxHL(C1,C2,C3,C4,s,hlsel,y);
	input wire[31:0] C1;
	input wire[63:0] C2,C3,C4;
	input wire[1:0] s;
	input wire hlsel;
	output reg[31:0] y;

	always@(*) begin
	if(s==0)
		y=C1;
	else if(s==2'b01&&hlsel==0)
		y=C2[31:0];
	else if(s==2'b01&&hlsel==1)
		y=C2[63:32];
	else if(s==2'b10&&hlsel==0)
		y=C3[31:0];
	else if(s==2'b10&&hlsel==1)
		y=C3[63:32];
	else if(s==2'b11&&hlsel==0)
		y=C4[31:0];
	else if(s==2'b11&&hlsel==1)
		y=C4[63:32];
	end
endmodule

