
class monitor;


transaction transact_mon  ;

virtual Memory_interface inv_pointer ;
mailbox#(transaction) to_score,to_sub ;

function new (virtual Memory_interface inv_pointer,mailbox#(transaction) to_score,mailbox#(transaction) to_sub) ;
this.inv_pointer = inv_pointer ;
this.to_score    = to_score    ;
this.to_sub      = to_sub      ;
endfunction

task run();
forever
begin
    @(posedge inv_pointer.clk);
    transact_mon = new ();
    transact_mon.data_out <= inv_pointer.data_out ;
    transact_mon.valid_out<= inv_pointer.valid_out ;

    transact_mon.rst <= inv_pointer.rst ;
    transact_mon.en <= inv_pointer.en ;
    transact_mon.data_in <= inv_pointer.data_in ;
    transact_mon.address <= inv_pointer.address ;
    
    #1;
    $display("--------------------------mon---------------------------------");
    $display("[%0t] mon: \nrst = %0b \nen = %0b \nData in = %0h \naddress = %0d \nData out = %0h \nValid out = %0b",$time
    ,transact_mon.rst,transact_mon.en,transact_mon.data_in,transact_mon.address,transact_mon.data_out,transact_mon.valid_out); 
    to_score.put(transact_mon);
    to_sub.put(transact_mon); 
end
endtask


endclass
