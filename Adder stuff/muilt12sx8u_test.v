`define clkperiodby2 5

`include "mult8ux8s.v"

module mult8uxus_test(result);

output [15:0] result;

reg clk;
reg [7:0] n1;
reg [7:0] n2;

mult8ux8s u1(
				.clk(clk),
				.n1(n1),
				.n2(n2),
				.result(result)
			);
			
initial
begin

	$monitor ("time: %t, n1=%d, n2=%d,result=%d",$time,
	n1,n2,result);
	
	
	clk = 1'b0;
	n1 = 8'h0;
	n2 = 8'h0;
	
	#17 n1 = 8'h55;
		n2 = 8'h55;
	
	#10 n1 = 8'haa;
		n2 = 8'haa;	
	#10 n1 = 8'hff;
		n2 = 8'h80;
	#10 n1 = 8'h55;
		n2 = 8'hff;
	
	#10 n1 = 8'hff;
		n2 = 8'h81;
	#10 n1 = 8'h55;
		n2 = 8'h81;
	#10 n1 = 8'haa;
		n2 = 8'h81;
	#10 n1 = 8'hff;
		n2 = 8'h00;
	
	#10 n1 = 8'hff;
		n2 = 8'h7f;
	#10 n1 = 8'h00;
		n2 = 8'hff;
	#10 n1 = 8'h00;
		n2 = 8'h7f;
	#10 n1 = 8'h00;
		n2 = 8'h7f;
	#10 n1 = 8'h00;
		n2 = 8'h7f;
	
	#200
	
	$stop;
end

always
	#`clkperiodby2 clk <= ~clk;

endmodule