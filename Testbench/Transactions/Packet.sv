


class Packet extends uvm_sequence_item;


  
  `uvm_object_utils(Packet);
  
  
  randc logic[7:0]       Loaded_Data [];
  rand logic[47:0]      dst_addr;
  rand logic[47:0]      src_addr;
  rand logic[15:0]      ether_len;
  rand logic[31:0]      inter_packet_gap;  //nearly takes 9.6 micro seconds
  rand logic            reset_156m25_n;
  rand logic            reset_xgmii_rx_n;
  rand logic            reset_xgmii_tx_n;
  rand logic            wb_rst_i;

  

  
  
  

constraint Data_size {

                 Loaded_Data.size() inside {[0:9000]}; 
 
                                                         }
                                                        
                                                         																			
																			
																			
constraint IPG_size {

                 inter_packet_gap inside {[0:50]}; 
 
                                                         }


	


	
function new (string name = "Packet" );	


      super.new(name);
		
		`uvm_info(get_type_name(),"Inside constructor of Ethernet seq item Class",UVM_HIGH);
		
		

endfunction:new																		
																			


																			
																			
																			



endclass: Packet


