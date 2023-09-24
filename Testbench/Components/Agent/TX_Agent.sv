class TX_Agent  extends uvm_agent;



  `uvm_component_utils(TX_Agent)
  
  
  
  TX_Monitor tx_monitor;
  
  Driver tx_driver;
  
  Sequencer tx_sequencer;
  
  Coverage_Collector  TX_coverage_collector; 
  
  
  function new(string name = "TX_Agent" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of TX_Agent Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of TX_Agent Class",UVM_LOW)

    tx_monitor = TX_Monitor::type_id::create("tx_monitor",this);
	 
	 tx_driver = Driver::type_id::create("tx_driver",this);
	 
	 tx_sequencer = Sequencer::type_id::create("tx_sequencer",this);
	 
    TX_coverage_collector = Coverage_Collector::type_id::create("TX_coverage_collector",this); 
        
  
  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of TX_Agent Class",UVM_LOW)
	 
	 
	 tx_driver.seq_item_port.connect(tx_sequencer.seq_item_export);
	 
	 tx_monitor.tx_monitor_port.connect(TX_coverage_collector.analysis_export); 
  
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of TX_Agent Class",UVM_LOW)
  
 
  endtask :run_phase
  
  
  
  
  
  
  
  
endclass :TX_Agent