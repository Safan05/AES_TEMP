module SevenSegment(A,O,T,H);
input [7:0]A;

reg [3:0]o;
reg [3:0]t;
reg [3:0]h;

output [6:0]O;
output [6:0]T;
output [6:0]H;

reg [3:0]R1,R2,R3,R4,R5,R6,R7;


function [3:0]out(input [3:0]in);
begin
case(in) 
// smaller than 5 as it is
4'b0000: out=4'b0000;//0
4'b0001: out=4'b0001;//1
4'b0010: out=4'b0010;//2
4'b0011: out=4'b0011;//3
4'b0100: out=4'b0100;//4

// add 3 to greater than or equal 5
4'b0101: out=4'b1000;//5 --> 8
4'b0110: out=4'b1001;//6 --> 9
4'b0111: out=4'b1010;//7 --> 10
4'b1000: out=4'b1011;//8 --> 11
4'b1001: out=4'b1100;//9 --> 12
endcase

end
endfunction

function [6:0]Hex(input [3:0] temp);
begin
if(temp==4'b0000)
Hex=7'b1000000;
else if(temp==4'b0001)
Hex=7'b1111001;
else if(temp==4'b0010)
Hex=7'b0100100;
else if(temp==4'b0011)
Hex=7'b0110000;
else if(temp==4'b0100)
Hex=7'b0011001;
else if(temp==4'b0101)
Hex=7'b0010010;
else if(temp==4'b0110)
Hex=7'b0000010;
else if(temp==4'b0111)
Hex=7'b1111000;
else if(temp==4'b1000)
Hex=7'b0000000;
else if(temp==4'b1001)
Hex=7'b0010000;
else
Hex=7'b1111111;
end 
endfunction
// Assigning the 
assign R1=out({1'b0,A[7:5]});
assign R2=out({R1[2:0],A[4]});
assign R3=out({R2[2:0],A[3]});
assign R4=out({R3[2:0],A[2]});
assign R5=out({R4[2:0],A[1]});
assign R6=out({1'b0,R1[3],R2[3],R3[3]});
assign R7=out({R6[2:0],R4[3]});

assign o={R5[2:0],A[0]};
assign t={R7[2:0],R5[3]};
assign h={1'b0,1'b0,R6[3],R7[3]};

assign O=Hex(o);
assign T=Hex(t);
assign H=Hex(h);

endmodule