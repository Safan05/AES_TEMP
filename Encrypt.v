module encrypt(in ,out,key_e,switch,clk,h1,h2,h3); 
 // nb*(nr+1) words where nb always = 4 and 1 word = 4 bytes = 32 bit so 32*4=128
input [127:0] in;
output[127:0] out;
input [1919:0] key_e;
input [1:0] switch;
wire [6:0] j1,j2,j3;
output wire [6:0]h1,h2,h3;
input clk;
wire [127:0] temp,temp2;
reg [127:0]temp_,temp2_;
integer nr;
always@(*)
begin
if(switch==2'b00)
nr=10;
else if(switch==2'b01)
nr=12;
else
nr=14;
end
always@(*)
begin
temp2_=temp2;
temp_=temp;
end
endmodule
