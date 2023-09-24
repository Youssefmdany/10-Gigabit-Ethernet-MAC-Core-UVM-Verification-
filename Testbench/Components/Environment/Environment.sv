
class Environment extends uvm_env;




  `uvm_component_utils(Environment)
  
  
  
  
  TX_Agent tx_agent;
  
  RX_Agent rx_agent;

  Scoreboard scoreboard;
 
  Coverage_Collector coverage_collector;
 
 
 
 
  function new (string name = "Environment" , uvm_component parent);
  
  
     super.new(name,parent);
	  
	  `uvm_info(get_type_name(),"Inside constructor of Environment Class",UVM_LOW)
	  
	  
  
  endfunction: new
 
 
 

 
 
 

 
 function void build_phase (uvm_phase phase);
 
 
 
    super.build_phase(phase);
	 
	 `uvm_info(get_type_name(),"Inside build phase of Environment Class",UVM_LOW)
	 
	 tx_agent = TX_Agent::type_id::create("tx_agent",this);

	 rx_agent = RX_Agent::type_id::create("rx_agent",this);

	 scoreboard = Scoreboard::type_id::create("Scoreboard",this);
	 
	 coverage_collector = Coverage_Collector::type_id::create("coverage_collector",this);
	 
	 
 
 
 endfunction: build_phase
 
 
 
 
 
 
 
   function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Environment Class",UVM_LOW)
	 
	 
	 tx_agent.tx_monitor.tx_monitor_port.connect(scoreboard.tx_pkt_port);

	 rx_agent.rx_monitor.rx_monitor_port.connect(scoreboard.rx_pkt_port);
 
    tx_agent.tx_monitor.tx_monitor_port.connect(coverage_collector.analysis_export);

  
  endfunction :connect_phase

 
 
 
 
 
 
 
endclass: Environment