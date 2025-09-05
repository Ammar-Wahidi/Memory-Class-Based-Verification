
class driver;

transaction transact_drv ;
virtual Memory_interface inv_pointer ;
mailbox #(transaction) to_driver ;

function new (mailbox #(transaction) to_driver,virtual Memory_interface inv_pointer) ;
this.to_driver    = to_driver ;
this.inv_pointer  = inv_pointer ;
endfunction

task run();
#1step;
to_driver.get(transact_drv) ;
inv_pointer.rst     <= transact_drv.rst ;
inv_pointer.en      <= transact_drv.en ;
inv_pointer.data_in <= transact_drv.data_in ;
inv_pointer.address <= transact_drv.address ;

#1;
$display("--------------------------drv---------------------------------");
$display("[%0t] Drv: \nrst = %0b \nen = %0b \nData in = %0h \naddress = %0d",$time,inv_pointer.rst,inv_pointer.en,inv_pointer.data_in,inv_pointer.address);
forever 
begin
    @(inv_pointer.cb);
    to_driver.get(transact_drv) ;
    inv_pointer.cb.rst     <= transact_drv.rst ;
    inv_pointer.cb.en      <= transact_drv.en ;
    inv_pointer.cb.data_in <= transact_drv.data_in ;
    inv_pointer.cb.address <= transact_drv.address ;

    #2;
    $display("--------------------------drv---------------------------------");
    $display("[%0t] Drv: \nrst = %0b \nen = %0b \nData in = %0h \naddress = %0d",$time,inv_pointer.rst,inv_pointer.en,inv_pointer.data_in,inv_pointer.address);
end
endtask

endclass