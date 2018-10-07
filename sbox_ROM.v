module ROM_4 (addr, dataout, readon,clk);
input readon;
input clk;
input [3:0] addr;
output reg [3:0] dataout;
//reg [15:0] dataout;
reg [3:0] mem [0:15] ;  
        
  //assign dataout = (posedge clk && readon) ? mem[addr] : 16'dx;
  
  initial begin
    $readmemh("memory.txt", mem); // memory_list is memory file
  end
  always@(posedge clk)
	begin	
	if(!readon)
	dataout<=mem[addr];
	$display("hello");
	end
 
  endmodule
