`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"


class environment;

    generator gen;
    driver drv;
    monitor mon;
    scoreboard sco; 
  
   mailbox #(transaction) gdmbx; ///gen - drv   
  mailbox #(transaction) msmbx;  /// mon - sco
  
    virtual abp_if vif;
 
    event nextgd; ///gen -> drv
    event nextgs;  /// gen -> sco
  
  function new(virtual abp_if vif);   
    gdmbx = new();
    gen = new(gdmbx);
    drv = new(gdmbx);
 
    msmbx = new();
    mon = new(msmbx);
    sco = new(msmbx);
    
    this.vif = vif;
    drv.vif = this.vif;
    mon.vif = this.vif;
    
    gen.nextsco = nextgs;
    sco.nextsco = nextgs;
    
    gen.nextdrv = nextgd;
    drv.nextdrv = nextgd;

  endfunction
endclass
 
