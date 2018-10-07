module temporary_register(Q,D,CLK,reset,en);
input reset,en;
input CLK;
input [63:0] D;
output [63:0] Q;
reg [63:0] Q;
always @(posedge CLK & en )
begin
if (reset)
Q <= 0;
else if(CLK==1)
Q <= D;
end
endmodule // reg64