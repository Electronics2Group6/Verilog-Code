module mult12sx8u( clk, n1, n2, dctq);
  input clk;
  input [11:0] n1;
  input [7:0]  n2;
  
  output [8:0] dctq;
  
  wire nlorn2z;

  wire dctq_zero;

  wire [11:0] p1;
  wire [11:0] p2;
  wire [11:0] p3;
  wire [11:0] p4;
  wire [11:0] p5;
  wire [11:0] p6;
  wire [11:0] p7;
  wire [11:0] p8;

  wire [6:0]  s11a;
  wire [6:0]  s12a;  
  wire [6:0]  s13a;
  wire [6:0]  s14a;
  
  wire [6:0]  s11b;
  wire [6:0]  s12b;  
  wire [6:0]  s13b;
  wire [6:0]  s14b;
  
  wire [13:0]  s11;
  wire [13:0]  s12;  
  wire [13:0]  s13;
  wire [13:0]  s14;
  
  wire [15:0] s21;
  wire [7:0] s21a;
  wire [7:0] s21b;
  
  wire [15:0] s22;  
  wire [7:0] s22a;
  wire [7:0] s22b;
      
  wire [18:0] s31;
  wire [8:0] s31a;
  wire [8:0] s31b;
      
  wire [19:0] res;
  
  reg [11:0] n1_mag;
  reg [7:0]  n2_mag;
  
  reg [11:0] p1_reg1;
  reg [11:0] p2_reg1;
  reg [11:0] p3_reg1;
  reg [11:0] p4_reg1;
  reg [11:0] p5_reg1;
  reg [11:0] p6_reg1;
  reg [11:0] p7_reg1;
  reg [11:0] p8_reg1;
  
  reg [6:0] s11a_reg2;
  reg [6:0] s12a_reg2;
  
  reg [6:0] s13a_reg2;
  reg [6:0] s14a_reg2;

  reg  n1_reg1;
  reg  n1_reg2;
  reg  n1_reg3;
  reg  n1_reg4;
  reg  n1_reg5;
  reg  n1_reg6;
  reg  n1_reg7;

  reg n1orn2z_reg1;
  reg n1orn2z_reg2;
  reg n1orn2z_reg3;
  reg n1orn2z_reg4;
  reg n1orn2z_reg5;
  reg n1orn2z_reg6;
  reg n1orn2z_reg7;
  
  reg [11:0] p1_reg2;
  reg [11:0] p2_reg2;
  reg [11:0] p3_reg2;
  reg [11:0] p4_reg2;
  reg [11:0] p5_reg2;
  reg [11:0] p6_reg2;
  reg [11:0] p7_reg2;
  reg [11:0] p8_reg2;
  
  reg [13:0] s11_reg3;
  reg [13:0] s12_reg3;
  reg [13:0] s13_reg3;
  reg [13:0] s14_reg3;
  
  reg [13:0] s11_reg4;
  reg [13:0] s12_reg4;
  reg [13:0] s13_reg4;
  reg [13:0] s14_reg4;
  
  reg [7:0]  s21a_reg4;
  reg [7:0]  s22a_reg4;
  
  reg [15:0] s21_reg5;
  reg [15:0] s22_reg5;
  
  reg [15:0] s21_reg6;
  reg [15:0] s22_reg6;
  
  reg [8:0] s31a_reg6;
 
  reg [18:0] s31_reg7;
  
  reg [8:0] dctq;
  //reg [19:0] result;
  
  always @(n1)
  begin
    if(n1[11] == 1'b0)
      n1_mag <= n1[11:0];
    else
      n1_mag <= ~n1[11:0] + 1;
    end
  
  always @(n2)
  begin
  n2_mag <= n2[7:0];
  end
 
 assign n1orn2z = ((n1 == 12'b0) || (n2 == 7'b0)) ? 1'b1:1'b0;
 
 assign p1 = n1_mag[11:0] & {12{n2_mag[0]}};
 assign p2 = n1_mag[11:0] & {12{n2_mag[1]}};
 assign p3 = n1_mag[11:0] & {12{n2_mag[2]}};
 assign p4 = n1_mag[11:0] & {12{n2_mag[3]}};
 assign p5 = n1_mag[11:0] & {12{n2_mag[4]}};
 assign p6 = n1_mag[11:0] & {12{n2_mag[5]}};
 assign p7 = n1_mag[11:0] & {12{n2_mag[6]}};
 assign p8 = n1_mag[11:0] & {12{n2_mag[7]}};
 //
 assign s11a = p1_reg1[6:1] + p2_reg1[5:0];//s11a[6:0]
 assign s11b = {1'b0, p1_reg2[11:7]} + p2_reg2[11:6] + s11a_reg2[6];
 
 assign s12a = p3_reg1[6:1] + p4_reg1[5:0];//s12a[6:0]
 assign s12b = {1'b0, p3_reg2[11:7]} + p4_reg2[11:6] + s12a_reg2[6];
 
 assign s13a = p5_reg1[6:1] + p6_reg1[5:0];//s13a[6:0]
 assign s13b = {1'b0, p5_reg2[11:7]} + p6_reg2[11:6] + s13a_reg2[6];
 
 assign s14a = p7_reg1[6:1] + p8_reg1[5:0];//s14a[6:0]
 assign s14b = {1'b0, p7_reg2[11:7]} + p8_reg2[11:6] + s14a_reg2[6];
 
 assign s11 = {s11b, s11a_reg2[5:0], p1_reg2[0]};
 assign s12 = {s12b, s12a_reg2[5:0], p3_reg2[0]};
 assign s13 = {s13b, s13a_reg2[5:0], p5_reg2[0]};
 assign s14 = {s14b, s14a_reg2[5:0], p7_reg2[0]};
 
 assign s21a = s11_reg3[8:2] + s12_reg3[6:0];
 assign s21b = {2'b00, s11_reg4[13:9]} + s12_reg4[13:7] + s21a_reg4[7];
  
 assign s22a = s13_reg3[8:2] + s14_reg3[6:0];
 assign s22b = {2'b00, s13_reg4[13:9]} + s14_reg4[13:7] + s22a_reg4[7];

 assign s21  = {s21b[6:0], s21a_reg4[6:0], s11_reg4[1:0]};
 
 assign s22 = {s22b[6:0], s22a_reg4[6:0], s13_reg4[1:0]};
 
 assign s31a = s21_reg5[11:4] + s22_reg5[7:0];
 assign s31b = {4'b0000, s21_reg6[15:12]} + s22_reg6[15:8] + s31a_reg6[8];
 
 assign s31 = {s31b[6:0], s31a_reg6[7:0], s21_reg6[3:0]};
 
 assign res = (n1_reg7) ? {1'b1, (~s31_reg7 + 1'b1)}:{1'b0, s31_reg7};
 
 
 always @ (posedge clk)
 begin
   p1_reg1 <= p1;
   p2_reg1 <= p2;
   p3_reg1 <= p3;
   p4_reg1 <= p4;
   p5_reg1 <= p5;
   p6_reg1 <= p6;
   p7_reg1 <= p7;
   p8_reg1 <= p8;
   
   n1_reg1 <=n1[11];
   n1orn2z_reg1 <= n1orn2z;
   
 end
 
 always @ (posedge clk) //Pipe 2
 begin
   s11a_reg2 <= s11a;
   s12a_reg2 <= s12a;
   s13a_reg2 <= s13a;
   s14a_reg2 <= s14a;
   
   p1_reg2[11:7] <= p1_reg1[11:7];
   p2_reg2[11:6] <= p2_reg1[11:6];
   p3_reg2[11:7] <= p3_reg1[11:7];
   p4_reg2[11:6] <= p4_reg1[11:6];
   p5_reg2[11:7] <= p5_reg1[11:7];
   p6_reg2[11:6] <= p6_reg1[11:6];
   p7_reg2[11:7] <= p7_reg1[11:7];
   p8_reg2[11:6] <= p8_reg1[11:6];
   
   p1_reg2[0] <= p1_reg1[0];
   p3_reg2[0] <= p3_reg1[0];
   p5_reg2[0] <= p5_reg1[0];
   p7_reg2[0] <= p7_reg1[0];
   
   n1_reg2 <= n1_reg1;
   n1orn2z_reg2 <= n1orn2z_reg1;
 end
 
 always @ (posedge clk) //Pipe 3
 begin
   s11_reg3 <= s11;
   s12_reg3 <= s12;
   s13_reg3 <= s13;
   s14_reg3 <= s14;
   
   n1_reg3 <= n1_reg2;
   n1orn2z_reg3 <= n1orn2z_reg2;
 end
 
 always @ (posedge clk) //Pipe 4
 begin
   s11_reg4[13:9] <= s11_reg3[13:9];
   s11_reg4[1:0]  <= s11_reg3[1:0];
   s12_reg4[13:7] <= s12_reg3[13:7];
   s13_reg4[13:9] <= s13_reg3[13:9];
   s13_reg4[1:0] <= s13_reg3[1:0];
   s14_reg4[13:7]<= s14_reg3[13:7];
   
   s21a_reg4 <= s21a;
   s22a_reg4 <= s22a;
   
   n1_reg4 <=n1_reg3;
   n1orn2z_reg4 <= n1orn2z_reg3;
 end
 
 always @(posedge clk)
 begin
   s21_reg5 <= s21;
   s22_reg5 <= s22;
   
   n1_reg5 <= n1_reg4;
   n1orn2z_reg5 <= n1orn2z_reg4;
 end
 
 always @(posedge clk)
 begin
  s21_reg6[15:12] <= s21_reg5[15:12];
  s22_reg6[15:8] = s22_reg5[15:8];
  s21_reg6[3:0] <= s21_reg5[3:0];
  s31a_reg6 <=s31a;
  
  n1_reg6 <= n1_reg5;
  
  n1orn2z_reg6 <= n1orn2z_reg5;
  
end
////////////////////////////////////////////
always @(posedge clk)
begin
  s31_reg7 <= s31;
  n1_reg7 <= n1_reg6;
  n1orn2z_reg7 <=n1orn2z_reg6;
end

assign dctq_zero = ((n1orn2z_reg7 == 1'b1) ||(res[19:11] == 9'b0))? 1'b1:1'b0;

always @ (posedge clk)
begin
  if(dctq_zero)
    dctq[8:0] <= 9'b0;
  else
    dctq[8:0] <= res[19:11] +1;


end

endmodule
