module scope_testing(clock_p,clock_n,a);
input clock_p;
input clock_n;
output a;
/// BUFFER CLOCK Connection from IO PIN
wire temp;
wire ref_clk_buf;
IBUFDS #(
.DIFF_TERM("FALSE"), // Differential Termination
.IBUF_LOW_PWR("TRUE"), // Low power="TRUE", Highest performance="FALSE"
.IOSTANDARD("DEFAULT") // Specify the input I/O standard
) IBUFDS_inst (
.O(temp), // Buffer output
.I(clock_p), // Diff_p buffer input (connect directly to top-level port)
.IB(clock_n) // Diff_n buffer input (connect directly to top-level port)
);
BUFG REF_BUFG(.O(ref_clk_buf),.I(temp));

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

 

set_property PACKAGE_PIN R3 [get_ports clock_p]
set_property IOSTANDARD LVDS_25 [get_ports clock_p]
set_property PACKAGE_PIN P3 [get_ports clock_n]
set_property IOSTANDARD LVDS_25 [get_ports clock_n]
set_property PACKAGE_PIN M26 [get_ports a]
set_property IOSTANDARD LVCMOS33 [get_ports a]