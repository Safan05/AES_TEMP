module Round_Encrypt(input [127:0] state,input [127:0]temp_key,output reg [127:0] out,input [1:0]switch,input clk);

wire [127:0] out_mix;
wire [127:0] out_shift;
wire [127:0] out_round;
wire [127:0] out_sub;
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
SubBytes sub(state,out_sub);
ShiftRows shift(out_sub,out_shift);
MixColumns mix(out_shift,out_mix);
AddRoundKey op1(out_mix,temp_key,out_round);

always @(*)begin
if(count == nr) 
out = out_shift^temp_key; 
else
out = out_round;
end

always @(posedge clk)
count=count+1;
endmodule

