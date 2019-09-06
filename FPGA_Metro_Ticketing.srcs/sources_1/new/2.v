module scope_testing(clock,a);

input clock;
output a;

/// BUFFER CLOCK Connection from IO PIN
wire ref_clk_buf;

BUFG REF_BUFG(.O(ref_clk_buf),.I(clock));


reg [5:0]divide=0;
reg a=0;

always@(posedge ref_clk_buf)
begin
divide<=divide+1;
if(divide==10)
begin
a<=~a;
divide<=0;
end
end
endmodule


XDC:

create_clock -period 10.000 -name clock -waveform {0.000 5.000} [get_ports clock];

set_property PACKAGE_PIN P16 [get_ports clock];
set_property PACKAGE_PIN P26 [get_ports a];
set_property IOSTANDARD LVCMOS33 [get_ports clock];
set_property IOSTANDARD LVCMOS33 [get_ports a];