



//SPI Agent


class spi_agent extends uvm_agent;
  
  spi_sequencer seq;
  spi_driver driv;
  spi_monitor mon;
  
  virtual spi_interface vif;
  
  //---------------------------------------
  //Utility and Field macros
  //---------------------------------------
  `uvm_component_utils_begin(spi_agent)
  `uvm_field_object(seq, UVM_ALL_ON)
  `uvm_field_object(driv, UVM_ALL_ON)
  `uvm_field_object(mon, UVM_ALL_ON)
  `uvm_component_utils_end
  
  //---------------------------------------
  //Constructor
  //---------------------------------------  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  //---------------------------------------
  //Build phase
  //---------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    seq=spi_sequencer::type_id::create("seq",this);
    driv=spi_driver::type_id::create("driv",this);
    mon=spi_monitor::type_id::create("mon",this);
    uvm_config_db#(virtual spi_interface)::set(this, "seq", "vif", vif);
    uvm_config_db#(virtual spi_interface)::set(this, "driv", "vif", vif);
    uvm_config_db#(virtual spi_interface)::set(this, "mon", "vif", vif);
    
    if(!uvm_config_db#(virtual spi_interface)::get(this,"","vif",vif))
      begin
        `uvm_error("build_phase","agent virtual interface failed");
      end
    
  endfunction
  
  //---------------------------------------
  //Connect phase
  //---------------------------------------
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driv.seq_item_port.connect(seq.seq_item_export);
    uvm_report_info("SPI_AGENT", "connect_phase, Connected driver to sequencer");
  endfunction
  
endclass
