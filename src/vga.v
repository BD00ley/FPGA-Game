module VGA(pxl_clk, rst, red, green, blue, HSYNC, VSYNC);
input pxl_clk, rst;
output [2:0] red, green;
output [1:0] blue;
output HSYNC, VSYNC;

reg HSYNC = 1, VSYNC = 1, h_disp = 1, v_disp = 1;

localparam h_visible = 800;
localparam h_front_porch = h_visible+40;
localparam h_sync_pulse = h_front_porch+128;
localparam h_back_porch = h_sync_pulse+88;

localparam v_visible = 600;
localparam v_front_porch = v_visible+1;
localparam v_sync_pulse = v_front_porch+4;
localparam v_back_porch = v_sync_pulse+23;

integer h_pxl_cnt = 0;
integer v_pxl_cnt = 0;

//pixel clock = 25.175 mhz
always @(posedge pxl_clk)
begin
    if(rst == 1'b1) begin
        HSYNC <= 1'b1;
        h_disp <= 1'b0;
        h_pxl_cnt <= 0;
    end
    else begin
        if(h_pxl_cnt >= 0 && h_pxl_cnt < h_visible-1) begin
            HSYNC  <= 1'b1;
            h_disp <= 1'b1;
        end else if (h_pxl_cnt >= h_visible-1 && h_pxl_cnt < h_front_porch )
            h_disp <= 1'b0;
        if (h_pxl_cnt >= h_front_porch-1 && h_pxl_cnt < h_sync_pulse-1)
            HSYNC  <= 1'b0;
        else 
            HSYNC <= 1'b1;
    end
end

always @(posedge pxl_clk)
begin
    if(h_pxl_cnt < 1055)
        h_pxl_cnt <= h_pxl_cnt + 1;
    else
        h_pxl_cnt <= 0;
end
endmodule
