`timescale 1ps/1ps


class Ethernet_Test  extends uvm_test;



  `uvm_component_utils(Ethernet_Test)
  
  
  
  Environment Ethernet_env;
  
  
  
  Reset_Sequence reset_seq;
  
  Small_Packet_Sequence sps_seq;

  Large_Packet_Sequence lps_seq;
  
  Oversized_Packet_Sequence osps_seq;

  Zero_IFG_Packet_Sequence zifg_seq;
  
  
  
  
  
  function new(string name = "Ethernet_Test" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Ethernet Test Class",UVM_LOW)
  
  
  endfunction :new
  
  
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Ethernet Test Class",UVM_LOW)

	 
	 Ethernet_env = Environment::type_id::create("Ethernet_env",this);
	 
	 
  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Ethernet Test Class",UVM_LOW)
	 
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Ethernet Test Class",UVM_LOW)
  
   
	
	
	 phase.raise_objection(this);
	 
	   
    #6400
	   //apply reset sequence
	
           
      reset_seq = Reset_Sequence::type_id::create("reset_seq");
	 
	    reset_seq.start(Ethernet_env.tx_agent.tx_sequencer);
	    
	   #30;
	    
		 
		 repeat(500) begin 
		 
      
		  #50;
		  		 
       sps_seq = Small_Packet_Sequence::type_id::create("sps_seq");
	 
	     sps_seq.start(Ethernet_env.tx_agent.tx_sequencer);
		 

		 end
	 
	 
	 
	 
	 
	 
		 repeat(500) begin 
		 
      
		  #50;
		  		 
		  lps_seq = Large_Packet_Sequence::type_id::create("lps_seq");
	 
	     lps_seq.start(Ethernet_env.tx_agent.tx_sequencer);
		 

		 end
	 
	 
	 
	 
	 
	 
		 repeat(100) begin 
		 
      
		  #50;
		  		 
		  zifg_seq = Zero_IFG_Packet_Sequence::type_id::create("zifg_seq");
	 
	     zifg_seq.start(Ethernet_env.tx_agent.tx_sequencer);
		 

		 end
	


	
	
	
		 repeat(100) begin 
		 
      
		  #50;
		  		 
		  osps_seq = Oversized_Packet_Sequence::type_id::create("osps_seq");
	 
	     osps_seq.start(Ethernet_env.tx_agent.tx_sequencer);
		 

		 end 
	
	
	
	 
	 
	 phase.drop_objection(this);
  
  

  

  endtask :run_phase
  
  
  
  
  
  
  
  
  
  
  
endclass :Ethernet_Test