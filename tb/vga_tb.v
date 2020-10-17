module vga_tb();
localparam half_wave = 12.5; //40 mhz clk
localparam period = half_wave*2;
localparam runtime = period * 1000;
reg clk = 0;
wire HSYNC_WIRE, VSYNC_WIRE;
initial
begin
    $dumpfile("vga_tb.vcd");
    $dumpvars(0, vga_tb);

    # runtime $finish;
end
VGA UUT (
    .pxl_clk(clk),
    .rst(1'b0),
    .red(),
    .green(),
    .blue(),
    .HSYNC(HSYNC_WIRE),
    .VSYNC(VSYNC_WIRE));

always #half_wave clk = !clk;
endmodule