module aes(output [6:0]HEX1,output [6:0]HEX2,output [6:0]HEX3,output reg check,input [1:0]switch,input clk);
reg [127:0]in=128'h3243f6a8885a308d313198a2e0370734;
reg [255:0]key_256=256'h603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4;
wire [1919:0]expanded_key;
reg [1919:0]e_key;
wire [127:0]encrypted;
reg [127:0] temp_encrypted;
wire [127:0]decrypted;
wire [6:0] j1,j2,j3;
integer count=1;
always@(posedge clk)
count=count+1;
KeyExpansion#(8,14) c(key_256,expanded_key);
decrypt a(in,encrypted,e_key,switch,clk,HEX1,HEX2,HEX3);
//decrypt b(temp_encrypted,decrypted,e_key,switch,clk);
	always@(*)
	begin
	temp_encrypted=encrypted;
	e_key=expanded_key;
			if(decrypted==in)
			check=1'b1;
		else
			check=1'b0;	
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

module Test();
wire [6:0] j1,j2,j3;
reg c;
reg [1:0] switch;
reg clk;
reg [127:0]in=128'h00112233445566778899aabbccddeeff;
reg[127:0] ch=128'h00112233445566778899aabbccddeeff;
reg [255:0]key_256=256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
wire [1919:0]expanded_key;
wire [127:0]encrypted;
wire[127:0]enc_test;
KeyExpansion#(8,14) expo(key_256,expanded_key);
initial begin
clk=0;
switch=2'b10;
end
always @(*)
begin
if(encrypted==ch)
	c=1'b1;
else
	c=1'b0;
end
always #50 clk=~clk;
Encrypt e(in,enc_test,expanded_key,switch,clk,j1,j2,j3);
decrypt a(enc_test,encrypted,expanded_key,switch,clk,j1,j2,j3);
endmodule
