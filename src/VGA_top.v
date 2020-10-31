module VGA_top(
    input pxl_clk,
    input rst,
    input [(8-1):0] video_data_in,
    input [(8-1):0] video_data_out);

wire rdy;
VGA_t video_timing (
    .pxl_clk(pxl_clk),
    .rst(rst),
    .HSYNC(HSYNC),
    .rdy(rdy),
    .VSYNC(VSYNC));

VGA_d video_data (
    .DATA_IN(video_data_in),
    .DATA_OUT(video_data_out),
    .pxl_clk(pxl_clk),
    .rdy(rdy));
    
endmodule