//Will call every address of the romq and receive the inverse quantization matrix 
//To test, read the output at d and compare with solution
`define clkperiodby2 5 // Specify the half time as 5ns, making the clock 100MHz 
`include "romq.v" //Include the file to be tested; in this case, romq

module romq_test (d); // The test module is declared. 


output [7:0] d ; // So also the output. 
reg clk ; // The inputs are declared as 
reg [5:0] a ; // ?reg? in a test bench. 
romq romq1( .clk(clk), .a(a), .d(d) ); //Initialize romq with the  
integer count ; // count is an integer variable. 


//Address calling loop
initial begin 
clk = 1'b0 ; // Initialize the clock 
#7 a = 0 ;  //Initialize address with a slight delay

for (count = 0; count < 64; count = count+1) // count = 0?63. 
#10 a = count ; // Apply new address 
 // every 10 ns a++. 
#200 // Stop after some time. 
$stop ; 
end 


//Clock always block
always 
 #`clkperiodby2 clk <= ~clk ; // Generate the 100 MHz master clock. 
endmodule 
