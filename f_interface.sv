interface f_interface(input clk, rst);
 bit [127:0] i_wrdata;
   bit i_wren ;
   bit i_rden;
  
  
  bit o_full;
  bit o_empty;
  bit o_alm_full;
  bit o_alm_empty;
  bit [127:0] o_rddata;
  
  
  clocking d_cb @(posedge clk);
    default input #1 output #1;
    input o_rddata;
    input o_full;
    input o_empty;
    input o_alm_full;
    input o_alm_empty;
    output i_wrdata;
    output i_rden;
    output i_wren;
   endclocking
  
  clocking m_cb @(posedge clk);
   default input #1 output #1;
    input o_rddata;
    input o_full;
    input o_empty;
    input o_alm_full;
    input o_alm_empty;
    input i_wrdata;
    input i_rden;
    input i_wren;
   endclocking
  
  modport d_mp (input clk, rst, clocking d_cb);
  modport m_mp (input clk, rst, clocking m_cb);
    
endinterface
