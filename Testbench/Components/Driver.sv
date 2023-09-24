

class Driver extends uvm_driver #(Packet);



 `uvm_component_utils(Driver)
 

 virtual Interface intf;
 
 
 Packet packet_item;
 
 
 
 function new (string name = "Driver" , uvm_component parent);
 
 
 
     super.new(name,parent);
	  
	  `uvm_info(get_type_name(),"Inside constructor of Driver Class",UVM_LOW)

	  
 
 endfunction: new
 
 
 
 
 
 
 
 
 
   function void build_phase(uvm_phase phase);
  
  
  
  
    super.build_phase(phase);
    
	 
	 `uvm_info(get_type_name(),"Inside build phase of Driver Class",UVM_LOW)
   
   
   if(!(uvm_config_db #(virtual Interface)::get(this,"*","intf",intf)))
	 
	     `uvm_error(get_type_name(),"failed to get virtual interface inside Driver class")
  


  
  
  endfunction :build_phase 
  
  
  
  
  
  
  
  
  
  
  function void connect_phase (uvm_phase phase);
  
  
    super.connect_phase(phase);
	 
	 
	 `uvm_info(get_type_name(),"Inside connect phase of Driver Class",UVM_LOW)
	 
  
  endfunction :connect_phase
  
  
  
  
  
  
  
  
  
  task run_phase(uvm_phase phase);
  
  
    super.run_phase(phase);
  
  
	 `uvm_info(get_type_name(),"Inside run phase of Driver Class",UVM_LOW)
    
	 
	 
	 
	 forever begin 
	 
	 
	 
	  packet_item = Packet::type_id::create("packet_item");

	 
	  seq_item_port.get_next_item(packet_item);
	  
	  
	  drive(packet_item);
	  
	  
	  
	  seq_item_port.item_done();
	  
	  
	 
	 end
	 
 
 
 
  endtask :run_phase

 
 
 
 
 
 
 
 
 
 
   task  drive (Packet packet_item);
	
	
	  int data_len;
	  int num_trans;
	  logic[63:0] tx_data;
	
	   tx_data = 64'b0 ;
	
	//Start the transmission
	  if(packet_item.reset_156m25_n && packet_item.reset_xgmii_rx_n && packet_item.reset_xgmii_tx_n) begin
	    
	    
	  @(posedge intf.clk_156m25);
	  
	  
	   intf.reset_156m25_n = packet_item.reset_156m25_n;
		
	   intf.reset_xgmii_rx_n = packet_item.reset_xgmii_rx_n;
		
	   intf.reset_xgmii_tx_n = packet_item.reset_xgmii_tx_n;
	   
	   intf.wb_rst_i =  packet_item.wb_rst_i;
	   
	   
	   intf.pkt_tx_val = 1'b1;
		
	   intf.pkt_tx_sop = 1'b1;
	   
	   intf.pkt_tx_mod = $urandom_range(7,0);
	  
	   intf.pkt_tx_eop = 1'b0;

	   intf.pkt_tx_data = { packet_item.dst_addr , packet_item.src_addr[47:32] };
		
		
	////////////////////////////////////////////////

	
      data_len = 6 + 6 + 2 + packet_item.Loaded_Data.size(); // 6-> destination addr 6->source addr 2-> frame length 
	   
		
		
		
		
		if(data_len % 8)
		
		   num_trans = data_len / 8 + 1;
			
		else
		
		   num_trans = data_len / 8;
		
		
		
		
		
		if(num_trans==2)  begin
		
		
		   @(posedge intf.clk_156m25);

	 	   intf.pkt_tx_data = { packet_item.src_addr[31:0],
		                      	packet_item.ether_len,
									  	packet_item.Loaded_Data[0],
										packet_item.Loaded_Data[1]   };

       end

		
		
		
		else begin 
		
		
		  @(posedge intf.clk_156m25);
		  
	     intf.pkt_tx_sop = 1'b0;
	 	   intf.pkt_tx_data = { packet_item.src_addr[31:0],
		                      	packet_item.ether_len,
									  	packet_item.Loaded_Data[0],
										packet_item.Loaded_Data[1]   };
		  
		  
		  

		  for(int i = 2 ; i < num_trans ; i++  ) begin 
		  
		  
		  while(intf.pkt_tx_full)begin
		     
		      
		      intf.pkt_tx_val    <= 1'b0;
          intf.pkt_tx_sop    <= 1'b0;
          intf.pkt_tx_eop    <= 1'b0;
          intf.pkt_tx_mod    <= $urandom_range(7,0);
          intf.pkt_tx_data   <= 0;
          
          @(posedge intf.clk_156m25);
          
		      
		      end
		     
		     if(!( num_trans-1 == i )) begin 
			 
				  @(posedge intf.clk_156m25);
			 
				  intf.pkt_tx_val = 1'b1;
				
	 		     intf.pkt_tx_sop = 1'b0;
	   
	   		  intf.pkt_tx_mod = $urandom_range(7,0);
	  
	     		  intf.pkt_tx_eop = 1'b0;

	     		  intf.pkt_tx_data = { packet_item.Loaded_Data[2+(i-2)*8],
			             		        packet_item.Loaded_Data[3+(i-2)*8],
										     packet_item.Loaded_Data[4+(i-2)*8],
										     packet_item.Loaded_Data[5+(i-2)*8],
										     packet_item.Loaded_Data[6+(i-2)*8],
										     packet_item.Loaded_Data[7+(i-2)*8],
										     packet_item.Loaded_Data[8+(i-2)*8],
										     packet_item.Loaded_Data[9+(i-2)*8]
                                                                      	};

			    end
		
	

         else begin 
		
		  	   @(posedge intf.clk_156m25);
			 
				intf.pkt_tx_val = 1'b1;
		
	     	   intf.pkt_tx_sop = 1'b0;
	   
	     	   intf.pkt_tx_mod = data_len % 8;
	  
	         intf.pkt_tx_eop = 1'b1;
            
				for(int k=0 ; k<intf.pkt_tx_mod ; k++) begin

                                          if(k+1==intf.pkt_tx_mod)

				                  tx_data = (tx_data | packet_item.Loaded_Data[2+k+(i-2)*8]);

                                         else
                                                   tx_data = (tx_data | packet_item.Loaded_Data[2+k+(i-2)*8])<<8;

	              end
					  
				if(!intf.pkt_tx_mod)begin 

                                 for(int k=0 ; k<8 ; k++) 
                                       
                                     tx_data = (tx_data | packet_item.Loaded_Data[2+k+(i-2)*8])<<8;

                               end




				 intf.pkt_tx_data = tx_data;
					

              end	
		  
		  
		  
		  
	      end
		
		
		
		
     end
		
		
		
	 
	 repeat(packet_item.inter_packet_gap) begin 
	 
	           @(posedge intf.clk_156m25);
				  
	 			  intf.pkt_tx_val = 1'b0;
				
	 		     intf.pkt_tx_sop = 1'b0;
	   
	   		  intf.pkt_tx_mod = $urandom_range(7,0);
	  
	     		  intf.pkt_tx_eop = 1'b0;

	     		  intf.pkt_tx_data = $urandom_range(65535,0);

	 
	 
	 
	 end
	 
	 
		end
		
		else begin
		 

		  
		       intf.reset_156m25_n =  packet_item.reset_156m25_n;
		
	         intf.reset_xgmii_rx_n =  packet_item.reset_xgmii_rx_n;
		
	         intf.reset_xgmii_tx_n =  packet_item.reset_xgmii_tx_n; 
	          
	         intf.wb_rst_i =  packet_item.wb_rst_i;
	   
		  			 intf.pkt_tx_val = 1'b0;
				
	 		     intf.pkt_tx_sop = 1'b0;
	  
	     		  intf.pkt_tx_eop = 1'b0;
	     		  
	    
	     		  
		  end
		
		
		
		
	
	endtask: drive

	
	
	
 
 
 
 
 
 
 
 
 

endclass: Driver