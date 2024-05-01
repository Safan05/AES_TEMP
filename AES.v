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

module Test();
wire [6:0] j1,j2,j3;
wire c;
reg [1:0] switch;
reg clk;
reg [127:0]in=128'h8ea2b7ca516745bfeafc49904b496089;
reg [255:0]key_256=256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
wire [1919:0]expanded_key;
reg [1919:0]e_key;
KeyExpansion#(8,14) expo(key_256,expanded_key);
initial begin
clk=0;
switch=2'b10;
end
always @(*)
begin
e_key=expanded_key;
end
always #50 clk=~clk;
decrypt a(in,encrypted,e_key,switch,clk,j1,j2,j3);
endmodule