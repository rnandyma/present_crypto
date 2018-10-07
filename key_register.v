module key_register80(Q,D,CLK,reset,en);
input reset,en;
input CLK;
input [79:0] D;
output [79:0] Q;
reg [79:0] Q;
always @(posedge CLK & en)
if (reset)
Q <= 0;
else if(CLK==1)
Q <= D;
endmodule // reg80
