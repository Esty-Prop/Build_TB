class yapp_agent extends uvm_agent;

    yapp_driver driver;
    yapp_monitor monitor;
    yapp_sequencer sequencer;

    // Component macro
    `uvm_component_utils_begin(yapp_agent)
        `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
    `uvm_component_utils_end

   // Constractor
   function new(string name, uvm_component parent);
       super.new(name, parent);
   endfunction : new

      // UVM build_phase
   virtual function void build_phase(uvm_phase phase);
       super.build_phase(phase);
       monitor = yapp_monitor::type_id::create("monitor", this);
       if (is_active == UVM_ACTIVE) begin
           sequencer = yapp_sequencer::type_id::create("sequencer", this);
           driver = yapp_driver::type_id::create("driver", this);
       end
   endfunction : build_phase

    virtual function void connect_phase (uvm_phase phase);
    if (is_active == UVM_ACTIVE)
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction : connect_phase

endclass : yapp_agent