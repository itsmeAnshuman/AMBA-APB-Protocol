class driver;
  transaction tr;
  mailbox#(transaction) mbx;
  virtual abp_if vif;
  
  event nextdrv;
  
  function new(mailbox#(transaction) mbx);
    this.mbx=mbx;
  endfunction
  
  task reset();
    vif.presetn<=1'b0;
    vif.penable<=1'b0;
    vif.psel<=1'b0;
    vif.pwdata<=0;
    vif.paddr<=0;
    vif.pwrite<=1'b0;
    repeat(5) @(posedge vif.pclk);
    vif.presetn<=1'b1;
    repeat(5)@(posedge vif.pclk);
    $display("[DRV] : RESET DONE");
  endtask
  
  task run();
    forever begin
      tr=new();
      mbx.get(tr);
      if(tr.oper == 0) // write
        begin
          @(posedge vif.pclk);
          vif.psel<=1'b1;
          vif.penable<=1'b0;
          vif.pwdata<=tr.pwdata;
          vif.paddr<=tr.paddr;
          vif.pwrite<=1'b1;
          @(posedge vif.pclk);
          vif.penable<=1'b1;
          @(posedge vif.pclk);
          vif.psel<=1'b0;
          vif.penable<=1'b0;
          vif.pwrite<=1'b0;
          $display("[DRV] : Data Write op data :%0d and addr :%0d",tr.pwdata , tr.paddr);
        end
      else if (tr.oper == 1) //read
        begin
            @(posedge vif.pclk);
            vif.psel <= 1'b1;
    		vif.penable <= 1'b0;
   		    vif.pwdata <= tr.pwdata;
   		    vif.paddr <= tr.paddr;
  		    vif.pwrite <= 1'b0;
          @(posedge vif.pclk);
           vif.penable <= 1'b1; 
          repeat(2) @(posedge vif.pclk); 
          vif.psel <= 1'b0;
          vif.penable <= 1'b0;
          vif.pwrite <= 1'b0;
          
          $display("[DRV] : DATA READ OP addr : %0d", tr.paddr); 
        end
      else if (tr.oper== 2) ///random
        begin
           @(posedge vif.pclk);
            vif.psel <= 1;
    		vif.penable <= 0;
   		    vif.pwdata <= tr.pwdata;
   		    vif.paddr <= tr.paddr;
  		    vif.pwrite <= tr.pwrite;
          @(posedge vif.pclk);
            vif.penable <= 1; 
          repeat(2) @(posedge vif.pclk); 
          vif.psel <= 1'b0;
          vif.penable <= 1'b0;
          vif.pwrite <= 1'b0;
          $display("[DRV] : RANDOM OPERATION");          
        end
      else if (tr.oper == 3)  ///slv error
        begin
           @(posedge vif.pclk);
            vif.psel <= 1;
    		vif.penable <= 0;
   		    vif.pwdata <= tr.pwdata;
            vif.paddr <= $urandom_range(32,100);
  		    vif.pwrite <= tr.pwrite;
          @(posedge vif.pclk);
            vif.penable <= 1; 
          repeat(2) @(posedge vif.pclk); 
          vif.psel <= 1'b0;
          vif.penable <= 1'b0;
          vif.pwrite <= 1'b0;
          $display("[DRV] : SLV ERROR");       
        end
      ->nextdrv;
    end
  endtask
endclass
      
    
