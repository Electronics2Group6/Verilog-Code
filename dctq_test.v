// This is the test bench for the DCTQ Design. Input image is ?lena.txt?. 
// Change it for processing a different image. 
// dctq.txt is the DCTQ output of the image, lena.txt. 
// File name: ?dctq_test.v?. 
`define clkperiodby2 5 // Both clocks clk & pci_clk operate at 100 MHz. 
`define pci_clkperiodby2 5 
`define NUM_BLKS 1024 // Defines number of blocks in a frame. A 256 × 256 
 // pixel picture contains 1024 blocks. 
 // Change this for a different image size. 
`include "DCTQ.v" // Design module. 
module dctq_test ; // Declare the test bench and inputs. 

	reg pci_clk ; 
	reg clk ; 

	reg reset_n ; 
	reg start ; 

	reg [63:0] di ; 
	reg din_valid ; 
	reg [2:0] wa ; 
	reg [7:0] be ; 

	reg hold ; 
	wire ready ; 

	wire [8:0] dctq ; // DCTQ output. 
	wire dctq_valid ; 
	wire [5:0] addr ; 

	wire stopproc ; 

	reg eob ; 
	wire [10:0] eobcnt_next ; 
	reg [10:0] eobcnt_reg ; 

	reg start_din ; 

	// Change the above two ?eobcnt? statements for a different image size, 
	// sufficient to accommodate the total number of blocks in a frame. 
	integer i ; // Keeps track of the current number of blocks processed. 
	integer fp1 ; // Points the DCTQ output file. 

	reg [63:0] mem [8191:0] ; // Buffer to accommodate one frame. 
	reg [12:0] mem_addr ; // 13 bits address to accommodate 
	 // up to 8191. 
	// reg [63:0] contains one row (8 pixels) of an image block ? eight such rows make 
	// one block; 1024 such blocks mean 8192 rows. Change mem [8191:0] and 
	// reg[12:0] for a different image size. 

	dctq dctq1( // Invoke DCTQ design module to get the DCTQ output. 
	 .pci_clk(pci_clk), 
	 .clk(clk), 
	 .reset_n(reset_n), 
	 .start(start), 
	 .di(di), 
	 .din_valid(din_valid), 
	 .wa(wa), 
	 .be(be), 
	 .hold(hold), 
	 .ready(ready), 
	 .dctq(dctq), 
	 .dctq_valid(dctq_valid), 
	 .addr(addr) 
	 ) ; 
	initial 
	begin 
	 $readmemh ("lena.txt", mem) ; 
	// ?mem? receives the input image frame, lena.txt. 
	 // Change the name for a different image frame. 
	 fp1 = $fopen ("dctq.txt") ; 
	 // dctq.txt is the DCTQ output of the image frame, lena.txt. 
	 pci_clk = 0 ; 
	 clk = 0 ; 
	 reset_n = 1 ; 
	 start = 0 ; 
	 di = 0 ; 
	 din_valid = 0 ; 
	 wa = 0 ; 
	 be = 8'h00 ; // Enable bytes to be written. 
	 hold = 0 ; 
	 mem_addr = 0 ; 
	 start_din = 1'b0 ; 
	 i = `NUM_BLKS ; // i = 1024 
	 #20 reset_n = 1'b0 ; 
	 #40 reset_n = 1'b1 ; 
	 start_din = 1'b1; 
	 #700000 // Run long enough to process the entire frame. 
	 $fclose(fp1) ; // Close the output file and 
	 $stop ; // stop the simulation. 
	end 
	always 
	 #`clkperiodby2 clk <= ~clk ; // Run the two clocks. 
	always 
	 #`pci_clkperiodby2 pci_clk <= ~pci_clk ; 
	always @ (start_din or i or clk or pci_clk or reset_n or wa or mem_addr) 
	begin 
	if (start_din == 1'b1) 
	 begin 
	 @(posedge pci_clk) 
	if(i != 0) // Image block counter. 
	 begin 
	@(posedge pci_clk) ; 
	#1 ; 
	 din_valid = 1 ; 
	 wa = 0 ; 
	 di = mem[mem_addr] ; // Inputs first row of an 
	 // image block. 
	 mem_addr = mem_addr + 1 ;  
	 repeat(7) 
	 begin 
	 @(posedge pci_clk) ; 
	 #1 ; 
	 din_valid = 1 ; 
	 wa = wa + 1 ; 
	 di = mem[mem_addr] ; // Inputs second to eight rows 
	 // of the image block. 
	 mem_addr = mem_addr + 1 ; 
	 end 
	 @(posedge pci_clk) ; 
	 #1 din_valid = 0 ; 
	 wait (ready) ; // Wait for ready to go high. 
	 @(posedge clk) ; 
	 #1 start = 1'b1 ; // Start the DCTQ process after 
	 // inputting the image block and 
	 // when ready signal is high. 
	 i = i - 1;
	 end 
	 else 
	 begin 
	 wait(eobcnt_reg==`NUM_BLKS); 
	// Completion of all the image blocks. 
	 $fclose(fp1) ; 
	 $stop ; 
	 end 
	end
	end	
	assign stopproc =((eobcnt_reg==`NUM_BLKS-1)&&(eob== 'b1)) ? 1'b1 : 1'b0 ; 
	 // Condition to stop DCTQ processing. 
	always @ (posedge clk) 
	begin 
	 if(dctq_valid == 1'b1) 
	 begin 
	 if (stopproc == 1'b0) // Means, the process has not stopped. 
	$fdisplay(fp1,"%h", dctq) ; 
	// DCTQ coefficients are written into 
  // the ?dctq? output file every time the DCTQ is 
	// valid. Don?t write into ?dctq.txt? file when 
	// all the coefficients are already written. 
	 end 
	end 
	always @ (posedge clk or negedge reset_n) 
	begin 
	 if (reset_n == 1'b0) 
	 eob <= 1'b0 ; 
	 else if (addr == 6'd63) 
	 eob <= 1'b1 ; // End of block is issued 
	 // when the last coefficient of 
	 // a block is processed. 
	 else 
	 eob <= 1'b0 ; 
	end 
	assign eobcnt_next = eobcnt_reg + 1 ; // Count the number of blocks 
	 // processed. 
	always @ (posedge clk or negedge reset_n) 
	begin 
	 if (reset_n == 1'b0) 
	 eobcnt_reg <= 0 ; 
	 else if (eob == 1'b1) 
	 eobcnt_reg <= eobcnt_next ; 
	end 
endmodule 
