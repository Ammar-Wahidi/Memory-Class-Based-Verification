
class Memory_env;

sequencer   seq_obj     ;
driver      driver_obj  ;

subscriber  sub_obj     ;
scoreboard  score_obj   ;
monitor     mon_obj     ;

mailbox #(transaction) to_driver ;
mailbox #(transaction) to_score ;
mailbox #(transaction) to_sub ;

virtual Memory_interface inv_pointer ;

function new (virtual Memory_interface inv_pointer);
    to_driver = new (1) ;
    to_score = new(1) ;
    to_sub = new(1) ;
    this.inv_pointer = inv_pointer ;
    seq_obj     = new(to_driver) ;
    driver_obj  = new(to_driver,inv_pointer) ;  

    mon_obj     = new(inv_pointer,to_score,to_sub) ;
    score_obj   = new(to_score) ;
    sub_obj     = new(to_sub) ;
endfunction 

task run ();
    fork
        seq_obj.run();
        driver_obj.run();
        mon_obj.run();
        score_obj.run();
        sub_obj.run();
    join_any
    @(posedge inv_pointer.clk);
    @(posedge inv_pointer.clk);
endtask 


endclass
