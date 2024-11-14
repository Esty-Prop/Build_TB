class yapp_base_seq extends uvm_sequence#(yapp_packet);

  // Required macro for sequences automation
  `uvm_object_utils(yapp_base_seq)

  // Constructor
  function new(string name="yapp_base_seq");
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

endclass : yapp_base_seq


// SEQUENCE: yapp_5_packets
//-----------------------------------------------------------------------------
class yapp_5_packets extends yapp_base_seq;

  // Required macro for sequences automation
  `uvm_object_utils(yapp_5_packets)

  // Constructor
  function new(string name="yapp_5_packets");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_5_packets sequence", UVM_LOW)
     repeat(5)
      `uvm_do(req)
  endtask

endclass : yapp_5_packets


// SEQUENCE: Manual sending
//------------------------------------------------------------------------------

class yapp_2_seq extends yapp_base_seq;

  // Required macro for sequences automation
  `uvm_object_utils(yapp_2_seq)

  // Constructor
  function new(string name="yapp_2_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_INCR_PAYLOAD_SEQ", UVM_LOW)
    `uvm_create(req)
    assert(req.randomize());
    `uvm_send(req)
  endtask
endclass : yapp_2_seq
