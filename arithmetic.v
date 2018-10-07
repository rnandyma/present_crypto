module arithmetic(dcipher, doperand, aout, aop);
input [1:0] aop;
input [63:0] dcipher;
input [79:0] doperand;
output [63:0] aout;
reg [63:0] aout;
always @(*)
begin
if (aop==00)
aout <= dcipher^doperand;
else if(aop==11)
aout <= dcipher^doperand;
end
endmodule