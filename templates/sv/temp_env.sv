class {{ agent_name }}_env extends uvm_env;

  // Components of the environment
  {{ agent_name }}_agent {{ agent_name }}_agent;

  // component macro
  `uvm_component_utils({{ agent_name }}_env)

  // component constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // UVM build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    {{ agent_name }}_agent = {{ agent_name }}_agent::type_id::create("{{ agent_name }}_agent", this);
  endfunction : build_phase

  // start_of_simulation
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

endclass : {{ agent_name }}_env
