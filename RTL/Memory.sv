module Memory #(parameter address_width = 4, data_with = 32) (clk,rst,en,data_in,address,data_out,valid_out);

// Synchronous Single Port RAM - en 1 --> wtite / en 0 --> read
input               	            clk         ;
input           	                rst         ;
input       	                    en          ;
input   	[data_with-1:0]         data_in     ;
input   	[address_width-1:0]     address     ;
output      [data_with-1:0]         data_out    ;
output                              valid_out   ;

reg     [data_with-1:0]         memory [0:(2**address_width)- 1]   ;

always @(posedge clk or posedge rst)
begin
        if (rst)
        begin
            memory           <= '{default:0}    ;
        end
        else if (en)
        begin
            memory[address]  <= data_in         ;       // Write 
        end
end
assign data_out = memory[address] ;
assign valid_out = (!en&&!rst) ;

/*
//////////////////////////////////////////////////////////////////////
initial 
begin
$readmemh("benchmark.mem",memory);
end
//////////////////////////////////////////////////////////////////////
*/

endmodule