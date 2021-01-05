default:
	iverilog -o spi SPI_tb.v ../src/SPI.sv -g2012
	vvp spi
	gtkwave spi_tb.vcd

