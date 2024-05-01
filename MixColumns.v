module MixColumns(input [0:127] in,output [0:127] out);

function [0:7] mul_2;
	input [0:7] x;
	begin 
	  if(x[0] == 1) mul_2 = ((x << 1) ^ 8'h1b);
	  else mul_2 = x<<1;
	end 	
endfunction

function [0:7] mul_3;
	input [0:7] x;
	begin 
	  mul_3 = mul_2(x) ^ x;
	end 
endfunction

genvar i;
generate 
for(i=0;i< 4;i=i+1) begin : m_col

   assign out[i*32:i*32+7]= mul_2(in[i*32:i*32+7]) ^ mul_3(in[i*32+8:i*32+15]) ^ in[i*32+16:i*32+23] ^ in[i*32+24:i*32+31];
   assign out[i*32+8:i*32+15]= in[i*32:i*32+7] ^ mul_2(in[i*32+8:i*32+15]) ^ mul_3(in[i*32+16:i*32+23]) ^ in[i*32+24:i*32+31];
   assign out[i*32+16:i*32+23]= in[i*32:i*32+7] ^ in[i*32+8:i*32+15] ^ mul_2(in[i*32+16:i*32+23]) ^ mul_3(in[i*32+24:i*32+31]);
   assign out[i*32+24:i*32+31]= mul_3(in[i*32:i*32+7]) ^ in[i*32+8:i*32+15] ^ in[i*32+16:i*32+23] ^ mul_2(in[i*32+24:i*32+31]);

end
endgenerate

endmodule
