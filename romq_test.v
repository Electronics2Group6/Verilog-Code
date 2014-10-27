//Will call every address of the romq and receive the inverse quantization matrix 

`define clkperiodby2 5 // Specify the half time as 5ns, making the clock 100MHz 
`include ?romq_banno.v? // Use the back annotated version of 
// romq.v for testing the design. 
module romq_test (d); // The test module is declared. 
output [7:0] d ; // So also the output. 
reg clk ; // The inputs are declared as 
reg [5:0] a ; // ?reg? in a test bench. 
romq romq1( .clk(clk), .a(a), .d(d) ); //Initialize romq with the  
integer count ; // count is an integer variable. 


//Address calling loop
initial begin 
clk = 1'b0 ; // Initialize the clock and 
#7 a = 0 ; // address.  
for (count = 0; count < 64; count = count+1) // count = 0?63. 
#10 a = count ; // Apply new address 
 // every 10 ns a = 0?63. 
#200 // Stop after some time. 
$stop ; 
end 

//Clock always block
always 
 #`clkperiodby2 clk <= ~clk ; // Generate 100 MHz clock. 
endmodule 
