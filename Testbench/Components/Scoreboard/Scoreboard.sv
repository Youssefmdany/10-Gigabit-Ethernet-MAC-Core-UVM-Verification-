


`uvm_analysis_imp_decl(_tx_pkt_port)
`uvm_analysis_imp_decl(_rx_pkt_port)




class Scoreboard extends uvm_scoreboard;



`uvm_component_utils(Scoreboard)





uvm_analysis_imp_tx_pkt_port #(Packet,Scoreboard) tx_pkt_port;

uvm_analysis_imp_rx_pkt_port #(Packet,Scoreboard) rx_pkt_port;




Packet TX_pkts_fifo[$];

Packet RX_pkts_fifo[$];






function new (string name = "Scoreboard" , uvm_component parent);


   super.new(name,parent);

   `uvm_info(get_type_name(),"Inside constructor of Scoreboard Class",UVM_LOW)
   


endfunction : new







function void build_phase (uvm_phase phase);



     super.build_phase(phase);
	  
	  `uvm_info(get_type_name(),"Inside build phase of Scoreboard Class",UVM_LOW)
	  
	  tx_pkt_port   = new ("tx_pkt_port", this);
	  
    rx_pkt_port   = new ("rx_pkt_port", this);
    
    

endfunction: build_phase







function void connect_phase(uvm_phase phase);


    super.connect_phase(phase);
		  
	 `uvm_info(get_type_name(),"Inside connect phase of Scoreboard Class",UVM_LOW)
		  
		  
endfunction: connect_phase








task run_phase(uvm_phase phase);


   super.run_phase(phase);

	`uvm_info(get_type_name(),"Inside run phase of Scoreboard Class",UVM_LOW)
	
	
	
	
	
  forever begin
     
	Packet curr_pkt_tx;
	
	Packet curr_pkt_rx;
	
	
	wait(TX_pkts_fifo.size() && RX_pkts_fifo.size() );
	   
	
		curr_pkt_tx = TX_pkts_fifo.pop_front();
		
		curr_pkt_rx = RX_pkts_fifo.pop_front();
		
 		
		if(curr_pkt_tx.reset_156m25_n | curr_pkt_rx.reset_156m25_n)
		
	      Compare_pkts(curr_pkt_tx,curr_pkt_rx);

    

end


endtask: run_phase









function void write_tx_pkt_port (Packet pkt);


   TX_pkts_fifo.push_back(pkt);

	

endfunction:write_tx_pkt_port








function void write_rx_pkt_port (Packet pkt);


   RX_pkts_fifo.push_back(pkt);
	


endfunction: write_rx_pkt_port






function void Compare_pkts (ref Packet pkt_tx ,ref Packet pkt_rx);


	


    if(pkt_tx.dst_addr != pkt_rx.dst_addr)
	 
	    `uvm_error(get_type_name(),$sformatf("Invalid destination address as : tx_dst_add = %h ,rx_dst_add = %h ",pkt_tx.dst_addr,pkt_rx.dst_addr))
		 

		 
		 
    if(pkt_tx.src_addr != pkt_rx.src_addr)
	 
	    `uvm_error(get_type_name(),$sformatf("Invalid source address as : tx_src_add = %h ,rx_src_add = %h ",pkt_tx.src_addr,pkt_rx.src_addr))		 
		 

		 
		 
    if(pkt_tx.ether_len != pkt_rx.ether_len)
	 
	    `uvm_error(get_type_name(),$sformatf("Invalid ethernet length as : tx_ether_len = %h ,rx_ether_len = %h ",pkt_tx.ether_len,pkt_rx.ether_len))		 
				 
		 
		 		 
		 
		 
    if(pkt_tx.Loaded_Data.size() != pkt_rx.Loaded_Data.size())
	 
	    `uvm_error(get_type_name(),$sformatf("Invalid data size as : tx_data_size = %h ,rx_data_size = %h ",pkt_tx.Loaded_Data.size(),pkt_rx.Loaded_Data.size()))		 
		 
		 


		 
	
   for(int i=0 ; i<pkt_tx.Loaded_Data.size() ; i++) begin
	

	    if(pkt_tx.Loaded_Data[i] != pkt_rx.Loaded_Data[i])
		      
		    `uvm_error(get_type_name(),$sformatf("Invalid data : tx_data = %h ,rx_data = %h ",pkt_tx.Loaded_Data[i],pkt_rx.Loaded_Data[i]))		
		   
		   
		   	    

	
		
	end
	
	
	


		 
endfunction: Compare_pkts











endclass: Scoreboard