module ShiftRows(input [0:127]a,output reg[0:127]s,input clk,input [1:0] switch);
integer count=0;
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
reg [0:127]temp;
initial begin
temp=a;
end
always@(posedge clk)begin
if(count<nr)
begin
s[0:7] = {temp[0:7]};
s[32:39] = {temp[32:39]};
s[64:71] = {temp[64:71]};
s[96:103] = {temp[96:103]};
//2nd row
s[8:15] = {temp[40:47]};
s[40:47] = {temp[72:79]};
s[72:79] = {temp[104:111]};
s[104:111] = {temp[8:15]};
//3rd row
s[16:23] = {temp[80:87]};
s[48:55] = {temp[112:119]};
s[80:87] = {temp[16:23]};
s[112:119] = {temp[48:55]};
//4th row
s[24:31] = {temp[120:127]};
s[56:63] = {temp[24:31]};
s[88:95] = {temp[56:63]};
s[120:127] = {temp[88:95]};
count=count+1;
temp=s;
end
end
endmodule
