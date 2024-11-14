class yapp_packet extends uvm_sequence_item;

  // Physical Data
    
   rand bit [ADDR_WIDTH-1:0]  PADDR;
    
   rand bit [DATA_WIDTH-1:0]  PRDATA;
    
   rand bit [DATA_WIDTH-1:0]  PWDATA;
    
   rand bit   PWRITE;
    
   rand bit   PREADY;
    
   rand bit   PSEL;
    
   rand bit   PENABLE;
    

  // Control Knobs


  // UVM macros for built-in automation - These declarations enable automation
  // of the data_item fields
  `uvm_object_utils_begin(yapp_packet)

  `uvm_object_utils_end

  // Constructor - required syntax for UVM automation and utilities
  function new (string name = "yapp_packet");
    super.new(name);
  endfunction : new

  // Default Constraints
  //constraint default_length { length > 0; length < 64; }

  // Constrain for mostly GOOD_PARITY packets
  //constraint default_parity { parity_type dist {BAD_PARITY := 1, GOOD_PARITY := 5}; }

endclass : yapp_packet
