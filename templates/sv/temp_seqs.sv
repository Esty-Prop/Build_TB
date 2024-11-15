class {{ agent_name }}_base_seq extends uvm_sequence#({{ agent_name }}_packet);

  // Required macro for sequences automation
  `uvm_object_utils({{ agent_name }}_base_seq)

  // Constructor
  function new(string name="{{ agent_name }}_base_seq");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body

endclass : {{ agent_name }}_base_seq


// SEQUENCE: {{ agent_name }}_5_packets
//-----------------------------------------------------------------------------
class {{ agent_name }}_5_packets extends {{ agent_name }}_base_seq;

  // Required macro for sequences automation
  `uvm_object_utils({{ agent_name }}_5_packets)

  // Constructor
  function new(string name="{{ agent_name }}_5_packets");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing {{ agent_name }}_5_packets sequence", UVM_LOW)
     repeat(5)
      `uvm_do(req)
  endtask

endclass : {{ agent_name }}_5_packets


// SEQUENCE: Manual sending
//------------------------------------------------------------------------------

class {{ agent_name }}_2_seq extends {{ agent_name }}_base_seq;

  // Required macro for sequences automation
  `uvm_object_utils({{ agent_name }}_2_seq)

  // Constructor
  function new(string name="{{ agent_name }}_2_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing {{ agent_name }}_INCR_PAYLOAD_SEQ", UVM_LOW)
    `uvm_create(req)
    assert(req.randomize());
    `uvm_send(req)
  endtask
endclass : {{ agent_name }}_2_seq

