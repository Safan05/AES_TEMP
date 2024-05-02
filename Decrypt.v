module decrypt(in ,out ,key_d,switch,clk,h1,h2,h3);
  // nb*(nr+1) words where nb always = 4 and 1 word = 4 bytes = 32 bit so 32*4=128
input [127:0] in;
output [127:0] out;
input [1919:0] key_d;
input [1:0] switch;
input clk;
reg [127:0] temp_in,temp_key,temp_in_l,tempo;
wire [127:0] temp_out,temp_out_last;
reg [7:0] lastbit;
output wire [6:0]h1,h2,h3;
integer count=1;
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
if(count==nr)
begin
temp_in<=in^key_d[127:0];
temp_key<=key_d[255:128];
count=count+1;
end
else if(count>nr && count <(2*nr))
begin
temp_in<=temp_out;
temp_key<=key_d[(((count-nr+2)*128)-1)-:128];
tempo<=temp_out;
count=count+1;
end
else if(count==((2*nr)))
begin
tempo<=temp_out_last;
count=count+1;
end
else
count=count+1;
end

assign out=tempo;
Round r(temp_in,temp_key,temp_out);
LastRound rl(temp_in,temp_key,temp_out_last);
SevenSegment show(tempo[7:0],h1,h2,h3);
endmodule