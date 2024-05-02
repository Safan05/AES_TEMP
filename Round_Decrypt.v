module Round(input [127:0] state,input [127:0]temp_key,output [127:0] out);
wire [127:0] temp2,temp3,temp4,temp5;
AddRoundKey op1(state,temp_key,temp2);
InvSubBytes op2(temp2,temp3);
ShiftRows_inv op3(tmep3,temp4);
InvMix op4(temp4,temp5);
assign out=temp5;
endmodule

module LastRound(input [127:0] state,input [127:0]temp_key,output [127:0] out);
wire [127:0] temp2,temp3,temp4;
AddRoundKey op1(state,temp_key,temp2);
InvSubBytes op2(temp2,temp3);
ShiftRows_inv op3(tmep3,temp4);
assign out=temp4;
endmodule
