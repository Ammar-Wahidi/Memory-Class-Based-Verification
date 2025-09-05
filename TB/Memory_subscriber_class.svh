
class subscriber;


transaction transact_sub    ;
mailbox#(transaction) to_sub ;

covergroup cg ;
rst_cp : coverpoint transact_sub.rst ;
rst_cp_tran : coverpoint transact_sub.rst {bins rst_0 = (1=>0=>1);}
en_cp  : coverpoint transact_sub.en  {bins read = {0} ; bins write = {1} ;} 
en_cp_tran : coverpoint transact_sub.rst {bins r_w = (0=>1) ; bins w_r = (1=>0);}
data_in_cp : coverpoint transact_sub.data_in {
    bins data_min = {32'h00000000} ;
    bins data_around = {[32'h00000001:32'hfffffffe]} ;
    bins data_max = {32'hffffffff} ;
    bins data_toggle = {32'h55555555};
}
address_cp : coverpoint transact_sub.address ;
address_en_cp : cross address_cp,en_cp ;
valid_cp : coverpoint transact_sub.valid_out ;
data_out_cp : coverpoint transact_sub.data_out ;
endgroup 


function new (mailbox#(transaction) to_sub ) ;
this.to_sub = to_sub ;
cg = new () ;
endfunction 

task run();
forever
begin
    to_sub.get(transact_sub);
    cg.sample() ;
    $display("--------------------------sub---------------------------------");
    $display("[%0t] sub: \nrst = %0b \nen = %0b \nData in = %0h \naddress = %0d",$time,transact_sub.rst,transact_sub.en,transact_sub.data_in,transact_sub.address);

end
endtask

endclass
