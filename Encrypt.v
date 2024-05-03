module Encrypt(in ,out ,key_d,switch,clk,h1,h2,h3);
  // nb*(nr+1) words where nb always = 4 and 1 word = 4 bytes = 32 bit so 32*4=128
input [127:0] in;
output [127:0] out;
input [1919:0] key_d;
input [1:0] switch;
input clk;
reg [127:0] temp_in,temp_key,temp_in_l,tempo;
wire [127:0] temp_out;
output wire [6:0]h1,h2,h3;
integer count=0;
integer nr;
always @(*) begin
    if (switch == 2'b00)
        nr = 10; //128 bit key
    else if (switch == 2'b01)
        nr = 12; //192 bit key
    else
        nr = 14; //256 bit key
end
always @(posedge clk)
begin
   if(count == 0)  begin
     temp_in<=in^key_d[(((nr+1)*128)-1)-:128];
     temp_key<=key_d[(((nr-count)*128)-1)-:128];
     count=count+1;
                    end
else if(count > 0 && count < nr )  begin
       temp_in<=temp_out;
       temp_key<=key_d[(((nr-count)*128-1))-:128];
       count=count+1;
                                     end
     else
      count=count+1;
end
always @(*)
begin
if(count < nr+1)
tempo=temp_out;
else
tempo=128'h00000000000000000000000000000000;
end
assign out=tempo;
Round_Encrypt r(temp_in,temp_key,temp_out,switch,clk);
SevenSegment show(tempo[7:0],h1,h2,h3);
endmodule