package {{ agent_name }}_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"


typedef uvm_config_db#(virtual {{ agent_name }}_if) {{ agent_name }}_vif_config;
`include "{{ agent_name }}_packet.sv"
`include "{{ agent_name }}_monitor.sv"
`include "{{ agent_name }}_sequencer.sv"
`include "{{ agent_name }}_seqs.sv"
`include "{{ agent_name }}_driver.sv"
`include "{{ agent_name }}_agent.sv"
`include "{{ agent_name }}_env.sv"

endpackage
