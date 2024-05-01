module decrypt(in ,out ,key_d,switch,clk,h1,h2,h3);
  // nb*(nr+1) words where nb always = 4 and 1 word = 4 bytes = 32 bit so 32*4=128
input [127:0] in;
output reg [127:0] out;
input [1919:0] key_d;
input [1:0] switch;
input clk;
reg [127:0] temp,temp_key,temp_2,temp_3,temp_4,temp_5;
reg [7:0] lastbit;
wire [127:0] temp2,temp3,temp4,temp5;
output wire [6:0]h1,h2,h3;
integer count=0;
integer nr;
always @(*) begin
    if (switch == 2'b00)
        nr = 10; //128 bit key
    else if (switch == 2'b01)
        nr = 12; //192 bit key
    else
        nr = 14; //265 bit key
end
always @(posedge clk)
begin
if(count<nr)
	begin
		temp<=in;
		temp_key<=key_d[1919-:128];
		lastbit=temp[7:0];
	end
else if(count==nr)
	begin
		temp<=temp2;
		temp_key<=key_d[1791-:128];
		lastbit=temp5[7:0];
	end
else if(count>nr && count<(2*nr)-1)
	begin
		temp<=temp5;
		temp_key<=key_d[(1919-128*(count-nr+1))-:128];
		lastbit=temp5[7:0];
	end
else if(count==2*nr-1)
	begin
	temp<=temp5;
	temp_key<=key_d[(1919-128*(count-nr+1))-:128];
	lastbit=temp4[7:0];
	end
count<=count+1;
end
always @(*)
begin
temp_2=temp2;
temp_3=temp3;
temp_4=temp4;
temp_5=temp5;
end
AddRoundKey op1(temp,temp_key,temp2);
InvSubBytes op2(temp,temp3);
ShiftRows_inv op3(tmep,temp4);
InvMix op4(temp,temp5);
SevenSegment show(temp,h1,h2,h3);
endmodule