module InvMix(input[0:127] in_state,output[0:127] out_state);
wire[0:7] ewire =8'h0e; 
wire[0:7] dwire =8'h0d;
wire[0:7] bwire =8'h0b;
wire[0:7] wire9 =8'h09;

function automatic [0:7] multiply_2(input[0:7] in_byte,input integer n);
integer i;  
begin 
for(i = 0;i < n; i=i+1) begin
  if(in_byte[0]) begin
      in_byte = {in_byte[1:7], 1'b0} ^ (8'h1b & {8{in_byte[0]}});
   end
else in_byte = {in_byte[1:7],in_byte[0]};
end
multiply_2 = in_byte;
end
endfunction

function[0:7] product(input[0:7] i_byte,input[0:7] element);
begin
     if(element == 8'h0e) begin
        product = multiply_2(i_byte,3) ^ multiply_2(i_byte,2) ^ multiply_2(i_byte,1);
end

else if(element == 8'h0b) begin
        product = multiply_2(i_byte,3) ^ multiply_2(i_byte,1) ^ i_byte;
end

else if(element == 8'h0d) begin
        product = multiply_2(i_byte,3) ^ multiply_2(i_byte,2) ^ i_byte;
end

else if(element == 8'h09) begin
       product = multiply_2(i_byte,3) ^ i_byte;
end
end
endfunction

genvar i;
generate
for(i=0;i<4;i=i+1) begin: multi
  assign out_state[(i*32) +:8]      = product(in_state[(i*32)+:8],ewire) ^  product(in_state[(i*32 +8)+:8],bwire) ^ product(in_state[(i*32 + 16)+:8],dwire) ^ product(in_state[(i*32 + 24)+:8],wire9);
  assign out_state[(i*32 + 8)+:8]   = product(in_state[(i*32)+:8],wire9) ^  product(in_state[(i*32 +8)+:8],ewire) ^ product(in_state[(i*32 + 16)+:8],bwire) ^ product(in_state[(i*32 + 24)+:8],dwire);
  assign out_state[(i*32 + 16)+:8]  = product(in_state[(i*32)+:8],dwire) ^  product(in_state[(i*32 +8)+:8],wire9) ^ product(in_state[(i*32 + 16)+:8],ewire) ^ product(in_state[(i*32 + 24)+:8],bwire);
  assign out_state[(i*32 + 24)+:8]  = product(in_state[(i*32)+:8],bwire) ^  product(in_state[(i*32 +8)+:8],dwire) ^ product(in_state[(i*32 + 16)+:8],wire9) ^ product(in_state[(i*32 + 24)+:8],ewire);
end
endgenerate
endmodule