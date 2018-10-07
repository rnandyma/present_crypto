module temporary_register_4(Q,D,CLK,reset,en);
input reset,en;
input CLK;
input [3:0] D;
output [3:0] Q;
reg [3:0] Q;
always @(posedge CLK & en )
begin
if (reset)
Q <= 0;
else if(CLK==1)
Q <= D;
end
endmodule // reg64