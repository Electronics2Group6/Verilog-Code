module adder14sr( 	clk,
					n0, n1, n2, n3, n4, n5, n6, n7,
					dct
					);
					
input 		    	clk ;
input 	[13:0] 	n0, n1, n2, n3, n4, n5, n6, n7;
output 	[11:0] 	dct ;

wire 	  [8:0] 	s00_lsb ;
wire 	  [8:0] 	s01_lsb ;
wire 	  [8:0] 	s02_lsb ;
wire 	  [8:0] 	s03_lsb ;

wire 	  [6:0] 	s00_msb ;
wire 	  [6:0] 	s01_msb ;
wire 	  [6:0] 	s02_msb ;
wire 	  [6:0] 	s03_msb ;
	
wire 	  [8:0] 	s10_lsb ;
wire    [8:0] 	s11_lsb ;

wire 	  [7:0] 	s10_msb ;
wire 	  [7:0] 	s11_msb ;

wire 	  [8:0]	  s20_lsb ;

wire 	  [16:0] 	sums ;
wire 	  [13:0] 	sums_next ;
wire 	  [10:0] 	sums_nextn ;


reg 	  [13:8] 	n0_reg1 ;
reg 	  [13:8] 	n1_reg1 ;
reg 	  [13:8] 	n2_reg1 ;
reg 	  [13:8] 	n3_reg1 ;
reg 	  [13:8] 	n4_reg1 ;
reg 	  [13:8] 	n5_reg1 ;
reg 	  [13:8] 	n6_reg1 ;
reg 	  [13:8] 	n7_reg1 ;

reg 	  [8:0] 	s00_lsbreg1 ;
reg 	  [8:0] 	s01_lsbreg1 ;
reg 	  [8:0] 	s02_lsbreg1 ;
reg 	  [8:0] 	s03_lsbreg1 ;

reg 	  [6:0] 	s00_msbreg2 ;
reg 	  [6:0] 	s01_msbreg2 ;
reg   	[6:0] 	s02_msbreg2 ;
reg 	  [6:0] 	s03_msbreg2 ;

reg 	  [7:0] 	s00_lsbreg2 ;
reg     [7:0] 	s01_lsbreg2 ;
reg   	[7:0] 	s02_lsbreg2 ;
reg 	  [7:0] 	s03_lsbreg2 ;

reg 	  [8:0] 	s10_lsbreg3 ;
reg 	  [8:0] 	s11_lsbreg3 ;

reg 	  [6:0] 	s00_msbreg3 ;
reg 	  [6:0] 	s01_msbreg3 ;
reg 	  [6:0] 	s02_msbreg3 ;
reg 	  [6:0] 	s03_msbreg3 ;

reg 	  [7:0] 	s10_lsbreg4 ;
reg   	[7:0] 	s11_lsbreg4 ;

reg 	  [7:0] 	s10_msbreg4 ;
reg 	  [7:0] 	s11_msbreg4 ;

reg 	  [7:0] 	s10_msbreg5 ;
reg 	  [7:0] 	s11_msbreg5 ;

reg 			      s20_lsbreg5cy ;
reg 	  [7:0] 	s20_lsbreg5 ;

reg 	  [11:0] 	dct;

assign s00_lsb[8:0] = n0[7:0] + n1[7:0] ;
assign s01_lsb[8:0] = n2[7:0] + n3[7:0] ;
assign s02_lsb[8:0] = n4[7:0] + n5[7:0] ;
assign s03_lsb[8:0] = n6[7:0] + n7[7:0] ;

always @ (posedge clk)

begin
	
	n0_reg1[13:8] 	<= n0[13:8] ;
	n1_reg1[13:8]	  <= n1[13:8] ;
	n2_reg1[13:8] 	<= n2[13:8] ;
	n3_reg1[13:8] 	<= n3[13:8] ;
	n4_reg1[13:8] 	<= n4[13:8] ;
	n5_reg1[13:8] 	<= n5[13:8] ;
	n6_reg1[13:8] 	<= n6[13:8] ;
	n7_reg1[13:8]	  <= n7[13:8] ;
	
	s00_lsbreg1[8:0] <= s00_lsb[8:0] ;
	s01_lsbreg1[8:0] <= s01_lsb[8:0] ;
	s02_lsbreg1[8:0] <= s02_lsb[8:0] ;
	s03_lsbreg1[8:0] <= s03_lsb[8:0] ;
	
