//top level
module top_level(
    input clk,
    input MISO,
    output MOSI,
    output SCK,
    output CS_n,
    output clk_pin );

wire system_clk;
wire lock;

reg [7:0] test = 8'b00101010;
reg [1:0] counter = 2'b00;
reg [7:0] MISO_data;
reg clk_reg = 1'b0;
assign clk_pin = clk_reg;

// 30 MHz PLL
//pll PLL(
//    .clock_in(clk),
//    .clock_out(system_clk),
//    .locked(lock));


// Clock divider (lol) for my bad logic analyzer
always @(posedge clk) begin
    if(counter == 2'b11)
        clk_reg <= ~clk_reg;
    else
        counter <= counter + 1;
end

spi SPI (
    //Internal ports 
    .clk(clk_reg),
    .MOSI_data(test),
    .CS_n_i(1'b0),
    .MISO_data(MISO_data),
    .rdy(1'b1),

    //SPI External ports
    .MISO(MISO),
    .MOSI(MOSI),
    .SCK(SCK),
    .CS_n(CS_n));

endmodule