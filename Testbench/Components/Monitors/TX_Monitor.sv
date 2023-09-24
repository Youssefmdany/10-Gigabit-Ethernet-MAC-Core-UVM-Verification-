


class TX_Monitor  extends uvm_monitor;




  `uvm_component_utils(TX_Monitor)
  
  
  
  
  virtual Interface intf;
  
  
  
  
  int IGP=0;
  
  	bit pkt_trans = 0;
   
   bit pkt_end=0;
   
	 int m = 2;
	 
   int g = 0;

   logic[63:0] temp_txd;

  logic[7:0] temp_fifo [$];





  uvm_analysis_port #(Packet) tx_monitor_port;
  
  
  Packet packet_item;
  
  

  
  
  
  
  
  
  
  function new(string name = "TX_Monitor" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of TX_Monitor Class",UVM_LOW)
    
    
    
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of TX_Monitor Class",UVM_LOW)
	 
    
	 if(!(uvm_config_db #(virtual Interface)::get(this,"*","intf",intf)))
	 
	     `uvm_error(get_type_name(),"failed to get virtual interface inside TX_Monitor class")
  
  
     
	 tx_monitor_port = new("tx_monitor_port",this);
	 
	 
	 
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of TX_Monitor Class",UVM_LOW)
	
  
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of TX_Monitor Class",UVM_LOW)
  

      
 
	 

	 
	 
	 forever begin 
	  
	 	   
	 
		
		
		
		
		
		if((!intf.reset_156m25_n || !intf.reset_xgmii_tx_n)) begin 
			   
			      packet_item.reset_156m25_n = intf.reset_156m25_n;
			      
			      packet_item.reset_xgmii_rx_n = intf.reset_xgmii_rx_n;
			      
			      packet_item.reset_xgmii_tx_n = intf.reset_xgmii_tx_n;
			      
			      packet_item.wb_rst_i = intf.wb_rst_i;
			       
			       tx_monitor_port.write(packet_item);
			   
			    end
		
		
		
		
		
		
		  @(negedge intf.clk_156m25);
		  
		  
		  
		  
    if((intf.reset_156m25_n && intf.reset_xgmii_tx_n))begin
  

       if(!intf.pkt_tx_val && !intf.pkt_tx_full && !intf.pkt_tx_data==0) begin
			   
			   
			      IGP++;

			   
			   end
			   
			   
			   
          if(intf.pkt_tx_val) begin 
            
            
            
			 
			       if(intf.pkt_tx_sop  && !intf.pkt_tx_eop)begin 
			         
			         
			        if(pkt_end)begin
			        
			       
			           					   packet_item.inter_packet_gap = IGP;
			           					   
			           					   tx_monitor_port.write(packet_item);
			           					   


			        end 
			         
					  
					   packet_item = Packet::type_id::create("packet_item",this);
					    
						 packet_item.dst_addr = intf.pkt_tx_data[63:16];
                   
						 packet_item.src_addr[47:32] = intf.pkt_tx_data[15:0];
					 
					   packet_item.reset_156m25_n = intf.reset_156m25_n;
			      
			       packet_item.reset_xgmii_rx_n = intf.reset_xgmii_rx_n;
			      
			       packet_item.reset_xgmii_tx_n = intf.reset_xgmii_tx_n;
			      
			       packet_item.wb_rst_i = intf.wb_rst_i;
			       					 
				      pkt_trans = 0;
				  
				      IGP = 0;
				     
				     pkt_end = 0;
				      
              m = 2;
              
				      g	= 0;		
				      
				      					 
					 end
			 
			 
			 
			 
			 
			 
			 
						 if(!intf.pkt_tx_sop && !intf.pkt_tx_eop && pkt_trans)begin
			        
			        

			              temp_txd = intf.pkt_tx_data;
								  
									              					  
							       for(int i = 0 ; i < 8 ; i++) begin 
								     									  
																		  
								        temp_fifo.push_back(temp_txd[63:56]);
								  
								        temp_txd = temp_txd << 8;
								       
									     
									   			        
									      end
			        
			        
			       

	                   m = m+8;
			  
			        end
			        
			         
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			       if(!intf.pkt_tx_sop && !intf.pkt_tx_eop && !pkt_trans)begin 
					 
  	     
							    
					      	 packet_item.src_addr[31:0] = intf.pkt_tx_data[63:32];
							
							    packet_item.ether_len = intf.pkt_tx_data[31:16];
								 					 
							    temp_fifo.push_back(intf.pkt_tx_data[15:8]);
								 
							     temp_fifo.push_back(intf.pkt_tx_data[7:0]);
					           
                  	pkt_trans = 1 ;



		                              
		           end
							
		
					 
					 
			 
						        
			        
			        
			        
			 
			       if( intf.pkt_tx_eop && !intf.pkt_tx_sop )begin 
					 
		
                      if(intf.pkt_tx_mod == 0)begin
							           
							            
							            
                          temp_txd = intf.pkt_tx_data;
								  
							            for(int i = 0 ; i < 8 ; i++) begin 
								     									  
																		  
								              temp_fifo.push_back(temp_txd[63:56]);
								  
								              temp_txd = temp_txd << 8;
									  
									  
								                   end
							 
							        
							 
							                  end
								 
								 
                      else begin
							 
							 
							 

							          
                          temp_txd = intf.pkt_tx_data;
								  
							           for(int i = 0 ; i < intf.pkt_tx_mod ; i++) begin 
								     									  
																		  
								               temp_fifo.push_back(temp_txd[7:0]);
								  
								              temp_txd = temp_txd >>8;
									  
									  
								      end
							 
							        
							 
							    end
							    
							    
							
           packet_item.Loaded_Data = new[temp_fifo.size()];

            while(temp_fifo.size()) begin
            
                packet_item.Loaded_Data[g] = temp_fifo.pop_front();
                
                  g++;

                   end
                                                   
 
						
						pkt_end = 1;
						
							 
							end
					    
					 
					 
					
                
                
                
					 end
			 
			 
			 

			 
			 
			 
			 end
			 
			 
			 
			 
			 
			 

			 			 

   

  


	
		


	 end
	 
	 
 
 
  endtask :run_phase
  
  
  
  
  
  
  
  
  
  
endclass :TX_Monitor