interface yapp_if
(input clk, input rst);

    timeunit 1ns;
    timeprecision 100ps;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import yapp_pkg::*;

   // Actual Signals
   
   logic [ADDR_WIDTH-1:0]  PADDR;
    
   logic [DATA_WIDTH-1:0]  PRDATA;
    
   logic [DATA_WIDTH-1:0]  PWDATA;
    
   logic   PWRITE;
    
   logic   PREADY;
    
   logic   PSEL;
    
   logic   PENABLE;
    

    // signal for transaction recording
    bit monstart, drvstart;
    
    // Reset signals
    task yapp_rst();
        @(negedge rst);
        
        PWDATA        <=  'hz;
        PADDR         <=  'hz;
        PWRITE        <=  'hz;
        PENABLE       <= 1'b0;
        PSEL          <= 1'b0;
        disable send_to_dut;
    endtask : yapp_rst


    task send_to_dut( input
    bit [ADDR_WIDTH-1:0]  paddr,
    bit [DATA_WIDTH-1:0]  pwdata,
    bit   pwrite,
    bit   psel,
    bit   penable
    );

        @(posedge clk)

        // trigger for transaction recording
        drvstart = 1'b1;
        

         
    PADDR = paddr;
    PWDATA = pwdata;
    PWRITE = pwrite;
    PSEL = psel;
    PENABLE = penable;




        // reset trigger
 drvstart <= 'b0;
        

    endtask : send_to_dut

    // Collect Packets
    task collect_packet( output

        bit [ADDR_WIDTH-1:0]  paddr,
    
        bit [DATA_WIDTH-1:0]  prdata,
    
        bit [DATA_WIDTH-1:0]  pwdata,
    
        bit   pwrite,
    
        bit   pready,
    
        bit   psel,
    
        bit   penable
    );


    PADDR = paddr;
    
    PRDATA = prdata;
    
    PWDATA = pwdata;
    
    PWRITE = pwrite;
    
    PREADY = pready;
    
    PSEL = psel;
    
    PENABLE = penable;
    

    endtask : collect_packet

endinterface : yapp_if