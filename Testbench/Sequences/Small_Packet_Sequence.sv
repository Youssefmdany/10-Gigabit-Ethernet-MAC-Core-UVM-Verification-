class Small_Packet_Sequence extends Base_Sequence;




   `uvm_object_utils(Small_Packet_Sequence)
	
	
    Packet Bringup_packet;
	
	
	
	
	
	
	
	function new (string name = "Small_Packet_Sequence");
	
	
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
														  Loaded_Data.size() inside {[46:50]};
														  inter_packet_gap inside {[10:50]}; 
														
													
													                     } ) )
		
		   `uvm_error(get_type_name(),"randomization failed in Bringup_packet")
		
		
		
		finish_item(Bringup_packet);
	
	
	
	
	
endtask: body
	
	
	
	
	
	


endclass: Small_Packet_Sequence
