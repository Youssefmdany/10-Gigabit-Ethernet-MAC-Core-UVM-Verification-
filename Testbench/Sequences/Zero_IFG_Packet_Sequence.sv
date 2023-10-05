class Zero_IFG_Packet_Sequence extends Base_Sequence;




   `uvm_object_utils(Zero_IFG_Packet_Sequence)
	
	
    Packet Bringup_packet;
	
	
	
	
	
	
	
	function new (string name = "Zero_IFG_Packet_Sequence");
	
	
	    super.new(name); 
	
	
	endfunction: new

	
	
	
	
	
	
	
	task body();
	
	
	
	
     	Bringup_packet = Packet::type_id::create("Bringup_packet");
		
	
	
	   start_item(Bringup_packet);
		
		
		
		if(!(Bringup_packet.randomize() with {
		
		                                      								  reset_156m25_n==1;
	                                     	  								  reset_xgmii_rx_n==1;
	                                     	 								  wb_rst_i==0;
														  reset_xgmii_tx_n==1;
                                                 								  ether_len inside {16'h86dd,16'h0800,16'h8137,16'h0806};
														  Loaded_Data.size() inside {[46:1500]};
														  inter_packet_gap==0; 

													
													                                         } ) )
		
		   `uvm_error(get_type_name(),"randomization failed in Bringup_packet")
		
		
		
		finish_item(Bringup_packet);
	
	
	
	
	
endtask: body
	
	
	
	
	
	


endclass: Zero_IFG_Packet_Sequence
