//`inlcude "ram_rc.v"

module dualram(clk,pci_clk,rnw,be,ra,wa,di,din_valid,do);

//declare inputs and outputs
input clk;
input pci_clk;
input rnw;
input din_valid;
input [7:0] be;
input [2:0] ra,wa;
input [63:0] di;
output [63:0] do;

//declare wires
wire switch_bank;
wire[63:0] do1,do2,do_next;

//declare registers
reg [63:0] do;
reg rnw_delay;


assign switch_bank = ~rnw;

ram_rc ram1(.clk(clk), .pci_clk(pci_clk), .rnw(rnw), .be(be), .ra(ra), .wa(wa),.di(di),
			.din_valid(din_valid),.do(do1));
			
ram_rc ram2(.clk(clk), .pci_clk(pci_clk), .rnw(switch_bank), .be(be), .ra(ra), .wa(wa),.di(di),
			.din_valid(din_valid),.do(do2));

assign do_next = (rnw_delay) ? do1 : do2;

always @(posedge clk)
begin
	rnw_delay <= rnw;
	do <= do_next;
end

endmodule