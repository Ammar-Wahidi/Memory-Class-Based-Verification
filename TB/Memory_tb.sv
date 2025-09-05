import Memory_package ::*;
module Memory_tb ()                     ;
bit       clk                           ;

Memory_interface intf(clk)              ;

Memory DUT (
.clk(intf.clk)                          ,
.rst(intf.rst)                          ,
.en(intf.en)                            ,
.data_in(intf.data_in)                  ,
.address(intf.address)                  ,
.data_out(intf.data_out)                ,
.valid_out(intf.valid_out)
);
virtual Memory_interface vif            ;

Memory_env      env                     ;    

initial    clk = 0                      ;
always #10 clk =~clk                    ;

initial 
begin
vif = intf                          ;
env = new(vif)                      ;
env.run();
$stop;
end

endmodule