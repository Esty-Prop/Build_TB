class {{ agent_name }}_driver extends uvm_driver #({{ agent_name }}_packet);

  // Declare this property to count packets sent
  int num_sent;

  virtual interface {{ agent_name }}_if vif;

  // component macro
  `uvm_component_utils_begin({{ agent_name }}_driver)
    `uvm_field_int(num_sent, UVM_ALL_ON)
  `uvm_component_utils_end

  // Constructor - required syntax for UVM automation and utilities
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void connect_phase(uvm_phase phase);
    if (!{{ agent_name }}_vif_config::get(this,"","vif", vif))
      `uvm_error("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
  endfunction: connect_phase

  // start_of_simulation
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
  endfunction : start_of_simulation_phase

  // UVM run_phase
  task run_phase(uvm_phase phase);
    fork
      get_and_drive();
      rst_signals();
    join
  endtask : run_phase

  // Gets packets from the sequencer and passes them to the driver.
  task get_and_drive();
    @(posedge vif.rst);
    @(negedge vif.rst);
    `uvm_info(get_type_name(), "rst dropped", UVM_MEDIUM)
    forever begin
      // Get new item from the sequencer
      seq_item_port.get_next_item(req);

      `uvm_info(get_type_name(), $sformatf("Sending Packet :\n%s", req.sprint()), UVM_HIGH)

      fork
        // send packet
        begin
        vif.send_to_dut(
            {% for signal in signals %}
            {%- if signal.dut_dir == "input" -%}
            req.{{ signal.name | lower }}{% if not loop.last %},
            {% endif -%}
            {%- endif -%}
            {% endfor %}
        );
        end
        // trigger transaction at start of packet (trigger signal from interface)
        @(posedge vif.drvstart) void'(begin_tr(req, "Driver_{{ agent_name }}_Packet"));
      join

      // End transaction recording
      end_tr(req);
      num_sent++;
      // Communicate item done to the sequencer
      seq_item_port.item_done();
    end
  endtask : get_and_drive

  // rst all TX signals
  task rst_signals();
    forever
     vif.{{ agent_name }}_rst();
  endtask : rst_signals

  // UVM report_phase
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: {{ agent_name }} TX driver sent %0d packets", num_sent), UVM_LOW)
  endfunction : report_phase

endclass : {{ agent_name }}_driver
