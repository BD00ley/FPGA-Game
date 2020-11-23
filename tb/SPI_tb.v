`timescale 1us/100ps

module SPI_tb();
localparam period = 0.025; //40 mhz clk
localparam runtime = 40; // 1 second
localparam CS_n_fall = 40;
reg clk = 1'b0;
wire MOSI_data = 8'b11001101;
reg[7:0] data_out = 8'b00000000;
reg CS_n_i = 1'b1;
reg[7:0] MISO_data = 8'b01100011;
wire[7:0] MISO_wire;
wire MISO;
wire flag;
reg flag_latch = 1'b0;
wire MOSI, SCK, CS_n;
assign flag = (data_out == 8'b01001101) ? 1'b1 : 1'b0;
assign MISO = (flag_latch == 1'b1) ? MISO_data[7] : 1'b1;
initial
begin
    $dumpfile("spi_tb.vcd");
    $dumpvars(0, SPI_tb);
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
    .MISO_data(MISO_wire),
    .rdy(rdy),

    //SPI External ports
    .MISO(MISO),
    .MOSI(MOSI),
    .SCK(SCK),
    .CS_n(CS_n));

always #(period/2) clk = !clk;

always @(posedge SCK) begin
    data_out <= {data_out[6:0], MOSI};
    if(flag_latch == 1'b1) begin
        MISO_data <= { MISO_data[6:0], 1'b1};
    end
end

always @(posedge flag) begin
    if(flag == 1'b1)
        flag_latch <= 1'b1; 
end
endmodule