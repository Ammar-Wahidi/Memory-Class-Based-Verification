
class scoreboard;


transaction transact_score    ;
mailbox#(transaction) to_score ;

int right_count , wrong_count ;
logic valid_out_expeacted ;
logic [31:0] data_out_expeacted ;
reg     [32-1:0]   memory_ref [0:(2**4)- 1]   ;

function new (mailbox#(transaction) to_score) ;
this.to_score = to_score ;
endfunction

task reference_modal();
if (transact_score.rst)
begin
    memory_ref  = '{default:0}    ;
end
else if (transact_score.en)
begin
   memory_ref[transact_score.address]  <= transact_score.data_in         ;       // Write 
end

data_out_expeacted = memory_ref[transact_score.address] ;
valid_out_expeacted = (!transact_score.en&&!transact_score.rst) ;

endtask
task run();
forever
begin
    to_score.get(transact_score);
    reference_modal();
    if (transact_score.valid_out == valid_out_expeacted &&transact_score.data_out == data_out_expeacted  )
    begin
        right_count ++ ;
    end
    else
    begin
        wrong_count ++ ;
    end
    $display("--------------------------score---------------------------------");
    $display("[%0t] score: \nrst = %0b \nen = %0b \nData in = %0h \naddress = %0d \nData out = %0h \nValid out = %0b 
    \nData out expeacted = %0d \nValid out expeacted = %0d",$time
    ,transact_score.rst,transact_score.en,transact_score.data_in,transact_score.address,transact_score.data_out,transact_score.valid_out
    ,data_out_expeacted,valid_out_expeacted);
    $display("Right counts = %0d \nWrong_count = %0d ",right_count,wrong_count);
end
endtask


endclass
