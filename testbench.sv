
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "f_interface.sv"
`include "f_test.sv"

module tb;
  bit clk;
  bit rst;
  
  always #5 clk = ~clk;
  
  initial begin
    clk = 1;
    rst = 1;
    #5;
    rst = 0;
  end
  
  f_interface vif(clk, rst);
  
  SYN_FIFO dut(.clk(vif.clk),
               .rst(vif.rst),
               .i_wrdata(vif.i_wrdata),
               .i_wren(vif.i_wren),
               .i_rden(vif.i_rden),
               .o_full(vif.o_full),
               .o_empty(vif.o_empty),
               .o_rddata(vif.o_rddata));
  
  initial begin
    uvm_config_db # (virtual f_interface)::set(null, "", "vif", vif);
    
    run_test("f_test");
  end
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
endmodule
    
