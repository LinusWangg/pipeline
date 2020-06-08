module regfile(
	clk,
	rs,
	rt,
	rw,
	op,
	addr,
	regWe,
	r31We,
	r31,
	busW,
	busA,
	busB,
	jalpc
);

input wire clk,regWe,r31We;
input wire[4:0] rs,rt,rw;
input wire[5:0] op;
input wire[11:0] addr;
input wire[31:0] busW;
input wire[29:0] r31;
output reg[31:0] busA,busB;
output reg[29:0] jalpc;

reg [31:0]registers[31:0];
integer i;
initial begin
	for(i=0;i<32;i=i+1)
		registers[i]=0;
end

always@(*) begin
	busA = registers[rs];
	busB = registers[rt];
	jalpc = registers[rs][31:2];
end

always@(negedge clk) begin
	if(regWe)
	begin
		case(op)
		6'b100000:  //lb
		begin
		if(addr[1:0] == 2'b00)
			registers[rw] = {{24{busW[7]}},busW[7:0]};
		else if(addr[1:0] == 2'b01)
			registers[rw] = {{24{busW[15]}},busW[15:8]};
		else if(addr[1:0] == 2'b10)
			registers[rw] = {{24{busW[23]}},busW[23:16]};
		else if(addr[1:0] == 2'b11)
			registers[rw] = {{24{busW[31]}},busW[31:24]};
		end
		6'b100100:  //lbu
		begin
		if(addr[1:0] == 2'b00)
			registers[rw] = {{24'b0},busW[7:0]};
		else if(addr[1:0] == 2'b01)
			registers[rw] = {{24'b0},busW[15:8]};
		else if(addr[1:0] == 2'b10)
			registers[rw] = {{24'b0},busW[23:16]};
		else if(addr[1:0] == 2'b11)
			registers[rw] = {{24'b0},busW[31:24]};
		end
		default:  //lw
		begin
			registers[rw] = busW;
		end
		endcase
	end
	if(r31We)
		registers[31] = {r31,2'b0};
end

endmodule
