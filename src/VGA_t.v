// VGA timing block. 800x600 resolution with
// pixel clock = 40 MHz

module VGA_t(
    input  pxl_clk,
    input  rst,
    output HSYNC,
    output rdy,
    output VSYNC);

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
integer v_line_cnt = 0;

assign rdy = h_disp & v_disp;

//HSYNC timing
always @(posedge pxl_clk)
begin
    if(rst == 1'b1) begin
        HSYNC  <= 1'b1;
        h_disp <= 1'b0;
    end
    else begin
        if(h_pxl_cnt >= 0 && h_pxl_cnt < h_visible-1) begin
            HSYNC  <= 1'b1;
            h_disp <= 1'b1;
        end else if (h_pxl_cnt >= h_visible-1 && h_pxl_cnt < h_front_porch-1)
            h_disp <= 1'b0;
        else if (h_pxl_cnt >= h_front_porch-1 && h_pxl_cnt < h_sync_pulse-1)
            HSYNC  <= 1'b0;
        else if (h_pxl_cnt == h_back_porch-1)
            h_disp <= 1'b1;
        else 
            HSYNC <= 1'b1;
    end
end

//VSYNC timing
always @(posedge pxl_clk)
begin
    if(rst == 1'b1) begin
        VSYNC  <= 1'b1;
        v_disp <= 1'b0;
    end
    else begin
        if(v_line_cnt >= 0 && v_line_cnt < v_visible-1) begin
            VSYNC <= 1'b1;
            v_disp <= 1'b1;
        end else if (v_line_cnt == v_visible-1 && h_pxl_cnt == h_back_porch-1)
            v_disp <= 1'b0;
        else if (v_line_cnt == v_front_porch-1 && h_pxl_cnt == h_back_porch-1)
            VSYNC <= 1'b0;
        else if (v_line_cnt == v_sync_pulse-1 && h_pxl_cnt == h_back_porch-1)
            VSYNC <= 1'b1;
        else if (v_line_cnt == v_back_porch-1 && h_pxl_cnt == h_back_porch-1)
            v_disp <= 1'b1;
    end
end

//Vertical line count 
always @(posedge pxl_clk)
begin
    if(rst == 1'b1)
        v_line_cnt <= 0;
    else if((v_line_cnt < v_back_porch-1) && (h_pxl_cnt == h_back_porch-1))
        v_line_cnt <= v_line_cnt + 1;
    else if (v_line_cnt == v_back_porch-1 && (h_pxl_cnt == h_back_porch-1))
        v_line_cnt <= 0;
end

//Horizontal pixel count
always @(posedge pxl_clk)
begin
    if(rst == 1'b1) 
        h_pxl_cnt <= 0;
    else if(h_pxl_cnt < h_back_porch-1)
        h_pxl_cnt <= h_pxl_cnt + 1;
    else
        h_pxl_cnt <= 0;
end

endmodule
