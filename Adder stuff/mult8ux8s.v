module mult8ux8s(
					clk,
					n1,
					n2,
					result
				);
	
// inputs outputs declarations	
input clk;
input [7:0] n1;
input [7:0] n2;
output [15:0] result;

//wire declarations
wire nlorn2z;

wire [7:0] p1;
wire [7:0] p2;
wire [7:0] p3;
wire [7:0] p4;
wire [7:0] p5;
wire [7:0] p6;
wire [7:0] p7;
wire [7:0] p8;

wire [4:0] s11a;
wire [4:0] s12a;
wire [4:0] s13a;
wire [4:0] s14a;

wire [4:0] s11b;
wire [4:0] s12b;
wire [4:0] s13b;
wire [4:0] s14b;

wire [9:0] s11;
wire [9:0] s12;
wire [9:0] s13;
wire [9:0] s14;

wire [5:0] s21a;
wire [5:0] s22a;

wire [11:0] s21b;
wire [11:0] s22b;

wire [6:0] s31a;
wire [6:0] s31b;

wire [14:0] s31;

wire [15:0] res;

//register declarations
reg [7:0] n2_mag;

reg [7:0] p1_reg1;
reg [7:0] p2_reg1;
reg [7:0] p3_reg1;
reg [7:0] p4_reg1;
reg [7:0] p5_reg1;
reg [7:0] p6_reg1;
reg [7:0] p7_reg1;
reg [7:0] p8_reg1;

reg [4:0] s11a_reg2;
reg [4:0] s12a_reg2;
reg [4:0] s13a_reg2;
reg [4:0] s14a_reg2;

reg n2_reg1;
reg n2_reg2;
reg n2_reg3;
reg n2_reg4;
reg n2_reg5;
reg n2_reg6;
reg n2_reg7;

reg nlorn2z_reg1;
reg nlorn2z_reg2;
reg nlorn2z_reg3;
reg nlorn2z_reg4;
reg nlorn2z_reg5;
reg nlorn2z_reg6;
reg nlorn2z_reg7;

reg [7:0] p1_reg2;
reg [7:0] p2_reg2;
reg [7:0] p3_reg2;
reg [7:0] p4_reg2;
reg [7:0] p5_reg2;
reg [7:0] p6_reg2;
reg [7:0] p7_reg2;

reg [9:0] s11_reg3;
reg [9:0] s12_reg3;
reg [9:0] s13_reg3;
reg [9:0] s14_reg3;

reg [9:0] s11_reg4;
reg [9:0] s12_reg4;
reg [9:0] s13_reg4;
reg [9:0] s14_reg4;

reg [5:0] s21a_reg4;
reg [5:0] s22a_reg4;

reg [11:0] s21_reg5;
reg [11:0] s22_reg5;

reg [11:0] s21_reg6;
reg [11:0] s22_reg6;

reg[6:0] s31a_reg6;

reg [14:0] s31_reg7;

reg[15:0] result;

// begin working code
always@(n2)

