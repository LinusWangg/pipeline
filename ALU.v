module alu(
	checkover,
	pc,
	aluop,
	shamt,
	DataA,
	DataB,
	zero,
	overflow,
	result,
	mult,
);

input wire[4:0] aluop;
input wire[4:0] shamt;
input wire[31:0] DataA;
input wire[31:0] DataB;
input wire[29:0] pc;
input wire checkover;
output reg zero,overflow;
output reg[31:0] result;
output reg[63:0] mult;
reg Cout;

always@(aluop or DataA or DataB) begin
	case(aluop)
		5'b00000: begin  //add
		result = DataA + DataB;
		Cout = DataA[31]&DataB[31];
		zero = (result == 0)?1:0;
		overflow = checkover&(Cout^result[31]);
		end
		5'b00001: begin  //sub
		result = DataA - DataB;
		Cout = DataA[31]&DataB[31];
		zero = (result == 0)?1:0;
		overflow = checkover&(Cout^result[31]);
		end
		5'b00010: begin  //slt
		result = (DataA < DataB)?1:0;
		zero = (result == 0)?1:0;
		end
		5'b00011: begin  //and
		result = DataA & DataB;
		zero = (result == 0)?1:0;
		end
		5'b00100: begin  //nor
		result = ~(DataA | DataB);
		zero = (result == 0)?1:0;
		end
		5'b00101: begin  //or
		result = DataA | DataB;
		zero = (result == 0)?1:0;
		end
		5'b00110: begin  //xor
		result = DataA ^ DataB;
		zero = (result == 0)?1:0;
		end
		5'b00111: begin  //sll
		result = DataB << shamt;
		zero = (result == 0)?1:0;
		end
		5'b01000: begin  //srl
		result = DataB >> shamt;
		zero = (result == 0)?1:0;
		end
		5'b01001: begin  //sltu
		result = (DataA < DataB)?1:0;
		zero = (result == 0)?1:0;
		end
		5'b01010: begin  //jalr
		result = {pc,{2'b00}};
		zero = (result == 0)?1:0;
		end
		5'b01011: begin  //jr
		end
		5'b01100: begin  //sllv
		result = DataB << DataA;
		zero = (result == 0)?1:0;		
		end
		5'b01101: begin  //sra
		result = ($signed(DataB)) >>> shamt;
		zero = (result == 0)?1:0;		
		end
		5'b01110: begin  //srav
		result = ($signed(DataB)) >>> DataA;
		zero = (result == 0)?1:0;		
		end
		5'b01111: begin  //srlv
		result = DataB >> DataA;
		zero = (result == 0)?1:0;		
		end
		5'b10000: begin  //lui
		result = DataB * 65536;
		zero = (result == 0)?1:0;
		end
		5'b10001: begin  //mult
		mult = ($signed(DataA)) * ($signed(DataB));
		zero = (mult == 0)?1:0;
		end
	endcase
end
endmodule
