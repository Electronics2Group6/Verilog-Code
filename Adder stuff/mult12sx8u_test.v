`define clkperiodby2 5
`include "mult12sx8u.v"

module mult12sx8u_test (dctq);
  
  output [8:0] dctq;
  
  reg clk;
  reg [11:0] n1;
  reg [7:0]  n2;
  
  mult12sx8u u1(.clk(clk), .n1(n1), .n2(n2), .dctq(dctq));
  
  initial
  begin
    clk = 1'b0;
    n1 = 11'h0;
    n2 = 8'h0;
    
    #7 n1 = 12'h555;
       n2 = 8'h55;
    
    #10 n1 = 12'haaa;
        n2 = 8'haa;
    #10 n1 = 12'hfff;
        n2 = 8'h80;
    #10 n1 = 12'h555;
        n2 = 8'hff;
        
    #10 n1 = 12'hfff;
        n2 = 8'h00;
    #10 n1 = 12'h555;
        n2 = 8'h81;
    #10 n1 = 12'haaa;
        n2 = 8'h81;
    #10 n1 = 12'hfff;
        n2 = 8'h00;
    #10 n1 = 12'hfff;
        n2 = 8'hff;
        
    #10 n1 = 12'h000;
        n2 = 8'hff;
    #10 n1 = 12'h7ff;
        n2 = 8'hff;
    #10 n1 = 12'h800;
        n2 = 8'hff;
    #10 n1 = 12'h7ff;
        n2 = 8'h01;
    #10 n1 = 12'h800;
        n2 = 8'h01;
    #200
    $stop;
  end
  always
    #`clkperiodby2 clk <= ~clk;
endmodule