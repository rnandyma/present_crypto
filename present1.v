`include "arithmetic.v"
`include "temporary_register.v"
`include "sbox_ROM.v"
`include "temporary_register_4.v"
`include "key_register.v"
//`include "counter.v"
//`include "controller_FSM.v"
module present(initial_key, plain_text, cipher_text, clk,rst,en,E,D,readon,init,op);
input [63:0] plain_text;
input [79:0] initial_key;
input clk,rst,en,E,D,readon;
wire [1:0]aop;
output [63:0] cipher_text;
wire [63:0] update_text,muxtext,muxcounter,truncatedbits,aout,dataout,sboxentry,regwire;
wire [79:0] update_key,muxkey,muxaugend,muxkeyrotated,muxrotateout,regout1;
wire [4:0] rotatedkeybits;
wire [3:0] regout2;
reg [63:0]regout;
//wire[7:0]count;
//wire up_down;
//assign up_down = 1;
reg c = 1;
output init;
reg init,p,nr,kc,ks;
//reg init1,p1,nr1,kc1,ks1;
 output reg[1:0]op;
//reg [1:0]op;
parameter idle =2'b00 , gotE = 2'b01, gotNE = 2'b11, gotFIN = 2'b10 ;
reg [1:0] NextState, CurrentState ;
always@(posedge clk)
	begin
	if(rst) 
	begin 
	init <= 1'b0 ; 
		p<=1'b0;
		nr<=1'b0;
		op<= 2'b11;
		kc<=0;
		ks<=0;
		end
	else begin 
	//CurrentState <= NextState ;
	case(CurrentState)
	idle: begin
		init <= 1'b0 ; 
		p<=1'b0;
		nr<=1'b0;
		op<= 2'b11;
		kc<=0;
		ks<=0;
	if(E|!D) NextState <= gotE ;
	else if(!E|D)NextState <= gotNE ;
	else NextState <= idle ;
		end
	gotE:	begin
		kc <= 1'b0 ;
		nr<=1'b0;
		p<=1'b1; 
		ks<= 1'b0;
		op<=2'b00;
		$display("Hello there2!");
		if(1) NextState <= gotFIN ;
		//else if(!E|D)NextState <= gotNE ;
		else NextState <= idle ;
			end  
	gotFIN:begin
		kc<= 1'b1 ;
		nr<=1'b1;
		init<=1'b1; 
		ks<= 1'b1;
		$display("Hello there3!");
		if(c==31) NextState <= idle ;
		else  begin 
		NextState <= gotE ;
		c <= c+1;
		end
		end
	gotNE:begin
		kc<= 1'b1 ;
		nr<=1'b1;
		init<=1'b1; 
		ks<= 1'b0;
		op<=2'b11;
		$display("Hello there4!");
		if(c==31) NextState <= gotE ;
		else begin 
		NextState <= gotNE ;
		c<=c+1;
		end
		end
	default: begin 
		kc<= 1'bz ;
		  nr<=1'bz;
		  init<=1'bz; 
		  ks<= 1'bz;
		  op<=2'bzz;
		  $display("Hello there5!");
		NextState <= idle ;
			end
			endcase
	end
	end