end

assign s00_msb[6:0] = {n0_reg1[13], n0_reg1[13:8]} + {n1_reg1[13],
					  n1_reg1[13:8]} + s00_lsbreg1[8] ;
assign s01_msb[6:0] = {n2_reg1[13], n2_reg1[13:8]} + {n3_reg1[13],
					  n3_reg1[13:8]} + s01_lsbreg1[8] ;
assign s02_msb[6:0] = {n4_reg1[13], n4_reg1[13:8]} + {n5_reg1[13],
					  n5_reg1[13:8]} + s02_lsbreg1[8] ;
assign s03_msb[6:0] = {n6_reg1[13], n6_reg1[13:8]} + {n7_reg1[13],
					  n7_reg1[13:8]} + s03_lsbreg1[8] ;

always @ (posedge clk)

begin

	s00_msbreg2[6:0] <= s00_msb[6:0] ;
	s01_msbreg2[6:0] <= s01_msb[6:0] ;	
	s02_msbreg2[6:0] <= s02_msb[6:0] ;	
	s03_msbreg2[6:0] <= s03_msb[6:0] ;	

	s00_lsbreg2[7:0] <= s00_lsbreg1[7:0] ;
	s01_lsbreg2[7:0] <= s01_lsbreg1[7:0] ;
	s02_lsbreg2[7:0] <= s02_lsbreg1[7:0] ;
	s03_lsbreg2[7:0] <= s03_lsbreg1[7:0] ;

end

assign s10_lsb[8:0] = s00_lsbreg2[7:0] + s01_lsbreg2[7:0] ;
assign s11_lsb[8:0] = s02_lsbreg2[7:0] + s03_lsbreg2[7:0] ;

always @ (posedge clk)

begin

	s10_lsbreg3[8:0] <= s10_lsb[8:0] ;
	s11_lsbreg3[8:0] <= s11_lsb[8:0] ;
	
	s00_msbreg3[6:0] <= s00_msbreg2[6:0] ;
	s01_msbreg3[6:0] <= s01_msbreg2[6:0] ;	
	s02_msbreg3[6:0] <= s02_msbreg2[6:0] ;
	s03_msbreg3[6:0] <= s03_msbreg2[6:0] ;
	
end

assign s10_msb[7:0] = {s00_msbreg3[6], s00_msbreg3[6:0]} + 
	   {s01_msbreg3[6], s01_msbreg3[6:0]} + s10_lsbreg3[8] ;
assign s11_msb[7:0] = {s02_msbreg3[6], s02_msbreg3[6:0]} + 
	   {s03_msbreg3[6], s03_msbreg3[6:0]} + s11_lsbreg3[8] ;
	   
always @ (posedge clk)

begin

	s10_lsbreg4[7:0] <= s10_lsbreg3[7:0] ;
	s11_lsbreg4[7:0] <= s11_lsbreg3[7:0] ;
	
	s10_msbreg4[7:0] <= s10_msb[7:0] ;
	s11_msbreg4[7:0] <= s11_msb[7:0] ;
	
end

assign s20_lsb[8:0] = s10_lsbreg4[7:0]+s11_lsbreg4[7:0] ;

always @ (posedge clk)

begin
	
	s10_msbreg5		[7:0] 	<= s10_msbreg4	[7:0] ;
	s11_msbreg5		[7:0] 	<= s11_msbreg4	[7:0] ;
	s20_lsbreg5cy 			  <= s20_lsb		  [8];
	s20_lsbreg5		[7:0] 	<= s20_lsb		  [7:0] ;
	
end

assign sums[16:0] = {({s10_msbreg5[7], s10_msbreg5[7:0]}+
					{s11_msbreg5[7], s11_msbreg5[7:0]}+
					s20_lsbreg5cy), s20_lsbreg5[7:0]} ;
assign sums_next[13:0] = ~sums[13:0]+1 ;
assign sums_nextn[10:0] = ~sums_next[13:3]+1 ;

always @ (posedge clk)

begin

	if (sums[16] == 1'b0)
		dct[11:0] <= {1'b0, sums[13:3]} ;
	else
	
		begin
			
			if (sums_next[13:3] == 11'd0)
				dct[11:0] <= 12'd0 ;
			else
				dct[11:0] <= {1'b1, sums_nextn[10:0]} ;
		end
end

endmodule
