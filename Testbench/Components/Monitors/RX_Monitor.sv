class RX_Monitor  extends uvm_monitor;




  `uvm_component_utils(RX_Monitor)
  
  
  virtual Interface intf;
  
  
  
  uvm_analysis_port #(Packet) rx_monitor_port;
  
  
  Packet packet_item;
  
 	bit pkt_trans = 0;
 
         int g = 0;  

    logic[7:0] temp_fifo [$];
  
  
  	  int m = 2;
	 	   
	  logic[63:0] temp_rxd;
  
  
  
  
  function new(string name = "RX_Monitor" ,uvm_component parent);
  
  
    super.new(name,parent);
  
    `uvm_info(get_type_name(),"Inside constructor of RX_Monitor Class",UVM_LOW)
    
    
    
  endfunction :new
  
  
  
  
  
  
  
  function void build_phase(uvm_phase phase);
  
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of RX_Monitor Class",UVM_LOW)
	 
    
	 if(!(uvm_config_db #(virtual Interface)::get(this,"*","intf",intf)))
	 
	     `uvm_error(get_type_name(),"failed to get virtual interface inside RX_Monitor class")
  
  
    
	 rx_monitor_port = new("rx_monitor_port",this);
	 
	 
	 
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of RX_Monitor Class",UVM_LOW)
	
  
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  task  run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of RX_Monitor Class",UVM_LOW)
  
      
	  intf.pkt_rx_ren = 1'b0;
	 
	 forever begin 
	  
	  
  
	  
	 @(posedge intf.clk_156m25);
	 
	 
    if((intf.reset_156m25_n && intf.reset_xgmii_rx_n))begin
  
  
        if(intf.pkt_rx_avail==1)
          
             intf.pkt_rx_ren = 1'b1;
          
          
          
          if(intf.pkt_rx_val) begin 
			 
			 
			 
			 
			       if(intf.pkt_rx_sop)begin 
					 
					    packet_item = Packet::type_id::create("packet_item",this);
					    
						 packet_item.dst_addr = intf.pkt_rx_data[63:16];
                   
						 packet_item.src_addr[47:32] = intf.pkt_rx_data[15:0];
					 
					   pkt_trans = 0;

						g=0;

                                                m=2;
 
					     end
			 
			 
			 
			 
			        if(!intf.pkt_rx_sop && !intf.pkt_rx_eop && pkt_trans)begin
			        
			        
			        

			        		    
			        		    
			              temp_rxd = intf.pkt_rx_data;
								  
								  
							       for(int i = 0 ; i < 8 ; i++) begin 
								     									  
																		  
								        temp_fifo.push_back(temp_rxd[63:56]);;
								  
								       temp_rxd = temp_rxd << 8;
									  
									   
									      end
			        
			                m = m+8;      
			  
			        end
			        
			         
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			       if(!intf.pkt_rx_sop && !intf.pkt_rx_eop && !pkt_trans)begin 
					 
                   
								  packet_item.Loaded_Data = new[2];			
								  			    
					      	 packet_item.src_addr[31:0] = intf.pkt_rx_data[63:32];
							
							    packet_item.ether_len = intf.pkt_rx_data[31:16];
								 					 
							    temp_fifo.push_back(intf.pkt_rx_data[15:8]);
								 
							     temp_fifo.push_back(intf.pkt_rx_data[7:0]);
					           
                  	pkt_trans = 1 ;
		                 
		                              
		           end
			 
			 
			 
			 
			 
			 
			 
			 
			       if(intf.pkt_rx_eop)begin 
					 
					          intf.pkt_rx_ren <= 1'b0;
					          
                      if(intf.pkt_rx_mod == 0)begin
							            
							            
							            
                          temp_rxd = intf.pkt_rx_data;
								  
							     for(int i = 0 ; i < 8 ; i++) begin 
								     									  
																		  
								       temp_fifo.push_back(temp_rxd[63:56]);
								  
								     temp_rxd = temp_rxd << 8;
									  
									  
								      end
							 
							        
							 
							    end
								 
								 
                      else begin
							 
                          temp_rxd = intf.pkt_rx_data;
                          
								  					
								  					
							     for(int i = 0 ; i < intf.pkt_rx_mod ; i++) begin 
								    														  
								     temp_fifo.push_back(temp_rxd[7:0]);
								  
								     temp_rxd = temp_rxd >>8;
									  
									  
								      end
							 
							        
							 
							    end
							 
								 
							 		  

                                                    packet_item.Loaded_Data = new[temp_fifo.size()];

                                                  while(temp_fifo.size()) begin
                                                      
                                                    packet_item.Loaded_Data[g] = temp_fifo.pop_front();

                                                     g++;

                                                  end


							 				if(!intf.pkt_rx_err )
	
	                               rx_monitor_port.write(packet_item);
	        
	        
							end
					    

			
			 
					 end
					 
					 

	   	end
			 
			 
			 
			 
			 
			 
			 else begin 
			   
			      packet_item.reset_156m25_n = intf.reset_156m25_n;
			      
			      packet_item.reset_xgmii_rx_n = intf.reset_xgmii_rx_n;
			      
			      packet_item.reset_xgmii_tx_n = intf.reset_xgmii_tx_n;
			      
			      packet_item.wb_rst_i = intf.wb_rst_i;
			       
			       rx_monitor_port.write(packet_item);
			   
			    end
			 			 

   
	   		
	   				 			 

	   
	   
	   
	   
    end

	

 
  endtask :run_phase
  
  
  
  
  
  
  
  
  
  
endclass :RX_Monitor