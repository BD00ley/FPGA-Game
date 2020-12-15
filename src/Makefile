default:
	yosys top.sv SPI.sv -p 'synth_ice40 -top top_level -json test.json';
	nextpnr-ice40 --lp8k --package cm81 --pcf constraints/constraints.pcf --json test.json --asc test.asc;
	icepack test.asc test.bin
	tinyprog -p test.bin
clean:
	rm *.json *.asc
