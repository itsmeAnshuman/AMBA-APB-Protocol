`include "environment.sv"

class test;
  
  transaction tr;
  environment e;
  
 virtual abp_if vif;
  function new( virtual abp_if vif);
    this.vif=vif;
    e=new(vif);
  endfunction
  
   task pre_test();
    e.drv.reset();
  endtask
  
  task test();
  fork
    e.gen.run();
    e.drv.run();
    e.mon.run();
    e.sco.run();
  join_any
  endtask
  
  task post_test();
    wait(e.gen.done.triggered);  
    $finish();
  endtask
  
  task run();
    pre_test();
    
    test();
    post_test();
  endtask

endclass
  
