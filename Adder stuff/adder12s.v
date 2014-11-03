module adder12s (	clk,
					n0,
					n1,
					n2,
					n3,
					n4,
					n5,
					n6,
					n7,
					sum
				) ;

input			clk ;
input	[11:0]	n0 ;
input	[11:0]	n1 ;
input	[11:0]	n2 ;
input	[11:0]	n3 ;
input	[11:0]	n4 ;
input	[11:0]	n5 ;
input	[11:0]	n6 ;
input	[11:0]	n7 ;
output	[14:0]	sum ;

wire 	[7:0] 	s00_lsb ;
wire 	[7:0] 	s01_lsb ;
wire 	[7:0] 	s02_lsb ;
wire 	[7:0] 	s03_lsb ;
wire 	[5:0] 	s00_msb ;
wire 	[5:0] 	s01_msb ;
wire 	[5:0] 	s02_msb ;
wire 	[5:0] 	s03_msb ;
wire 	[7:0] 	s10_lsb ;
wire 	[7:0] 	s11_lsb ;
wire 	[6:0] 	s10_msb ;
wire 	[6:0] 	s11_msb ;
wire 	[7:0] 	s20_lsb ;

reg 	[11:7] 	n0_reg1 ;
reg 	[11:7] 	n1_reg1 ;
reg 	[11:7] 	n2_reg1 ;
reg 	[11:7] 	n3_reg1 ;
reg 	[11:7] 	n4_reg1 ;
reg 	[11:7] 	n5_reg1 ;
reg 	[11:7] 	n6_reg1 ;
reg 	[11:7] 	n7_reg1 ;
reg 	[7:0] 	s00_lsbreg1 ;
reg 	[7:0] 	s01_lsbreg1 ;
reg 	[7:0] 	s02_lsbreg1 ;
reg 	[7:0] 	s03_lsbreg1 ;
reg 	[5:0] 	s00_msbreg2 ;
reg 	[5:0] 	s01_msbreg2 ;
reg 	[5:0] 	s02_msbreg2 ;
reg 	[5:0]	s03_msbreg2 ;
reg 	[6:0] 	s00_lsbreg2 ;
reg 	[6:0] 	s01_lsbreg2 ;
reg 	[6:0] 	s02_lsbreg2 ;
reg 	[6:0] 	s03_lsbreg2 ;
reg 	[7:0] 	s10_lsbreg3 ;
reg 	[7:0] 	s11_lsbreg3 ;
reg		[5:0] 	s00_msbreg3 ;
reg 	[5:0] 	s01_msbreg3 ;
reg 	[5:0] 	s02_msbreg3 ;
reg 	[5:0] 	s03_msbreg3 ;
reg 	[6:0] 	s10_lsbreg4 ;
reg 	[6:0] 	s11_lsbreg4 ;
reg 	[6:0] 	s10_msbreg4 ;
reg 	[6:0] 	s11_msbreg4 ;
reg 	[6:0] 	s10_msbreg5 ;
reg 	[6:0] 	s11_msbreg5 ;
reg 			s20_lsbreg5cy ;
reg 	[6:0] 	s20_lsbreg5 ;

//First Stage Addition

assign s00_lsb[7:0] = n0[6:0]+n1[6:0] ;
assign s01_lsb[7:0] = n2[6:0]+n3[6:0] ;
assign s02_lsb[7:0] = n4[6:0]+n5[6:0] ;
assign s03_lsb[7:0] = n6[6:0]+n7[6:0] ;

always @ (posedge clk)

begin
	n0_reg1[11:7] <= n0[11:7] ;
	n1_reg1[11:7] <= n1[11:7] ;
	n2_reg1[11:7] <= n2[11:7] ;
	n3_reg1[11:7] <= n3[11:7] ;
	n4_reg1[11:7] <= n4[11:7] ;
	n5_reg1[11:7] <= n5[11:7] ;
	n6_reg1[11:7] <= n6[11:7] ;
	n7_reg1[11:7] <= n7[11:7] ;
	s00_lsbreg1[7:0] <= s00_lsb[7:0] ;
	s01_lsbreg1[7:0] <= s01_lsb[7:0] ;
	s02_lsbreg1[7:0] <= s02_lsb[7:0] ;
	s03_lsbreg1[7:0] <= s03_lsb[7:0] ;
