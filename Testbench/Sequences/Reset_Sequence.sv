class Reset_Sequence extends Base_Sequence;




   `uvm_object_utils(Reset_Sequence)
	
	
    Packet Reset_packet;
	
	
	
	
	
	
	
	function new (string name = "Reset_Sequence");
	
	
	    super.new(name); 
	
	
	endfunction: new

	
	
	
	
	
	
	
	task body();
	
	
	
	
     	Reset_packet = Packet::type_id::create("Reset_packet");
		
	
	
	   start_item(Reset_packet);
		
		
		
		if(!(Reset_packet.randomize() with {  
		                                  							          reset_156m25_n==0;
														  reset_xgmii_rx_n==0;
														  reset_xgmii_tx_n==0;
														  wb_rst_i==1;
														  Loaded_Data.size()==0;				  
														  inter_packet_gap==0; 
														  
														 
														                                } ) )
		
		   `uvm_error(get_type_name(),"randomization failed in Reset_packet")
		
		
		
		finish_item(Reset_packet);
	
	
	
	
	
endtask: body
	
	
	
	
	
	


endclass: Reset_Sequence
