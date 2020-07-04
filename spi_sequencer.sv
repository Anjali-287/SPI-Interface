
//SPI Sequencer

class spi_sequencer extends uvm_sequencer#(spi_seq_item);
  
  `uvm_component_utils(spi_sequencer)
  
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
  endfunction
  
endclass
