class yapp_env extends uvm_env;

  // Components of the environment
  yapp_agent yapp_agent;

  // component macro
  `uvm_component_utils(yapp_env)

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // UVM build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    yapp_agent = yapp_agent::type_id::create("yapp_agent", this);
  endfunction : build_phase

  // start_of_simulation
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

endclass : yapp_env