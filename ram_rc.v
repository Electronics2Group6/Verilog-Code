//module for each individual RAM

module ram_rc(clk,pci_clk,rnw,be,ra,wa,di,din_valid,doo);

input clk;
input pci_clk;
input rnw;
input din_valid;
input [7:0] be;
input [2:0] ra,wa;
input [63:0] di;

output reg [63:0] doo;

//wires

wire [63:0] mem_data,do_next;
wire [2:0] addr;
wire [63:0] loc0;
wire [63:0] loc1;
wire [63:0] loc2;
wire [63:0] loc3;
wire [63:0] loc4;
wire [63:0] loc5;
wire [63:0] loc6;
wire [63:0] loc7;

wire be0;
wire be1;
wire be2;
wire be3;
wire be4;
wire be5;
wire be6;
wire be7;

reg [63:0] column;
reg [63:0] mem[7:0];


assign addr = (rnw) ? wa : ra;

assign mem_data = mem[addr];

//temporarily storing data
assign loc0 = mem[0];
assign loc1 = mem[1];
assign loc2 = mem[2];
assign loc3 = mem[3];
assign loc4 = mem[4];
assign loc5 = mem[5];
assign loc6 = mem[6];
assign loc7 = mem[7];

//always whenever something changes
//in this, we get the RAM via column
always @( addr or loc0 or loc1 or loc2 or loc3 or loc4 or loc5 or loc6 or loc7)
begin
case(addr)

//TODO UPDATE THIS
3'b000:
column = {loc0[63:56],loc1[63:56],loc2[63:56],loc3[63:56],loc4[63:56],loc5[63:56],loc6[63:56],loc7[63:56]};

3'b001:
column = {loc0[55:48],loc1[55:48],loc2[55:48],loc3[55:48],loc4[55:48],loc5[55:48],loc6[55:48],loc7[55:48]};

3'b010:
column = {loc0[47:40],loc1[47:40],loc2[47:40],loc3[47:40],loc4[47:40],loc5[47:40],loc6[47:40],loc7[47:40]};

3'b011:
column = {loc0[39:32],loc1[39:32],loc2[39:32],loc3[39:32],loc4[39:32],loc5[39:32],loc6[39:32],loc7[39:32]};

3'b100:
column = {loc0[31:24],loc1[31:24],loc2[31:24],loc3[31:24],loc4[31:24],loc5[31:24],loc6[31:24],loc7[31:24]};

3'b101:
column = {loc0[23:16],loc1[23:16],loc2[23:16],loc3[23:16],loc4[23:16],loc5[23:16],loc6[23:16],loc7[23:16]};

3'b110:
column = {loc0[15:8],loc1[15:8],loc2[15:8],loc3[15:8],loc4[15:8],loc5[15:8],loc6[15:8],loc7[15:8]};

3'b111:
column = {loc0[7:0],loc1[7:0],loc2[7:0],loc3[7:0],loc4[7:0],loc5[7:0],loc6[7:0],loc7[7:0]};

endcase
end

//enabling write only for particular bit
assign be7 = (!be[7]) & rnw & din_valid;
assign be6 = (!be[6]) & rnw & din_valid;
assign be5 = (!be[5]) & rnw & din_valid;
assign be4 = (!be[4]) & rnw & din_valid;
assign be3 = (!be[3]) & rnw & din_valid;
assign be2 = (!be[2]) & rnw & din_valid;
assign be1 = (!be[1]) & rnw & din_valid;
assign be0 = (!be[0]) & rnw & din_valid;

always @(posedge pci_clk)
begin

mem[addr] <= {((be7)?di[63:56] : mem_data[63:56]),
				((be7)?di[55:48] : mem_data[55:48]),
				((be7)?di[47:40] : mem_data[47:40]),
				((be7)?di[39:32] : mem_data[39:32]),
				((be7)?di[31:24] : mem_data[31:24]),
				((be7)?di[23:16] : mem_data[23:16]),
				((be7)?di[15:8]  : mem_data[15:8]),
				((be7)?di[7:0]   : mem_data[7:0])};
end

assign do_next = (rnw) ? doo:column;

always@(posedge clk)
begin
	doo <= do_next;
end

endmodule


