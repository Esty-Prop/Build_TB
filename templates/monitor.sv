class {{ agent_name }}_monitor extends uvm_monitor;

    virtual interface {{ if_name }} vif;

    // Collected Data handle
    {{ pkt_name }} pkt_col;

    // Count packets collected
    int num_pkt_col;

    // component macro
    `uvm_component_utils_begin({{ agent_name }}_monitor)
        `uvm_field_int(num_pkt_col, UVM_ALL_ON)
    `uvm_component_utils_end

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

     function void connect_phase (uvm_phase phase);
        if (! {{ agent_name }}_vif_config::get(
            this, get_full_name(), "vif",vif) )
            `uvm_error(get_full_name(), "Missing virtual I/F")

    endfunction : connect_phase


    task run_phase(uvm_phase phase);
        // Look for packets after reset
         @(negedge vif.rst)
         @(posedge vif.rst)

        forever begin
            // Create collected packet instance
            pkt_col = {{ pkt_name }}::type_id::create("pkt_col", this);

            // concurrent blocks for packet collection and transaction recording
            fork
                vif.collect_packet(.write(pkt_col.pwrite),
                                   .rdata(pkt_col.prdata),
                                   .addr (pkt_col.paddr ),
                                   .wdata(pkt_col.pwdata)
                );
                // trigger transaction at start of packet
                @(posedge vif.monstart) void'(begin_tr(pkt_col, "Monitor_{{ agent_name }}_Packet"));
            join

            // End transaction recording
            end_tr(pkt_col);
            num_pkt_col++;
            `uvm_info(get_type_name(), $sformatf("Packet Collected :\n%s", pkt_col.sprint()), UVM_LOW)
        end

    endtask : run_phase

      // UVM report_phase
    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Report: {{ agent_name }} Monitor Collected %0d Packets", num_pkt_col), UVM_LOW)
    endfunction : report_phase

endclass : {{ agent_name }}_monitor