`include "dualram.v"
`include "adder12s.v"
`include "adder14sr.v"
`include "DCTQreg2x8xn.v"
`include "mult8ux8s.v"
`include "mult11sx8s.v"
`include "mult12sx8u.v"
`include "romc.v"
`include "romq.v"
`include "dctq_controller.v"

module dctq(pci_clk,clk,reset_n,start,di,din_valid,wa,be,hold,ready,dctq,dctq_valid,addr);

input pci_clk;
input clk;
input reset_n;
input start;
input din_valid;
input hold;
input [63:0] di;
input [2:0] wa;
input [7:0] be;

output ready;
output [8:0] dctq;
output dctq_valid;
output [5:0] addr;

wire ready;
wire [8:0] dctq;
wire dctq_valid;
wire [5:0] addr;
wire rnw;
wire encnt2;

wire [15:0] result1;
wire [15:0] result2;
wire [15:0] result3;
wire [15:0] result4;
wire [15:0] result5;
wire [15:0] result6;
wire [15:0] result7;
wire [15:0] result8;

wire [14:0] sum1;
wire [11:0] dct;

wire [63:0] d0;
wire [63:0] d1;
wire [63:0] d2;

wire [10:0] qr0;
wire [10:0] qr1;
wire [10:0] qr2;
wire [10:0] qr3;
wire [10:0] qr4;
wire [10:0] qr5;
wire [10:0] qr6;
wire [10:0] qr7;

wire [18:0] res1;
wire [18:0] res2;
wire [18:0] res3;
wire [18:0] res4;
wire [18:0] res5;
wire [18:0] res6;
wire [18:0] res7;
wire [18:0] res8;

wire [5:0] cnt1_reg;
wire [2:0] cnt2_reg;
wire [2:0] cnt3_reg;
wire [5:0] cnt4_reg;

wire [7:0] qout;

//dualram
dualram dualram1(.clk(clk),.pci_clk(pci_clk),.rnw(rnw),.be(be),.ra(cnt1_reg[2:0]),.wa(wa),.di(di),.din_valid(din_valid),.d0(d0));

romc romc1(.clk(clk),.addr1(cnt1_reg[5:3]),.addr2(cnt3_reg[2:0]),.dout1(d1),.dout2(d2));

mult8ux8s u11(.clk(clk),.n1(d0[63:56]),.n2(d1[63:56]),.result(result1));

mult8ux8s u12(.clk(clk),.n1(d0[55:48]),.n2(d1[55:48]),.result(result2));

mult8ux8s u13(.clk(clk),.n1(d0[47:40]),.n2(d1[47:40]),.result(result3));

mult8ux8s u14(.clk(clk),.n1(d0[39:32]),.n2(d1[39:32]),.result(result4));

mult8ux8s u15(.clk(clk),.n1(d0[31:24]),.n2(d1[31:24]),.result(result5));

mult8ux8s u16(.clk(clk),.n1(d0[23:16]),.n2(d1[23:16]),.result(result6));

mult8ux8s u17(.clk(clk),.n1(d0[15:8]),.n2(d1[15:8]),.result(result7));

mult8ux8s u18(.clk(clk),.n1(d0[7:0]),.n2(d1[7:0]),.result(result8));

//partial products of cx are added here
adder12 adder12s1(.clk(clk),.n0(result1[15:4])
	,.n1(result2[15:4])
	,.n2(result3[15:4])
	,.n3(result4[15:4])
	,.n4(result5[15:4])
	,.n5(result6[15:4])
	,.n6(result7[15:4])
	,.n7(result8[15:4])
	,.sum(sum1)
);

//three stage addition

dctreg2x8xn #(11) dctreg1(
	.clk(clk),
	.din(sum1[14:4]),
	.wa(cnt2_reg[2:0]),
	.enreg(encnt2),
	.qr0(qr0),
	.qr1(qr1),
	.qr2(qr2),
	.qr3(qr3),
	.qr4(qr4),
	.qr5(qr5),
	.qr6(qr6),
	.qr7(qr7)
);

mult8ux8s u21(.clk(clk),.n1(qr0),.n2(d2[63:56]),.result(res1));
mult8ux8s u22(.clk(clk),.n1(qr1),.n2(d2[55:48]),.result(res2));
mult8ux8s u23(.clk(clk),.n1(qr2),.n2(d2[47:40]),.result(res3));
mult8ux8s u24(.clk(clk),.n1(qr3),.n2(d2[39:32]),.result(res4));
mult8ux8s u25(.clk(clk),.n1(qr4),.n2(d2[31:24]),.result(res5));
mult8ux8s u26(.clk(clk),.n1(qr5),.n2(d2[23:16]),.result(res6));
mult8ux8s u27(.clk(clk),.n1(qr6),.n2(d2[15:8]),.result(res7));
mult8ux8s u28(.clk(clk),.n1(qr7),.n2(d2[7:0]),.result(res8));

//above results are multiplied

adder14sr adder14sr1(.clk(clk),
	.n0(res1[18:5]),
	.n1(res2[18:5]),
	.n2(res3[18:5]),
	.n3(res4[18:5]),
	.n4(res5[18:5]),
	.n5(res6[18:5]),
	.n6(res7[18:5]),
	.n7(res8[18:5]),
	.dct(dct[11:0])
);

romq romq1(.clk(clk),.a(cnt4_reg),.d(qout));

mult12sx8u u31(.clk(clk),.n1(dct[11:0]),.n2(qout),.dctq(dctq));

//dctq controller

dctq_controller dctq_control1(.clk(clk),
								.reset_n(reset_n),
								.start(start),
								.hold(hold),
								.ready(ready),
								.rnw(rnw),
								.dctq_valid(dctq_valid),
								.encnt2(encnt2),
								.cnt1_reg(cnt1_reg),
								.cnt2_reg(cnt2_reg),
								.cnt3_reg(cnt3_reg),
								.cnt4_reg(cnt4_reg),
								.addr(addr)
);
								

endmodule
