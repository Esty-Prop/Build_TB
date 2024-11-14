

class yapp_monitor extends uvm_monitor;

    virtual interface yapp_if vif;

    // Collected Data handle
     pkt_col;

    // Count packets collected
    int num_pkt_col;

    // analysis port
    //uvm_analysis_port#(yapp_packet) item_collected_port;

    // component macro
    `uvm_component_utils_begin(yapp_monitor)
        `uvm_field_int(num_pkt_col, UVM_ALL_ON)
    `uvm_component_utils_end

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

     function void connect_phase (uvm_phase phase);
        if (! yapp_vif_config::get(
            this, get_full_name(), "vif",vif) )
            `uvm_error(get_full_name(), "Missing virtual I/F")

    endfunction : connect_phase


    task run_phase(uvm_phase phase);
        // Look for packets after reset
         @(negedge vif.rst)
         @(posedge vif.rst)

        forever begin
            // Create collected packet instance
            pkt_col = yapp_pkt ::type_id::create("pkt_col", this);

            // concurrent blocks for packet collection and transaction recording
            fork

                vif.collect_packet(
                    
              .paddr( pkt_col.paddr),
               
              .prdata( pkt_col.prdata),
               
              .pwdata( pkt_col.pwdata),
               
              .pwrite( pkt_col.pwrite),
               
              .pready( pkt_col.pready),
               
              .psel( pkt_col.psel),
               
              .penable( pkt_col.penable)
                );
                // trigger transaction at start of packet
                @(posedge vif.monstart) void'(begin_tr(pkt_col, "Monitor_yapp_Packet"));
            join

            // End transaction recording
            end_tr(pkt_col);
            num_pkt_col++;
            `uvm_info(get_type_name(), $sformatf("Packet Collected :\n%s", pkt_col.sprint()), UVM_LOW)
        end

    endtask : run_phase

      // UVM report_phase
    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Report: yapp Monitor Collected %0d Packets", num_pkt_col), UVM_LOW)
    endfunction : report_phase

endclass : yapp_monitor