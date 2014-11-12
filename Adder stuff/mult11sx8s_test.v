`define clkperiodby2 10 // Simulate at 50 MHz. 
`include "mult11sx8s.v" // Back annotated design file. 
module mult11sx8s_test (result); 

  output [18:0] result ;  
  reg clk ; 
  reg [10:0] n1 ; 
  reg [7:0] n2 ; 

mult11sx8s u1( .clk(clk),  .n1(n1),  .n2(n2),  .result(result)  ); 
initial 
 begin // Apply several sets of inputs. 
 clk = 1'b0 ; 
 
 n1 = 11'h0 ; 
 n2 = 8'h0 ; 
 #7 n1 = 11'h555 ; // Not that the inputs are applied 
 n2 = 8'h55; // before the rising edge of ?clk?. 
 #10 n1 = 11'h2aa ; 
 n2 = 8'haa; 
 #10 n1 = 11'h7ff ; 
 n2 = 8'h80; 
 #10 n1 = 11'h555 ; 
 n2 = 8'hff; 
 #10 n1 = 11'h7ff ; 
 n2 = 8'h81; 
 #10 n1 = 11'h555 ; 
 n2 = 8'h81; 
 #10 n1 = 11'h2aa ; 
 n2 = 8'h81; 
 #10 n1 = 11'h7ff ; 
 n2 = 8'h00; 
 #10 n1 = 11'h7ff ; 
 n2 = 8'h7f; 
 #10 n1 = 11'h000 ; 
 n2 = 8'hff; 
 #10 n1 = 11'h000 ; 
 n2 = 8'h7f; 
 #200 
 
 $stop ; 
end 

always 
 #`clkperiodby2 clk <= ~clk ; 
 
endmodule 
  

