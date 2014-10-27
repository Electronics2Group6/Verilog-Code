define clkperiodby2 5 // Required to generate 100 MHz clock.
//`include ‘romc_banno.v’ // Design file is romc.v and back annotated file is
// romc_banno.v
module romc_test ( 	dout1,
					          dout2
					        );
output 	[63:0] 	dout1;
output 	[63:0] 	dout2;
reg 			      clk;
reg 	  [2:0] 	addr1;
reg 	  [2:0] 	addr2;

romc romc1(
		.clk(clk),
		.addr1(addr1),
		.addr2(addr2),
		.dout1(dout1),
		.dout2(dout2)
			    );

initial
begin
	clk = 1'b0 ;
	// Read the ROM contents for all combinations of addresses.
	#7 		addr1 = 3'b000;
			  addr2 = 3'b111;
	#10 	addr1 = 3'b001;
			  addr2 = 3'b110;
	#10 	addr1 = 3'b010;
			  addr2 = 3'b101;
	#10 	addr1 = 3'b011;
			  addr2 = 3'b100;
	#10 	addr1 = 3'b100;
			  addr2 = 3'b011;
	#10 	addr1 = 3'b101;
			  addr2 = 3'b010;
	#10 	addr1 = 3'b110;
			  addr2 = 3'b001;
	#10 	addr1 = 3'b111;
			  addr2 = 3'b000;
	#40 					// Run for some more time
 $stop; 					// before stopping the simulation.
end

always
 #`clkperiodby2 clk <= ~clk; // Generate 100 MHz clock.
endmodule
