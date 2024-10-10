module {{ env_name }}_env;
   {{ interface }} {{ interface }}_inst();

   // Creating the environment components
   {% for module in modules %}
   {{ module.type }} u_{{ module.name }}();
   {% endfor %}

endmodule : {{ env_name }}
