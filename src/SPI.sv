//standard spi module
// TODO: add a lock for the PLL instead of using rdy
module spi(
    //Internal ports 
    input clk,
    input wire [7:0] MOSI_data,
    input wire CS_n_i,
    output reg [7:0] MISO_data,
    input rdy,

    //SPI External ports
    input MISO,
    output wire MOSI,
    output wire SCK,
    output wire CS_n);

// State machine
enum {idle, load, communicate} state;
reg[2:0] counter = 3'b000;


reg [7:0] MOSI_buffer;
reg [7:0] MISO_buffer;

assign SCK = (CS_n == 1'b0 & state == communicate)  ? clk : 1'b0;
assign CS_n = CS_n_i;
assign MOSI = MOSI_buffer[7];

// Simple shift register 
//always_ff @(posedge SCK) begin
 //   MISO_buffer <= {MISO_buffer[6:0], MISO};
  //  if(state == communicate & counter)
  //      MOSI_buffer <= {MOSI_buffer[6:0], 1'b1};
        
//end

always @(posedge clk) begin
    if(state == idle) begin
        counter <= 3'b000;
        if(CS_n == 1'b0 & rdy == 1'b1)
            state <= load;
    end
    if(state == load) begin
        MOSI_buffer <= MOSI_data;
        state <= communicate;
    end
    if(state == communicate) begin
         MOSI_buffer <= {MOSI_buffer[6:0], 1'b1};
        if(counter == 3'b111) begin
            counter <= 3'b000;
            if(CS_n == 1'b0) begin
                state <= load;
            end
            else
                state <= idle;
        end
     //   else if (counter == 3'b000) begin
      //      MISO_data <= MISO_buffer;
      //      counter <= counter + 1;
      //  end
        else
            counter <= counter + 1;
    end
end
endmodule