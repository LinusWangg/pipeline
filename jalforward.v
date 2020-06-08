module jalforward(id_ra,ex_rw,ex_regWr,ex_result,mem_rw,mem_regWr,mem_result,wr_rw,wr_regWr,wr_result,jalforward);
	input wire[4:0] id_ra,ex_rw,mem_rw,wr_rw;
	input wire ex_regWr,mem_regWr,wr_regWr;
	input wire[31:0] ex_result,mem_result,wr_result;
	output reg[1:0] jalforward;

initial begin
	jalforward = 2'b00;
end

always@(*) begin
	if(id_ra==ex_rw&&ex_regWr==1)
		jalforward = 2'b01;
	else if(id_ra==mem_rw&&mem_regWr==1)
		jalforward = 2'b10;
	else if(id_ra==wr_rw&&wr_regWr==1)
		jalforward = 2'b11;
	else
		jalforward = 2'b00;
end

endmodule

		
