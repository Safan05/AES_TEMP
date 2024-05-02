module Round(input [127:0] state,input [127:0]temp_key,output [127:0] out);
wire [127:0] temp2;
wire [127:0] temp3;
wire [127:0] temp4;
wire [127:0] temp5;
ShiftRows_inv op3(state,temp5);
InvSubBytes op2(temp5,temp3);
AddRoundKey op1(temp3,temp_key,temp2);
InvMix op4(temp2,temp4);
assign out=temp4;
endmodule

module LastRound(input [127:0] state,input [127:0]temp_key,output [127:0] out);
wire [127:0] temp2,temp3,temp4;
ShiftRows_inv op3(state,temp4);
InvSubBytes op2(temp4,temp3);
AddRoundKey op1(temp3,temp_key,temp2);
assign out=temp2;
endmodule
