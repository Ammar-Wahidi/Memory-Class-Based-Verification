
class sequencer;

transaction transact_seq ;
mailbox #(transaction) to_driver ;

function new (mailbox #(transaction) to_driver);
    this.to_driver      = to_driver     ;
endfunction 

task run();
    transact_seq = new();
    transact_seq.rst.rand_mode(0);
    transact_seq.en.rand_mode(0);   
    transact_seq.data_in.rand_mode(0);
    transact_seq.address.rand_mode(0);
    transact_seq.rst    = 1;
    transact_seq.en     = 0;
    transact_seq.data_in= 32'h00000000;
    transact_seq.address= 0;
    to_driver.put(transact_seq);
    $display("--------------------------seq---------------------------------");
    $display("[%0t] seq: rst = %0b \nen = %0b \nData in = %0h \naddress = %0d",$time,transact_seq.rst,transact_seq.en,transact_seq.data_in,transact_seq.address);

    transact_seq = new();
    transact_seq.rst    = 0;
    transact_seq.en     = 1;
    transact_seq.data_in= 32'h00000005;
    transact_seq.address= 1;
    to_driver.put(transact_seq);
    $display("--------------------------seq---------------------------------");
    $display("[%0t] seq: rst = %0b \nen = %0b \nData in = %0h \naddress = %0d",$time,transact_seq.rst,transact_seq.en,transact_seq.data_in,transact_seq.address);

    transact_seq = new();
    transact_seq.rst    = 0;
    transact_seq.en     = 0;
    transact_seq.data_in= 32'h00000008;
    transact_seq.address= 1;
    to_driver.put(transact_seq);
    $display("--------------------------seq---------------------------------");
    $display("[%0t] seq: rst = %0b \nen = %0b \nData in = %0h \naddress = %0d",$time,transact_seq.rst,transact_seq.en,transact_seq.data_in,transact_seq.address);

    transact_seq.rst.rand_mode(1);
    transact_seq.en.rand_mode(1);   
    transact_seq.data_in.rand_mode(1);
    transact_seq.address.rand_mode(1);
    repeat (10000)
    begin
        transact_seq = new();
        assert(transact_seq.randomize());
        to_driver.put(transact_seq);
        $display("--------------------------seq---------------------------------");
        $display("[%0t] seq: rst = %0b \nen = %0b \nData in = %0h \naddress = %0d",$time,transact_seq.rst,transact_seq.en,transact_seq.data_in,transact_seq.address);
    end


endtask 

endclass:sequencer
