class RX_Agent  extends uvm_agent;



  `uvm_component_utils(RX_Agent)
  
  
  
  RX_Monitor rx_monitor;
    
	 
	 
	 
	 
	 
  
  function new(string name = "RX_Agent" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of RX_Agent Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of RX_Agent Class",UVM_LOW)

    rx_monitor = RX_Monitor::type_id::create("rx_monitor",this);
	 

  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of RX_Agent Class",UVM_LOW)
	 
  
  
  endfunction: connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of RX_Agent Class",UVM_LOW)
  
 
  endtask :run_phase
  
  
  
  
  
  
  
  
endclass :RX_Agent