begin
	if(n2[7] == 1'b0)
		n2_mag = n2[7:0];
	else
		n2_mag = ~n2[7:0] +1;
	end
	
	assign nlorn2z = ((n1 == 7'b0)||(n2 == 7'b0) ? 1'b1:1'b0;
	//If n1 or n2 is zero, make final result + 0
	
	assign p1 = n1[7:0] & {8{n2_mag[0]}};
	assign p2 = n1[7:0] & {8{n2_mag[1]}};
	assign p3 = n1[7:0] & {8{n2_mag[2]}};
	assign p4 = n1[7:0] & {8{n2_mag[3]}};
	assign p5 = n1[7:0] & {8{n2_mag[4]}};
	assign p6 = n1[7:0] & {8{n2_mag[5]}};
	assign p7 = n1[7:0] & {8{n2_mag[6]}};
	assign p8 = n1[7:0] & {8{n2_mag[7]}};
	
	assign s11a = p1_reg1[4:1] + p2_reg1[3:0];
	assign s11b = {1'b0,p1_reg2[7:5]} + p2_reg2[7:4] + s11a_reg2[4];
	
	assign s12a = p3_reg1[4:1] + p4_reg1[3:0];
	assign s12b = {1'b0,p3_reg2[7:5]} + p4_reg2[7:4] + s12a_reg2[4];
	
	assign s13a = p5_reg1[4:1] + p6_reg1[3:0];
	assign s13b = {1'b0,p5_reg2[7:5]} + p6_reg2[7:4] + s13a_reg2[4];
	
	assign s14a = p7_reg1[4:1] + p8_reg1[3:0];
	assign s14b = {1'b0,p7_reg2[7:5]} + p8_reg2[7:4] + s14a_reg2[4];
	
	assign s11 = {s11b,s11a_reg2[3:0],p1_reg2[0]};
	assign s12 = {s12b,s12a_reg2[3:0],p1_reg2[0]};
	assign s13 = {s13b,s13a_reg2[3:0],p1_reg2[0]};
	assign s14 = {s14b,s14a_reg2[3:0],p1_reg2[0]};
	
	assign s21a = s11_reg3[6:2] + s12_reg3[4:0];
	assign s21b = {2'b0,s11_reg4[9:7] + s12_reg[9:5] + s21a_reg4[5];
	
	assign s22a = s13_reg3[6:2] + s14_reg3[4:0];
	assign s22b = {2'b0,s13_reg4[9:7] + s14_reg[9:5] + s21a_reg4[5];
	
	assign s21 = {s21b[4:0],s21a_reg4[4:0],s11_reg4[1:0]};
	assign s22 = {s22b[4:0],s22a_reg4[4:0],s13_reg4[1:0]};
	
	assign s31a = s21_reg5[9:4] + s22_reg5[5:0];
	assign s31b = {4'b0,s21_reg6[11:10]} + s22_reg6[11:6] + s31a_reg6[6];
	
	//third stage MSB
	
	assign s31 = {s31b[4:0],s31a_reg6[5:0] s21_reg6[3:0]};
	
	
	assign res = (n2_reg7) ? {1'b1,(~s31_reg7 + 1'b1}:{1'b0,s31_reg7;
	
end

always @(posedge clk)
//first piple register
begin
	p1_reg1 <= p1;
	p2_reg1 <= p2;
	p3_reg1 <= p3;
	p4_reg1 <= p4;
	p5_reg1 <= p5;
	p6_reg1 <= p6;
	p7_reg1 <= p7;
	p8_reg1 <= p8;
	
	n2_reg1 <= n2[7];
	
	nlorn2z_reg1 <= nlorn2z;
end
	
always @ (posedge clk)
//second pipeline register
	
	s11a_reg2 <= s11a;
	s12a_reg2 <= s12a;
	s13a_reg2 <= s14a;
	s14a_reg2 <= s14a;
	
	p1_reg2[7:5] <= p1_reg1 [7:5];
	p2_reg2[7:4] <= p2_reg1 [7:4];
	p3_reg2[7:5] <= p3_reg1 [7:5];
	p4_reg2[7:4] <= p4_reg1 [7:4];
	p5_reg2[7:5] <= p5_reg1 [7:5];
	p6_reg2[7:4] <= p6_reg1 [7:4];
	p7_reg2[7:5] <= p7_reg1 [7:5];
	p8_reg2[7:4] <= p8_reg1 [7:4];
	
	p1_reg2[0] <= p1_reg1[0];
	p3_reg2[0] <= p3_reg1[0];
	p5_reg2[0] <= p5_reg1[0];
	p7_reg2[0] <= p7_reg1[0];
	
	n2_reg2 <= n2_reg1;
	
	nlorn2z_reg2 <= nlorn2z_reg1;
	
end
	
always @ (posedge clk)
begin
//third pipeline register

	s11_reg3 <= s11;
	s12_reg3 <= s12;
	s13_reg3 <= s13;
	s14_reg3 <= s14;
	
	n2_reg3 <= n2_reg2;
	
	nlorn2z_reg3 = nlorn2z_reg2;
	
end

always @ (posedge clk)
begin
//fourth pipeline register

	s11_reg4[9:7] <= s11_reg3[9:7];
	s11_reg4[1:0] <= s11_reg3[1:0];
	
	s12_reg4[9:5] <= s12_reg3[9:5];
	
	s13_reg4[9:7] <= s13_reg3[9:7];
	s13_reg4[1:0] <= s13_reg3[1:0];
	
	s14_reg4[9:5] <= s14_reg3[9:5];
	
	s21a_reg4 <= s21a;
	s22a_reg4 <= s22a;
	
	n2_reg4 <= n2_reg3;
	nlorn2z_reg4 = nlorn2z_reg3;
	
end

always @ (posedge clk)
begin
//fifth pipeline register

	
	s21_reg5 <= s21;
	s22_reg5 <= s22;
	
	n2_reg5 <= n2_reg4;
	nlorn2z_reg5 = nlorn2z_reg4;
	
end

always @ (posedge clk)
begin
//sixth pipeline register

	
	s21_reg6[11:10] <= s21_reg5[11:10];
	s22_reg6[11:6] <= s22_reg5[11:6];
	s21_reg6[3:0] <= s21_reg5[3:0];
	
	s31a_reg6 <= s31a;
	
	n2_reg6 <= n2_reg5;
	nlorn2z_reg6 = nlorn2z_reg5;
	
end
	
always @ (posedge clk)
begin
//seventh pipeline register

	
	n2_reg7 <= n2_reg6;
	s31_reg7 <= s31;
	nlorn2z_reg7 <= nlorn2z_reg6;
	
end
	
always @ (posedge clk)
begin
//eight pipeline register

	
	if(nlorn2z_reg7 == 1'b1)
		result <= 16'b0;
	else
		result <= res;
	end
	
end

endmodule

