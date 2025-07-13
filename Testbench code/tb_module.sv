`include "test.sv"

module tb;
    
   abp_if vif();
  test t;

 apb_ram dut (vif.presetn, vif.pclk, vif.psel, vif.penable, vif.pwrite, vif.paddr, vif.pwdata, vif.prdata, vif.pready,vif.pslverr);
   
    initial begin
      vif.pclk <= 0;
    end
    
    always #10 vif.pclk <= ~vif.pclk;
  
    initial begin
      t= new(vif);
      t.e.gen.count = 30;
      t.run();
    end
       
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
   
    
  endmodule