end

assign s00_msb[5:0] = {n0_reg1[11], n0_reg1[11:7]}+
					  {n1_reg1[11], n1_reg1[11:7]}+s00_lsbreg1[7] ;
assign s01_msb[5:0] = {n2_reg1[11], n2_reg1[11:7]}+
					  {n3_reg1[11], n3_reg1[11:7]}+s01_lsbreg1[7] ;
assign s02_msb[5:0] = {n4_reg1[11], n4_reg1[11:7]}+
					  {n5_reg1[11], n5_reg1[11:7]}+s02_lsbreg1[7] ;
assign s03_msb[5:0] = {n6_reg1[11], n6_reg1[11:7]}+
					  {n7_reg1[11], n7_reg1[11:7]}+s03_lsbreg1[7] ;
					  
always @ (posedge clk)

begin
	s00_msbreg2[5:0] <= s00_msb[5:0] ;
	s01_msbreg2[5:0] <= s01_msb[5:0] ;
	s02_msbreg2[5:0] <= s02_msb[5:0] ;
	s03_msbreg2[5:0] <= s03_msb[5:0] ;
	s00_lsbreg2[6:0] <= s00_lsbreg1[6:0] ;
	s01_lsbreg2[6:0] <= s01_lsbreg1[6:0] ;
	s02_lsbreg2[6:0] <= s02_lsbreg1[6:0] ;
	s03_lsbreg2[6:0] <= s03_lsbreg1[6:0] ;
end

//Second Stage Addition

assign s10_lsb[7:0] = s00_lsbreg2[6:0]+s01_lsbreg2[6:0] ;
assign s11_lsb[7:0] = s02_lsbreg2[6:0]+s03_lsbreg2[6:0] ;

always @ (posedge clk)

begin
	s10_lsbreg3[7:0] <= s10_lsb[7:0] ;
	s11_lsbreg3[7:0] <= s11_lsb[7:0] ;
	s00_msbreg3[5:0] <= s00_msbreg2[5:0] ;
	s01_msbreg3[5:0] <= s01_msbreg2[5:0] ;
	s02_msbreg3[5:0] <= s02_msbreg2[5:0] ;
	s03_msbreg3[5:0] <= s03_msbreg2[5:0] ;
end

assign s10_msb[6:0] = 	{s00_msbreg3[5],
						s00_msbreg3[5:0]}+{s01_msbreg3[5],
						s01_msbreg3[5:0]}+s10_lsbreg3[7] ;
assign s11_msb[6:0] =	{s02_msbreg3[5], s02_msbreg3[5:0]}+
						{s03_msbreg3[5], s03_msbreg3[5:0]}+
						s11_lsbreg3[7] ;

always @ (posedge clk)

begin
	s10_lsbreg4[6:0] <= s10_lsbreg3[6:0] ;
	s11_lsbreg4[6:0] <= s11_lsbreg3[6:0] ;
	s10_msbreg4[6:0] <= s10_msb[6:0] ;
	s11_msbreg4[6:0] <= s11_msb[6:0] ;
end

//Third Stage Addition

assign s20_lsb[7:0] = s10_lsbreg4[6:0]+s11_lsbreg4[6:0] ;

always @ (posedge clk)

begin
	s10_msbreg5[6:0] 	<= s10_msbreg4[6:0] ;
	s11_msbreg5[6:0] 	<= s11_msbreg4[6:0] ;
	s20_msbreg5cy 		<= s20_lsb[7] ;
	s20_lsbreg5[6:0]	<= s20_lsb[6:0] ;
end

assign sum[14:0] = {({s10_msbreg5[6], s10_msbreg5[6:0]}+
					{s11_msbreg5[6], s11_msbreg5[6:0]}+
					s20_lsbreg5cy), s20_lsbreg5[6:0]} ;
endmodule
