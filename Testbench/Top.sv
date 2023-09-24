
`timescale 1ps/1ps

`include "Interface.sv"




module Top();



import Ethernet_pkg::*;
import uvm_pkg::*;




logic clk_156m25;
logic clk_xgmii_tx;
logic clk_xgmii_rx;
logic wb_clk_i;


assign intf.xgmii_rxc = intf.xgmii_txc;
assign intf.xgmii_rxd = intf.xgmii_txd;


Interface intf( 
                 .clk_156m25(clk_156m25),
                 .clk_xgmii_tx(clk_xgmii_tx),
					  .clk_xgmii_rx(clk_xgmii_rx),
					  .wb_clk_i(wb_clk_i)

                                               );
															  
															  

	


	

							

xge_mac  DUT  (

                 //inputs
					  
                 .clk_156m25          (clk_156m25),
                 .clk_xgmii_tx        (clk_xgmii_tx),
                 .clk_xgmii_rx        (clk_xgmii_rx),
                 .wb_clk_i            (wb_clk_i),
                 .pkt_rx_ren          (intf.pkt_rx_ren),
                 .pkt_tx_data         (intf.pkt_tx_data),
                 .pkt_tx_eop          (intf.pkt_tx_eop),
                 .pkt_tx_mod          (intf.pkt_tx_mod),
                 .pkt_tx_sop          (intf.pkt_tx_sop),
                 .pkt_tx_val          (intf.pkt_tx_val),
                 .xgmii_rxc           (intf.xgmii_rxc),
                 .xgmii_rxd           (intf.xgmii_rxd),
                 .wb_adr_i            (intf.wb_adr_i),
                 .wb_cyc_i            (intf.wb_cyc_i),
                 .wb_dat_i            (intf.wb_dat_i),
                 .wb_stb_i            (intf.wb_stb_i),
                 .wb_we_i             (intf.wb_we_i),
                 .reset_156m25_n      (intf.reset_156m25_n),
                 .reset_xgmii_rx_n    (intf.reset_xgmii_rx_n),
                 .reset_xgmii_tx_n    (intf.reset_xgmii_tx_n),
                 .wb_rst_i            (intf.wb_rst_i),                 

					  //outputs
					  
                 .pkt_rx_avail        (intf.pkt_rx_avail),
                 .pkt_rx_data         (intf.pkt_rx_data),
                 .pkt_rx_eop          (intf.pkt_rx_eop),
                 .pkt_rx_err          (intf.pkt_rx_err),
                 .pkt_rx_mod          (intf.pkt_rx_mod),
                 .pkt_rx_sop          (intf.pkt_rx_sop),
                 .pkt_rx_val          (intf.pkt_rx_val),
                 .pkt_tx_full         (intf.pkt_tx_full),
                 .wb_ack_o            (intf.wb_ack_o),
                 .wb_dat_o            (intf.wb_dat_o),					  
                 .wb_int_o            (intf.wb_int_o),
                 .xgmii_txc           (intf.xgmii_txc),
                 .xgmii_txd           (intf.xgmii_txd)
               


                                                       );															  



																		 
	
initial begin 


clk_156m25 = 0;
clk_xgmii_tx = 0;
clk_xgmii_rx = 0; 
wb_clk_i = 0;

 intf.reset_156m25_n=1;
 intf.reset_xgmii_rx_n=1;
 intf.reset_xgmii_tx_n=1;
 intf.wb_rst_i=0;




   forever begin 
       
		 #3200
		 
       clk_156m25 = ~clk_156m25;
       clk_xgmii_tx = ~clk_xgmii_tx;
       clk_xgmii_rx = ~clk_xgmii_rx; 
       wb_clk_i = ~wb_clk_i;
		 
     end


	  
	  
end








initial begin 

      
      uvm_config_db #(virtual Interface) ::set(null,"*","intf",intf);
		
      run_test("Ethernet_Test");
		
		
end










initial begin 


   #1500000000
   
   	
	$finish();

end




 





	
endmodule


