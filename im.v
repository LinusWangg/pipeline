module im_4k(
	addr,
	dout
);

input wire[11:2] addr;

output wire[31:0] dout;

reg [31:0] im [1023:0];

initial begin
	$readmemh("test.txt",im);
end

assign dout = im[addr];

endmodule
