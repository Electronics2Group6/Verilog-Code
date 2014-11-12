`define clkperiodby2 5
`include "mult8ux8s.v"

module mult8ux8s_test (result);
  
  output [15:0] result;
  
  reg clk;
  reg [11:0] n1;
  reg [7:0]  n2;
  
  mult8ux8s u1(.clk(clk), .n1(n1), .n2(n2), .result(result));
  
  initial
  begin
    clk = 1'b0;
    n1 = 8'h0;
    n2 = 8'h0;
    
    #17 n1 = 8'h55;
        n2 = 8'h55;
    
    #20 n1 = 8'haa;
        n2 = 8'haa;
    #20 n1 = 8'hff;
        n2 = 8'h80;
    #20 n1 = 8'h55;
        n2 = 8'hff;
        
    #20 n1 = 8'hff;
        n2 = 8'h81;
    #20 n1 = 8'h55;
        n2 = 8'h81;
    #20 n1 = 8'haa;
        n2 = 8'h81;
    #20 n1 = 8'hff;
        n2 = 8'h00;
		
    #20 n1 = 8'hff;
        n2 = 8'h7f;
    #20 n1 = 8'h00;
        n2 = 8'hff;
    #20 n1 = 8'h00;
        n2 = 8'h7f;
    #20 n1 = 8'h00;
        n2 = 8'h7f;
    #20 n1 = 8'h00;
        n2 = 8'h7f;
    #400
    $stop;
  end
  always
    #`clkperiodby2 clk <= ~clk;
endmodule
