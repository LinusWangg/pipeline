module HazardUnit(ex_memtoreg,ex_regWr,ex_rw,id_ra,id_rb,hazard);

input wire ex_regWr;
input wire[1:0] ex_memtoreg;
input wire[4:0] ex_rw,id_ra,id_rb;

output reg hazard;

initial begin
	hazard = 0;
end

always@(*) begin
	if(ex_memtoreg == 1 && ex_regWr == 1 && ex_rw != 0 && (ex_rw == id_rb || ex_rw == id_ra))
		assign hazard = 1;
	else
		assign hazard = 0;
end

endmodule

