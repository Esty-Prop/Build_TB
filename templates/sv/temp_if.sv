interface {{ agent_name }}_if
(input clk, input rst);

    timeunit 1ns;
    timeprecision 100ps;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import {{ agent_name }}_pkg::*;

   // Actual Signals
   {% for signal in signals %}
   logic {{ signal.size }}  {{ signal.name }};
    {% endfor %}

    // signal for transaction recording
    {% if record_transaction -%}
    bit monstart, drvstart;
    {% endif %}
    // Reset signals
    task {{ agent_name }}_rst();
        {% if rst_active_high -%}
        @(posedge rst);
        {% else -%}
        @(negedge rst);
        {% endif %}
        PWDATA        <=  'hz;
        PADDR         <=  'hz;
        PWRITE        <=  'hz;
        PENABLE       <= 1'b0;
        PSEL          <= 1'b0;
        disable send_to_dut;
    endtask : {{ agent_name }}_rst


    task send_to_dut( input
    {% for signal in signals %}
        {%- if signal.dut_dir == "input" -%}
        bit {{ signal.size }}  {{ signal.name | lower }}{% if not loop.last %},
    {% endif -%}
        {%- endif -%}
    {% endfor %}
    );

        @(posedge clk)

        // trigger for transaction recording
        {% if record_transaction -%}
        drvstart = 1'b1;
        {% endif %}

         {% for signal in signals %}
    {%- if signal.dut_dir == "input" %}
    {{ signal.name }} = {{ signal.name | lower }};
    {%- endif -%}
    {% endfor %}




        // reset trigger
 {% if record_transaction -%}
        drvstart <= 'b0;
        {% endif %}

    endtask : send_to_dut

    // Collect Packets
    task collect_packet( output
{% for signal in signals %}
        bit {{ signal.size }}  {{ signal.name | lower }}{% if not loop.last %},
    {% endif -%}
    {% endfor %}
    );

{% for signal in signals %}
    {{ signal.name }} = {{ signal.name | lower }};
    {% endfor %}

    endtask : collect_packet

endinterface : {{ agent_name }}_if