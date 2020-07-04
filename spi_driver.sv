
  //SPI Driver

`define DRIV_IF vif.DRIVER.driver_cb

class spi_driver extends uvm_driver#(spi_seq_item);
  
  `uvm_component_utils(spi_driver);
  
  virtual spi_interface vif;
  
  //---------------------------------------
  //Constructor
  //---------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  //---------------------------------------
  //Build phase
  //---------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual spi_interface)::get(this,"","vif",vif))
      begin
        `uvm_error("build_phase","driver virtual interface failed");
      end
  endfunction
  
  //---------------------------------------
  //Run Phase
  //---------------------------------------
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      spi_seq_item trans;
      seq_item_port.get_next_item(trans);
      uvm_report_info("SPI_DRIVER ", $psprintf("Got Transaction %s",trans.convert2string()));
      //---------------------------------------
      //Load Master
      //---------------------------------------
      @(posedge vif.DRIVER.mclk);
      `DRIV_IF.start<=1;
      `DRIV_IF.load_master<=1;
      `DRIV_IF.load_slave<=1;
      `DRIV_IF.data_in_master<=trans.data_in_master;
      `DRIV_IF.data_in_slave<=trans.data_in_slave;
      //---------------------------------------
      //Shifting
      //---------------------------------------
      @(posedge vif.DRIVER.mclk);
      `DRIV_IF.load_master<=0;
      `DRIV_IF.load_slave<=0;
      `DRIV_IF.read_master<=0;
      `DRIV_IF.read_slave<=0;
      repeat(9) @(posedge vif.DRIVER.mclk);
      `DRIV_IF.read_master<=1;
      `DRIV_IF.read_slave<=1;
      //---------------------------------------
      //Reading
      //---------------------------------------
      @(posedge vif.DRIVER.mclk);
      trans.data_out_master=`DRIV_IF.data_out_master;
      trans.data_out_slave=`DRIV_IF.data_out_slave;
     seq_item_port.item_done();
    end
    `DRIV_IF.start<=0;
  endtask
  
endclass
  
  
  
  
  
    
