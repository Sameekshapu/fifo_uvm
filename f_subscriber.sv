
class addr_subscriber extends uvm_subscriber #(seq_itm);


  	seq_itm req;
  
	`uvm_component_utils(addr_subscriber)
  
	
 	
	
	covergroup cg;

      	option.per_instance = 1;		
      
		A : coverpoint req.a;					// implicit/auto bins
		B : coverpoint req.b;
		Y : coverpoint req.y;

	endgroup: cg
  
  
  
  	 function new(input string name = "addr_subscriber", uvm_component parent = null); 
		super.new(name, parent);
        req = seq_itm::type_id::create("req");
        cg = new();		
  	endfunction: new
  





	virtual function void write(input seq_itm t);

		`uvm_info(get_type_name(),"data rcvd from Monitor ap", UVM_NONE)
		t.print();							// just print transctions

		
		//a  = t.a;
		//b  = t.b;
		//y  = t.y;
      
      	req = t;							// data container req
		
      cg.sample();							// sample coverage whenever received an objects from ap

		`uvm_info(get_type_name(), $sformatf(" ---- cvg is %0f", cg.get_coverage()), UVM_NONE)  // %f -> real number in decimal format

		
	endfunction : write

	


endclass: addr_subscriber          
          
      
