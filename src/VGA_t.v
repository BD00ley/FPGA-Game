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

integer column = 0;
integer row = 0;

assign rdy = h_disp & v_disp;

//HSYNC timing
always @(posedge pxl_clk)
begin
    if(rst == 1'b1) begin
        HSYNC  <= 1'b1;
        h_disp <= 1'b0;
    end
    else begin
        if(column >= 0 && column < h_visible-1) begin
            HSYNC  <= 1'b1;
            h_disp <= 1'b1;
        end else if (column >= h_visible-1 && column < h_front_porch-1)
            h_disp <= 1'b0;
        else if (column >= h_front_porch-1 && column < h_sync_pulse-1)
            HSYNC  <= 1'b0;
        else if (column == h_back_porch-1)
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
        if(row >= 0 && row < v_visible-1) begin
            VSYNC <= 1'b1;
            v_disp <= 1'b1;
        end else if (row == v_visible-1 && column == h_back_porch-1)
            v_disp <= 1'b0;
        else if (row == v_front_porch-1 && column == h_back_porch-1)
            VSYNC <= 1'b0;
        else if (row == v_sync_pulse-1 && column == h_back_porch-1)
            VSYNC <= 1'b1;
        else if (row == v_back_porch-1 && column == h_back_porch-1)
            v_disp <= 1'b1;
    end
end

//Vertical line count 
always @(posedge pxl_clk)
begin
    if(rst == 1'b1)
        row <= 0;
    else if((row < v_back_porch-1) && (column == h_back_porch-1))
        row <= row + 1;
    else if (row == v_back_porch-1 && (column == h_back_porch-1))
        row <= 0;
end

//Horizontal pixel count
always @(posedge pxl_clk)
begin
    if(rst == 1'b1) 
        column <= 0;
    else if(column < h_back_porch-1)
        column <= column + 1;
    else
        column <= 0;
end

endmodule
