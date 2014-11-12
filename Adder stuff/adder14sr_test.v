`define clkperiodby2 5
`include "adder14sr.v"

module adder14sr_test (dct) ;

output 	[11:0] 	dct ;

reg 			clk;
reg 	[13:0] 	n0, n1, n2, n3, n4, n5, n6, n7 ;

adder14sr u1(
				.clk(clk),
				.n0(n0),
				.n1(n1),
				.n2(n2),
				.n3(n3),
				.n4(n4),
				.n5(n5),
				.n6(n6),
				.n7(n7),
				.dct(dct)
			) ;
			
initial

begin

	clk = 1'b0 ;
	n0 = 14'h0 ;
	n1 = 14'h0 ;
	n2 = 14'h0 ;
	n3 = 14'h0 ;
	n4 = 14'h0 ;
	n5 = 14'h0 ;
	n6 = 14'h0 ;
	n7 = 14'h0 ;
	
	#7	n0 = 14'h3fff ;
	n1 = 14'h3fff ;
	n2 = 14'h3fff ;
	n3 = 14'h3fff ;
	n4 = 14'h3fff ;
	n5 = 14'h3fff ;
	n6 = 14'h3fff ;
	n7 = 14'h3fff ;
	
	#10	n0 = 14'h1fff ;
	n1 = 14'h1fff ;
	n2 = 14'h1fff ;
	n3 = 14'h1fff ;
	n4 = 14'h1fff ;
	n5 = 14'h1fff ;
	n6 = 14'h1fff ;
	n7 = 14'h1fff ;
	
	#10	n0 = 14'h2000 ;
	n1 = 14'h2000 ;
	n2 = 14'h2000 ;
	n3 = 14'h2000 ;
	n4 = 14'h2000 ;
	n5 = 14'h2000 ;
	n6 = 14'h2000 ;
	n7 = 14'h2000 ;
	
	#10	n0 = 14'h0001 ;
	n1 = 14'h0001 ;
	n2 = 14'h0001 ;
	n3 = 14'h0001 ;
	n4 = 14'h0001 ;
	n5 = 14'h0001 ;
	n6 = 14'h0001 ;
	n7 = 14'h0001 ;
	
	#10 n0 = 14'h0001 ;
	n1 = 14'h3fff ;
	n2 = 14'h0001 ;
	n3 = 14'h3fff ;
	n4 = 14'h0001 ;
	n5 = 14'h3fff ;
	n6 = 14'h0001 ;
	n7 = 14'h3fff ;
	
	#10	n0 = 14'h1fff ;
	n1 = 14'h1fff ;
	n2 = 14'h1fff ;
	n3 = 14'h1fff ;
	n4 = 14'h2001 ;
	n5 = 14'h2001 ;
	n6 = 14'h2001 ;
	n7 = 14'h2001 ;
	
	#10	n0 = 14'h2aaa ;
	n1 = 14'h1555 ;
	n2 = 14'h2aaa ;
	n3 = 14'h1555 ;
	n4 = 14'h2aaa ;
	n5 = 14'h1555 ;
	n6 = 14'h2aaa ;
	n7 = 14'h1555 ;
	
	#10	n0 = 14'h0 ;
	n1 = 14'h0 ;
	n2 = 14'h0 ;
	n3 = 14'h0 ;
	n4 = 14'h0 ;
	n5 = 14'h0 ;
	n6 = 14'h0 ;
	n7 = 14'h0 ;
	
	#600
	
	$stop ;
	
end

always
	#`clkperiodby2 clk <= ~clk ;
	
endmodule
