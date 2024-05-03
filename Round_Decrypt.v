module Round(input [127:0] state,input [127:0]temp_key,output reg [127:0] out,input [1:0]switch,input clk);
wire [127:0] temp2;
wire [127:0] temp3;
wire [127:0] temp4;
wire [127:0] temp5;
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
ShiftRows_inv op3(state,temp5);
InvSubBytes op2(temp5,temp3);
AddRoundKey op1(temp3,temp_key,temp2);
InvMix op4(temp2,temp4);
always @(*)begin
if(count==2*nr)
out=temp2;
else
out=temp4;
end
always @(posedge clk)
count=count+1;
endmodule