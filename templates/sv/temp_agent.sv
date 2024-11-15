class {{ agent_name }}_agent extends uvm_agent;

    {{ agent_name }}_driver driver;
    {{ agent_name }}_monitor monitor;
    {{ agent_name }}_sequencer sequencer;

    // Component macro
    `uvm_component_utils_begin({{ agent_name }}_agent)
        `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
    `uvm_component_utils_end

   // Constractor
   function new(string name, uvm_component parent);
       super.new(name, parent);
   endfunction : new

      // UVM build_phase
   virtual function void build_phase(uvm_phase phase);
       super.build_phase(phase);
       monitor = {{ agent_name }}_monitor::type_id::create("monitor", this);
       if (is_active == UVM_ACTIVE) begin
           sequencer = {{ agent_name }}_sequencer::type_id::create("sequencer", this);
           driver = {{ agent_name }}_driver::type_id::create("driver", this);
       end
   endfunction : build_phase

    virtual function void connect_phase (uvm_phase phase);
    if (is_active == UVM_ACTIVE)
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction : connect_phase

endclass : {{ agent_name }}_agent