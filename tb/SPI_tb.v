`timescale 1us/100ps

module SPI_tb();
localparam period = 0.025; //40 mhz clk
localparam runtime = 40; // 1 second
localparam CS_n_fall = 40;
reg clk = 1'b0;
wire MOSI_data = 8'b11001101;
reg CS_n_i = 1'b1;
wire MOSI, SCK, CS_n;
initial
begin
    $dumpfile("spi_tb.vcd");
    $dumpvars(0, UUT);
    #runtime
    CS_n_i = 1'b0;
    #runtime 
    $finish;
end
//standard spi module
spi UUT (
    //Internal ports 
    .clk(clk),
    .MOSI_data(8'b01001101),
    .CS_n_i(CS_n_i),
    .MISO_data(),
    .rdy(rdy),

    //SPI External ports
    .MISO(),
    .MOSI(MOSI),
    .SCK(SCK),
    .CS_n(CS_n));

always #(period/2) clk = !clk;
endmodule