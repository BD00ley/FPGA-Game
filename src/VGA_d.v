module VGA_d(
    input  [7:0] DATA_IN, 
    output [7:0] DATA_OUT, 
    input pxl_clk,
    input rdy);
    
integer i = 0;

//TODO: everything
always @(posedge pxl_clk) begin
    if (rdy == 1'b1) begin
    end
end
endmodule