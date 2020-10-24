`timescale 1us/100ps

module vga_tb();
localparam period = 0.025; //40 mhz clk
localparam runtime = (28*10**(3)); // 1 second
reg clk = 1'b0;
wire HSYNC_WIRE, VSYNC_WIRE, rdy_wire;
initial
begin
    $dumpfile("vga_tb.vcd");
    $dumpvars(0, UUT);
    #runtime 
    $finish;
end
VGA_t UUT (
    .pxl_clk(clk),
    .rst(1'b0),
    .HSYNC(HSYNC_WIRE),
    .rdy(rdy_wire),
    .VSYNC(VSYNC_WIRE));

always #(period/2) clk = !clk;
endmodule