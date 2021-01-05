// spi module with single chip select
module spi(
    //Internal ports 
    input clk,
    input wire [7:0] MOSI_data,
    input wire CS_n_i,
    output reg [7:0] MISO_data,
    input rdy,
    output loadData,

    //SPI External ports
    input MISO,
    output logic MOSI,
    output logic SCK,
    output logic CS_n);

// State machine;
typedef enum {idle, load, communicate} state_t;
state_t state;

logic MISO_d;
reg[2:0] counter = 3'b000;

// Data Buffers
reg [7:0] MOSI_buffer = 8'b11111111;
reg [7:0] MISO_buffer;

assign loadData = (state == load) ? 1'b1 : 1'b0;
assign MOSI = MOSI_buffer[7];
assign SCK = (CS_n == 1'b0 & state == communicate) ? clk : 1'b0;
assign CS_n = CS_n_i;
    
always_ff @(negedge clk) begin
    case(state)
        load: begin
            MOSI_buffer <= MOSI_data;
        end
        communicate: begin
            MOSI_buffer <= {MOSI_buffer[6:0], 1'b1};
        end
    endcase
end

always_ff @(posedge clk) begin
    MISO_d <= MISO;
    case(state)
        idle: begin
            counter <= 3'b000;
            if(CS_n == 1'b0 & rdy == 1'b1)
                state <= load;
        end
        load: begin
            state <= communicate;
            MISO_data <= MISO_buffer;
        end
        communicate: begin
            MISO_buffer <= {MISO_buffer[6:0], MISO_d};
            if(counter == 3'b111) begin
                counter <= 3'b000;
                if(CS_n == 1'b0) begin
                    state <= load;
                end
                else
                    state <= idle;
            end else
                counter <= counter + 1;
        end
    endcase
end
endmodule