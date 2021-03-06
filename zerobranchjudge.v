module branchjudge(busA,busB,bgez,bgtz,blez,bltz,branch_beq,branch_bne,zbgez,zbgtz,zbeq,zbne);
	input wire[31:0] busA,busB;
	input wire bgtz,bgez,blez,bltz,branch_beq,branch_bne;
	output reg zbgez,zbgtz,zbeq,zbne;

initial begin
	zbgez = 0;
	zbgtz = 0;
	zbeq = 0;
	zbne = 0;
end

always@(*) begin
	if(bgez == 1) begin
		zbgez = (busA[31]==0);
	end
	else if(bgtz == 1) begin
		zbgtz = (busA!=32'b0&&busA[31]==0);
	end
	else if(blez == 1) begin
		zbgtz = !(busA[31]==1||busA==32'b0);
	end
	else if(bltz == 1) begin
		zbgez = !(busA[31]==1);
	end
	else if(branch_beq == 1) begin
		zbeq = (busA==busB);
	end
	else if(branch_bne == 1) begin
		zbne = (busA!=busB);
	end
end

endmodule

