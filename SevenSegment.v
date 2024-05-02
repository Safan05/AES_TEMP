module SevenSegment(A,O,T,H);
input [7:0]A;

reg [3:0]o;
reg [3:0]t;
reg [3:0]h;

output reg [6:0]O;
output reg [6:0]T;
output reg [6:0]H;

reg [3:0]R1,R2,R3,R4,R5,R6,R7;
always @*
begin
R1=out({1'b0,A[7:5]});
R2=out({R1[2:0],A[4]});
R3=out({R2[2:0],A[3]});
R4=out({R3[2:0],A[2]});
R5=out({R4[2:0],A[1]});
R6=out({1'b0,R1[3],R2[3],R3[3]});
R7=out({R6[2:0],R4[3]});

o={R5[2:0],A[0]};
t={R7[2:0],R5[3]};
h={1'b0,1'b0,R6[3],R7[3]};

O=Hex(o);
T=Hex(t);
H=Hex(h);
end

function [3:0]out(input [3:0]in);
begin
/*case(in) 
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
endcase*/
if(in<4'd5)
out=in;
else
out=in+3;
end
endfunction

function [6:0]Hex(input [3:0] temp);
begin
if(temp==4'b0000)
Hex=7'b1000000; //0
else if(temp==4'b0001)
Hex=7'b1111001; //1
else if(temp==4'b0010)
Hex=7'b0100100; //2
else if(temp==4'b0011)
Hex=7'b0110000; //3
else if(temp==4'b0100)
Hex=7'b0011001; //4
else if(temp==4'b0101)
Hex=7'b0010010; //5
else if(temp==4'b0110)
Hex=7'b0000010; //6
else if(temp==4'b0111)
Hex=7'b1111000; //7
else if(temp==4'b1000)
Hex=7'b0000000; //8
else if(temp==4'b1001)
Hex=7'b0010000; //9
else
Hex=7'b1111111;
end 
endfunction
// Assigning the 

endmodule