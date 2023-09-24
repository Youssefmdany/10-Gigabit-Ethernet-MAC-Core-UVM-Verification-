

package Ethernet_pkg;


 import uvm_pkg::*;
 
 `include "uvm_macros.svh"
 
  `include "Packet.sv" 
  `include "Base_Sequence.sv" 
  `include "Reset_Sequence.sv"
  `include "Small_Packet_Sequence.sv"
  `include "Large_Packet_Sequence.sv"
  `include "Oversized_Packet_Sequence.sv"
  `include "Zero_IFG_Packet_Sequence.sv" 
  `include "Sequencer.sv"   
  `include "Driver.sv" 
  `include "RX_Monitor.sv"
  `include "TX_Monitor.sv" 
  `include "Scoreboard.sv"
  `include "Coverage_collector.sv"
  `include "RX_Agent.sv" 
  `include "TX_Agent.sv"   
  `include "Environment.sv"  
  `include "Ethernet_Test.sv"

 

endpackage 

