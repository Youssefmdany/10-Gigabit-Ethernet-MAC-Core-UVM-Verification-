
class Coverage_Collector extends uvm_subscriber #(Packet);






  `uvm_component_utils(Coverage_Collector)
  
  
  Packet pkt_item;
  
  
  
  
  
  
   
  
  
  covergroup Ethernet_Signals_Cover;
 
    
	 //option.per_instance = 1;
	 
	 
	 
	 
	 ethernet_inter_packet_gap_cover :coverpoint pkt_item.inter_packet_gap 
	 {
  
	   bins Zero_IGP = {0};
	   
	   bins IGP = {[10:50]};
	 
	   illegal_bins others = default;
	 
	 }

	 

	
	
  ethernet_len_cover:coverpoint pkt_item.ether_len
	 {
	 
	    bins IPv6 = {16'h86dd} ;
	 
	    bins IPv4 = {16'h0800} ;

	    bins IPX = {16'h8137} ;

		 bins ARP = {16'h0806} ;
		 
		 bins others = default ;
		 	 
	 }
	 




	 
	 
	 ethernet_tx_mode_cover:coverpoint (pkt_item.Loaded_Data.size()%8 )
	 {
	 
	    bins mod0 = {0} ;
	 
	    bins mod1 = {1} ;

	    bins mod2 = {2} ;

		 bins mod3 = {3} ;
		 
		 bins mod4 = {4} ;
	 
		 bins mod5 = {5} ;
		 
		 bins mod6 = {6} ;
		 
		 bins mod7 = {7} ;
	 
	 }

    
    
    
	 
   ethernet_data_size_cover:coverpoint pkt_item.Loaded_Data.size() 
	 {
	 
	    bins small_packet = {[46:50]} ;
	 
	    bins large_packet = {[1450:1500]} ;

	    bins oversized_packet = {[1500:9000]} ;

		 
	 
	 }
	 
	 
	 


   endgroup: Ethernet_Signals_Cover
  
  
   
  
  
  
  
  
    covergroup Ethernet_Data_Cover with function sample(bit[7:0] ethernet_data);
 
 
    	// option.per_instance = 1;
    
	 
	    ethernet_data_cover: coverpoint ethernet_data;
	 


    endgroup: Ethernet_Data_Cover
  
  
  
  
  
  
  
  
    function new(string name = "Coverage_collector" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of Coverage Collector Class",UVM_LOW)
  
    Ethernet_Signals_Cover = new();
    
    Ethernet_Data_Cover = new();    
    
  endfunction :new
    
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Coverage Collector Class",UVM_LOW)
	 
  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Coverage Collector Class",UVM_LOW)
	 
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Coverage Collector Class",UVM_LOW)
    
 
  endtask :run_phase

  
  
  
  
  
  
  
  function void write(Packet t);
  
  
    pkt_item = Packet::type_id::create("pkt_item");
	 
	 $cast(pkt_item,t);
  
    Ethernet_Signals_Cover.sample();
    
	 
	  	 
	 
    foreach (pkt_item.Loaded_Data[i])
	     
		  Ethernet_Data_Cover.sample(pkt_item.Loaded_Data[i]);
  
     	 
  endfunction: write
  
  
  

  
  
  
  
endclass: Coverage_Collector