module aes(output reg [6:0]HEX1,output reg [6:0]HEX2,output reg [6:0]HEX3,output reg check,input [1:0]switch,input clk);
wire [6:0] j1,j2,j3;
wire [6:0] h1,h2,h3;
reg [127:0]in=128'h00112233445566778899aabbccddeeff;
reg[127:0] ch=128'h00112233445566778899aabbccddeeff;
reg [255:0]key_256=256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
wire [1919:0]expanded_key;
wire [127:0]decrypted;
wire[127:0]encrypted;
integer count=0;
KeyExpansion#(8,14) expo(key_256,expanded_key);
integer nr=10;
always @(*) begin
    if (switch == 2'b00)
        nr = 10; //128 bit key
    else if (switch == 2'b01)
        nr = 12; //192 bit key
    else
        nr = 14; //265 bit key
end
always @(*)
begin
if(decrypted==ch)
	check=1'b1;
else
	check=1'b0;
end
always @(posedge clk)
count=count+1;
Encrypt e(in,encrypted,expanded_key,switch,clk,j1,j2,j3);
decrypt a(encrypted,decrypted,expanded_key,switch,clk,h1,h2,h3);
always @(*) begin
if(count<=nr)
begin
HEX1=j1;
HEX2=j2;
HEX3=j3;
end
else
begin
HEX1=h1;
HEX2=h2;
HEX3=h3;
end
end
endmodule

//module t_DUT();
//reg[127:0] in= 128'h00112233445566778899aabbccddeeff;
//wire [127:0]oute;
//wire [1919:0]expanded_key;
//reg clk;
//wire [6:0]h,j,k;
//reg [1:0] sw;
//wire [255:0] key = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
//KeyExpansion#(8,14) expo(key,expanded_key);
//initial begin
//clk=1'b0;
//sw=2'b00;
//end
//always #50 clk=~clk;
//Encrypt v(in,oute,expanded_key,sw,clk,h,j,k);
//endmodule
/*
module Test();
wire [6:0] j1,j2,j3;
wire [6:0] h1,h2,h3;
reg [6:0] he1,he2,he3;
reg c;
reg [1:0] switch;
reg clk;
reg [127:0]in=128'h00112233445566778899aabbccddeeff;
reg[127:0] ch=128'h00112233445566778899aabbccddeeff;
reg[127:0] ein=128'h8ea2b7ca516745bfeafc49904b496089;
reg [255:0]key_256=256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
wire [1919:0]expanded_key;
wire [127:0]encrypted;
wire[127:0]enc_test;
integer count=0;

KeyExpansion#(8,14) expo(key_256,expanded_key);
initial begin
clk=0;
switch=2'b01;
end
integer nr;
always @(*) begin
    if (switch == 2'b00)
        nr = 10; //128 bit key
    else if (switch == 2'b01)
        nr = 12; //192 bit key
    else
        nr = 14; //265 bit key
end
always @(*)
begin
if(encrypted==ch)
	c=1'b1;
else
	c=1'b0;
end
always @(posedge clk)
count=count+1;
always #50 clk=~clk;
Encrypt e(in,enc_test,expanded_key,switch,clk,j1,j2,j3);
decrypt a(enc_test,encrypted,expanded_key,switch,clk,h1,h2,h3);
always @(*) begin
if(count<=nr)
begin
he1=j1;
he2=j2;
he3=j3;
end
else
begin
he1=h1;
he2=h2;
he3=h3;
end
end
endmodule*/
