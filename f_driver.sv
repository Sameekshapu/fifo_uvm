class f_driver extends uvm_driver#(f_sequence_item);
  virtual f_interface vif;
  f_sequence_item req;
  `uvm_component_utils(f_driver)
  
  function new(string name = "f_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual f_interface)::get(this, "", "vif", vif))
      `uvm_fatal("Dri: ", "No vif is found!")
  endfunction

  virtual task run_phase(uvm_phase phase);
    @(posedge vif.d_mp.clk)
    if(vif.rst ==0) begin
      vif.d_mp.d_cb.i_wren <= 'b0;
    vif.d_mp.d_cb.i_rden <= 'b0;
    vif.d_mp.d_cb.i_wrdata <= 'b0;
    end
  //  vif.fifo_mp.fifo_cb.o_full <= 'b0;
  //  vif.fifo_mp.fifo_cb.o_empty <= 'b1;
    forever begin
      seq_item_port.get_next_item(req);
      if(req.i_wren == 1)begin 
        main_write(req.i_wrdata);
       // @(posedge vif.i_wrdata)
       // req.o_full <= vif.d_mp.d_cb.o_full;
      end
      else if(req.i_rden == 1) begin
        main_read();
    end
      seq_item_port.item_done();
    end
  endtask
  
    virtual task main_write(input [127:0] din);
      @(posedge vif.d_mp.clk)
    vif.d_mp.d_cb.i_wren <= 'b1;
    vif.d_mp.d_cb.i_wrdata <= din;
      @(posedge vif.d_mp.clk)
    vif.d_mp.d_cb.i_wren <= 'b0;
  endtask
  
  virtual task main_read();
    @(posedge vif.d_mp.clk)
    vif.d_mp.d_cb.i_rden <= 'b1;
    @(posedge vif.d_mp.clk)
    vif.d_mp.d_cb.i_rden <= 'b0;
  endtask

endclass
  
   
