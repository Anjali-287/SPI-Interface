
//SPI interface

interface spi_interface(input logic mclk,reset);
  logic load_master;
  logic load_slave;
  logic read_master;
  logic read_slave;
  logic start;
  logic [7:0]data_in_master;
  logic [7:0]data_in_slave;
  logic [7:0]data_out_master;
  logic [7:0]data_out_slave;
  
  
  
  clocking driver_cb @(posedge mclk);
    default input #0 output #0;
    output load_master;
    output load_slave;
    output read_master;
    output read_slave;
    output start;
    output data_in_master;
    output data_in_slave;
    input data_out_master;
    input data_out_slave;
  endclocking
  
  clocking monitor_cb @(posedge mclk);
    default input #0 output #0;
    input load_master,load_slave;
    input read_master,read_slave;
    input start;
    input data_in_master,data_in_slave;
    input data_out_master,data_out_slave;
  endclocking
  
  modport DRIVER  (clocking driver_cb,input mclk,reset);
  modport MONITOR (clocking monitor_cb,input mclk,reset);
  
endinterface
