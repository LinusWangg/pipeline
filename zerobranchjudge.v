module branchjudge(busA,bgez,bgtz,blez,bltz,zbgez,zbgtz);
	input wire[31:0] busA;
	input wire bgtz,bgez,blez,bltz;
	output reg zbgez,zbgtz;

initial begin
	zbgez = 0;
	zbgtz = 0;
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
end

endmodule

