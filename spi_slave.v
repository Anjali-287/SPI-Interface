//---------SPI SLAVE------------//

module spi_slave(sclk,reset,cs,mosi,miso,data_in,data_out,read,load);
  input sclk,cs,mosi,reset,read,load;
  input [7:0]data_in;
  output reg miso;
  output [7:0]data_out;
  int count;
  
  reg [7:0]shift_reg;
  
  reg miso_reg;
  reg [7:0]data_out_reg;
  
  assign data_out=read?data_out_reg:8'h00;
  
  always@(posedge sclk)
    if(load) begin
      shift_reg<=data_in;
      count<=0;
    end
    else if(read)
      data_out_reg<=shift_reg;
      
  always@(negedge sclk,negedge cs)
    if(!reset) begin
      shift_reg<=0;
      miso<=0;
      data_out_reg<=0;
    end
    else 
      if(!cs) begin
        if(!read && !load && count<=8) begin
          shift_reg<={mosi,shift_reg[7:1]};
          miso<=shift_reg[0];
          count<=count+1;
        end
      end
  
endmodule