/*always @(posedge clk)
begin
case(CurrentState)
2'b00 :begin
		init <= 1'b0 ; 
		p<=1'b0;
		nr<=1'b0;
		op<= 2'b11;
		kc<=0;
		ks<=0;
if(E|!D) NextState <= gotE ;
else if(!E|D)NextState <= gotNE ;
else NextState <= idle ;
end
2'b01 :begin
		kc <= 1'b0 ;
		nr<=1'b0;
		p<=1'b1; 
		ks<= 1'b0;
		op<=2'b00;
		$display("Hello there2!");
if(1) NextState <= gotFIN ;
//else if(!E|D)NextState <= gotNE ;
else NextState <= idle ;
end
2'b10 :begin
		kc<= 1'b1 ;
		nr<=1'b1;
		init<=1'b1; 
		ks<= 1'b1;
		$display("Hello there3!");
if(c==31) NextState <= idle ;
else  begin 
NextState <= gotE ;
c <= c+1;
end
end
2'b11 :begin
		kc<= 1'b1 ;
		nr<=1'b1;
		init<=1'b1; 
		ks<= 1'b0;
		op<=2'b11;
		$display("Hello there4!");
if(c==31) NextState <= gotE ;
else begin 
NextState <= gotNE ;
c<=c+1;
end
end
default : begin 
		kc<= 1'bz ;
		  nr<=1'bz;
		  init<=1'bz; 
		  ks<= 1'bz;
		  op<=2'bzz;
		  $display("Hello there5!");
NextState <= idle ;
end
endcase
end*/
/*always@(posedge clk)
begin
case(CurrentState)
2'b00 : begin 
		init <= 1'b0 ; 
		p<=1'b0;
		nr<=1'b0;
		op<= 2'b11;
		kc<=0;
		ks<=0;
		//$display("op=%2b",op);		
		end
2'b01 : begin 
		kc <= 1'b0 ;
		nr<=1'b0;
		p<=1'b1; 
		ks<= 1'b0;
		op<=2'b00;
		$display("Hello there2!");
		end
2'b11 : begin 
		kc<= 1'b1 ;
		nr<=1'b1;
		init<=1'b1; 
		ks<= 1'b1;
		$display("Hello there3!");
		end
2'b10 :begin 
		kc<= 1'b1 ;
		nr<=1'b1;
		init<=1'b1; 
		ks<= 1'b0;
		op<=2'b11;
		$display("Hello there4!");
		end
default : begin 
		  kc<= 1'bz ;
		  nr<=1'bz;
		  init<=1'bz; 
		  ks<= 1'bz;
		  op<=2'bzz;
		  $display("Hello there5!");
		  end
endcase
end*/
/*initial
begin
$display("op=%b",op);
end*/
//up_down_counter ud1 (count, up_down, clk , rst);
 //controller_FSM cont1(init,p,nr,kc,aop,ks,E,D,clk,rst);
 arithmetic ar(muxcounter,muxaugend,aout,aop);
/*wire muxkeyinit,muxtextinit,muxcounterinit,muxaugendinit,muxrotateinit;
assign muxkeyinit=init;
initial 
begin
$display("muxkeyinit=%8b",muxkeyinit);
end
/*assign muxtextinit=init;
assign muxcounterinit=kc;
assign muxaugendinit=kc;
assign muxrotateinit=~(p&E);*/
/*initial
begin
$display("init=%b",init);
end*/
assign muxkey = init?update_key:initial_key;
assign muxtext =init?update_text:plain_text;
assign muxcounter =kc?muxtext:c;
assign muxaugend = kc?muxkey:rotatedkeybits;
 assign muxkeyrotated = muxkey<<61;
 assign muxrotateout=(~(p&E))?muxkeyrotated:muxkey;
 assign rotatedkeybits = muxkeyrotated[19:15];
 assign truncatedbits = muxrotateout[79:76];
 assign sboxentry=ks?truncatedbits:regout;
  
 temporary_register tr1(regwire,aout,clk,rst,en);
 always@(*)
 begin
 regout<=regwire;
 end
 generate
	genvar i;
	for (i=0;i==15;i=i+1)
	begin: sboxgenerate
	ROM_4 r1(sboxentry[4*i+3:i], dataout[4*i+3:i], readon, clk);
	end
endgenerate
	temporary_register tr2(update_text,dataout,clk,rst,nr);
	temporary_register_4 tr41(regout2,dataout[3:0],clk,rst,ks);
	assign regout1={muxrotateout,aout,regout2};
	key_register80 kr1(update_key,regout1,clk,rst,nr);
	assign cipher_text = update_text;
	endmodule
	
 
 

module tb_present();
reg [63:0] plain_text;
reg [79:0] initial_key;
reg clk,rst,en,E,D,readon;
wire [63:0] cipher_text;
wire [1:0] op;
wire init;
present uut(initial_key, plain_text, cipher_text, clk,rst,en,E,D,readon,init,op);
// 100ns clock generator
initial $monitor("t=%3d, plain_text=%h, cipher_text=%h, initial_key=%h,init=%b,op=%b",$time,plain_text,cipher_text,initial_key,init,op);
initial
begin
#000 clk = 1'b0 ;
forever #050 clk = ~clk ;
#000 rst=1'b1; //#100 rst=1'b0;
forever en=1'b1;
forever E=1'b1;
forever D=1'b0;
forever readon=1'b0;
end

initial
begin
#000 plain_text = 64'h0000000000000000;
#000 initial_key =80'h00000000000000000000;
end
endmodule
