//standard spi module
module spi(
    //Internal ports 
    input clk,
    input [7:0] MOSI_data,
    input wire CS_n_i,
    input [7:0] MISO_data,
    output rdy,

    //SPI External ports
    input MISO,
    output wire MOSI,
    output wire SCK,
    output wire CS_n);

localparam idle = 2'b00;
localparam load = 2'b01;
localparam send = 2'b10;
localparam done = 2'b11;

reg[1:0] state = idle;
reg[2:0] counter = 0;

reg [7:0] MOSI_buffer;
reg [7:0] MISO_buffer;

assign SCK = (CS_n == 1'b0 & state == send)  ? clk : 1'b0;
assign CS_n = CS_n_i;
assign rdy = (state == idle) ? 1'b1 : 1'b0;
assign MOSI = (state != idle) ? MOSI_buffer[7] : 1'b1;

always @(posedge clk) begin
    if(CS_n == 1'b0 && counter == 0) begin
        MOSI_buffer <= MOSI_data;
    end
end

// Simple shift register 
always @(posedge SCK) begin
    if(state == send & counter != 3'b110)
        MOSI_buffer <= {MOSI_buffer[6:0], 1'b1};
end

always @(posedge clk) begin
    if(state == idle) begin
        if(CS_n == 1'b0)
            state <= load;
    end
    if(state == load) begin
        MOSI_buffer <= MOSI_data;
        state <= send;
    end
    if(state == send) begin
        if(counter == 3'b110) begin
            counter <= 3'b000;
            if(CS_n == 1'b0) begin
                MOSI_buffer <= MOSI_data;
                state <= send;
            end
            else
                state <= idle;
        end
        else
            counter <= counter + 1;
    end
end
endmodule