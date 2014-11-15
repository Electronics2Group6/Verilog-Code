`define clkperiodby2 10
`define clkby2 10
`include "dualram.v" // This is the design file.
module dualram_test ( dout // Declare the module.
) ;
output [63:0] dout ; // Declare the output.
reg clk ; // Declare the input signals.
reg pci_clk ;
reg rnw ;
reg din_valid ;
reg [7:0] be ;
reg [2:0] ra, wa ;
reg [63:0] di ;
dualram u1 ( // Invoke the design
	.clk(clk), // calling ports by name.
	.pci_clk(pci_clk),
	.rnw(rnw),
	.be(be),
	.ra(ra),
	.wa(wa),
	.di(di),
	.din_valid(din_valid),
	.dout(dout)
);
initial // Apply stimulants.
begin
	clk = 1'b0 ;
	pci_clk = 1'b0 ;
	rnw = 1'b0 ;
	din_valid = 1'b1 ; // Change to 1'b0 if write is to be inhibited.
	be = 8'h00; // Change “0” to “1” if byte write is to
	// be inhibited.
	wa = 3'd0; di = 64'h0 ;
	#17 wa = 3'd1; di = 64'h123456789abcdef0 ;
	// Write first block of data into ram1.
	#20 wa = 3'd2; di = 64'h7E6A4719E7B99682 ;
	#20 wa = 3'd3; di = 64'h7631CF8A8ACF3176 ;
	#20 wa = 3'd4; di = 64'h6AE782B9477E1996 ;
	#20 wa = 3'd5; di = 64'h5BA5A55B5BA5A55B ;
	#20 wa = 3'd6; di = 64'h4782196A96E77EB9 ;
	#20 wa = 3'd7; di = 64'h318A76CFCF768A31 ;
	#80 rnw = 1'b1 ; // Switch the roles of the RAM banks.
	ra = 3'd0; wa = 3'd0; di = 64'h5BA5A55B5BA5A55B ;
	// Write second block of data into ram2.
	// Simultaneously read from ram1.
	#20 ra = 3'd1; wa = 3'd1; di = 64'h4782196A96E77EB9 ;
	#20 ra = 3'd2; wa = 3'd2; di = 64'h318A76CFCF768A31 ;
	#20 ra = 3'd3; wa = 3'd3; di = 64'h19B96A827E9647E7 ;
	#20 ra = 3'd4; wa = 3'd4; di = 64'h7E6A4719E7B99682 ;
	#20 ra = 3'd5; wa = 3'd5; di = 64'h7631CF8A8ACF3176 ;
	#20 ra = 3'd6; wa = 3'd6; di = 64'h6AE782B9477E1996 ;
	#20 ra = 3'd7; wa = 3'd7; di = 64'h5BA5A55B5BA5A55B ;
	#80 rnw = 1'b0 ; ra = 3'd0; wa = 3'd0; di = 64'haa5500ff0055aaff ;
	// Write third block of data into ram1
	// and simultaneously read from ram2.
	#20 ra = 3'd1; wa = 3'd1; di = 64'h4782196A96E77EB9 ;
	#20 ra = 3'd2; wa = 3'd2; di = 64'h318A76CFCF768A31 ;
	#20 ra = 3'd3; wa = 3'd3; di = 64'h19B96A827E9647E7 ;
	#20 ra = 3'd4; wa = 3'd4; di = 64'h7E6A4719E7B99682 ;
	#20 ra = 3'd5; wa = 3'd5; di = 64'h7631CF8A8ACF3176 ;
	#20 ra = 3'd6; wa = 3'd6; di = 64'h6AE782B9477E1996 ;
	#20 ra = 3'd7; wa = 3'd7; di = 4'h5BA5A55B5BA5A55B ;
	#80 rnw = 1'b1 ; ra = 'd0; wa = 3'd0; di = 64'h0;
	// Switch the roles of the RAM banks again.
	// Write fourth block of data into ram2 and
	// simultaneously read from ram1.
	#20 ra = 3'd1; wa = 3'd1; di = 64'h123456789abcdef0;
	#20 ra = 3'd2; wa = 3'd2; di = 64'h7E6A4719E7B99682 ;
	#20 ra = 3'd3; wa = 3'd3; di = 64'h7631CF8A8ACF3176 ;
	#20 ra = 3'd4; wa = 3'd4; di = 64'h6AE782B9477E1996 ;
	#20 ra = 3'd5; wa = 3'd5; di = 64'h5BA5A55B5BA5A55B ;
	#20 ra = 3'd6; wa = 3'd6; di = 64'h4782196A96E77EB9 ;
	#20 ra = 3'd7; wa = 3'd7; di = 64'h318A76CFCF768A31 ;
	#80 rnw = 0 ; ra = 3'd0; // Read fourth block of data from ram2.
	#20 ra = 3'd1;
	#20 ra = 3'd2;
	#20 ra = 3'd3;
	#20 ra = 3'd4;
	#20 ra = 3'd5;
	#20 ra = 3'd6;
	#20 ra = 3'd7;
	#100
	$stop ; // Stop testing after a while.
end
// Run the clocks.
always
	#`clkperiodby2 clk <= ~clk ;
always
	#`clkby2 pci_clk <= ~pci_clk ;
endmodule
