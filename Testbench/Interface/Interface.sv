
interface Interface (  
                         input logic clk_156m25,
                         input logic clk_xgmii_tx,
                         input logic clk_xgmii_rx,
								         input logic wb_clk_i

                                                         );


	 //outputs      
    logic        pkt_rx_avail;
    logic[63:0]  pkt_rx_data;
    logic        pkt_rx_eop;
    logic        pkt_rx_err;
    logic[2:0]   pkt_rx_mod;
    logic        pkt_rx_sop;
    logic        pkt_rx_val;
    logic        pkt_tx_full;
    logic        wb_ack_o;
    logic[31:0]  wb_dat_o;
    logic        wb_int_o;
    logic[7:0]   xgmii_txc;
    logic[63:0]  xgmii_txd;
	 
	 //inputs
    logic        pkt_rx_ren;
    logic[63:0]  pkt_tx_data;
    logic        pkt_tx_eop;
    logic[2:0]   pkt_tx_mod;
    logic        pkt_tx_sop;
    logic        pkt_tx_val;
    logic[7:0]   wb_adr_i;
    logic        wb_cyc_i;
    logic[31:0]  wb_dat_i;
    logic        wb_stb_i;
    logic        wb_we_i;
    logic[7:0]   xgmii_rxc;
    logic[63:0]  xgmii_rxd; 
	 logic        reset_156m25_n;
	 logic        reset_xgmii_rx_n;
	 logic        reset_xgmii_tx_n;
	 logic        wb_rst_i;
	 




initial begin 

   wb_adr_i = 0;
   wb_cyc_i = 0;
   wb_dat_i = 0;
   wb_stb_i = 0;
   wb_we_i = 0;

end	 

endinterface 