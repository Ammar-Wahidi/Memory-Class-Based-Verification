interface Memory_interface(clk);
input bit                       clk             ;
logic                           rst             ;
logic                           en              ;
logic [31:0]                    data_in         ;
logic [3:0]                     address         ;
logic [31:0]                    data_out        ;
logic                           valid_out       ;

// Clocking block at posedge clk
clocking cb @(posedge clk);
    default input #1 output #1;   // skew for avoiding race
    output rst, en, data_in, address;     // driven by TB
    input  data_out, valid_out;           // sampled from DUT
endclocking

endinterface