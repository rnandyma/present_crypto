`include "text_register.v"
`include "key_register.v"
`include "temporary_register.v"
`include "p_layer.v"
`include "arithmetic.v"
`include "sbox_ROM.v"
`timescale 1ns/10ps
module data(txt,ky,en,readon clk,rst,ciph,upky);
input reset,en,readon;
input CLK;
input [63:0] txt;
input [63:0] ky;
output reg [63:0] ciph;
output reg [63:0] upky;
wire [2:0] keydata[79:0];
wire [63:0] mux1out,[63:0] mux2out,[63:0] mux3out,[63:0] mux4out,[63:0] mux5out, [4:0]kybits, [3:0]kyS, preS, kybitsOR,[63:0]dataout;
wire regout1,regout2, sboxresult;
	generate
		genvar count; 
		for(count = 0; count == 31; count = i+1)
		begin:datapathloop
				assign mux1out = initial1?txt:ciph;
				assign mux2out = initial2?ky:upky;
				text_register64 t1(regout1,mux1out, clk,rst,en);
				key_register80 k1(regout2,mux2out,clk,rst,en);
				regout2 <= regout2<<61;
				kybits[4:0] <= regout2[19:15];
				assign mux3out = initial3?regout1:count;
				assign mux4out = initial4?regout2:kybits;
				arithmetic_block ab1(mux3out,mux4out,aout,aop);
				temporary_register64 tr1(preS,aout,clk,rst,en);
				temporary_register64 tr2(kybitsOR,aout,clk,rst,en);
				kyS[3:0] <= regout2[79:76];
				assign mux5out = intial5?preS:kyS;
				ROM_16 rom1(mux5out[15:0],dataout[15:0],clk,readon);
				ROM_16 rom2(mux5out[31:16],dataout[31:16],clk,readon);
				ROM_16 rom3(mux5out[47:31],dataout[47:31],clk,readon);
				ROM_16 rom4(mux5out[63:47],dataout[63:47],clk,readon);
				p_layer_register64 p1(ciph,dataout,clk,rst,en);
				temporary_register64 tr3(sboxresult, dataout[15:0],clk,rst en);
				assign keydata = {sboxresult,kybitsOR,regout2};
				upky <= keydata[79:16]; 
		end
	endgenerate
endmodule
				
