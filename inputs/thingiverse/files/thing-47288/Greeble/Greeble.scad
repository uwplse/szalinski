SizeX=100;
SizeY=100;
SizeZ=100;
GreebleSize=50;
NumberOfGreebles=200;

Random=rands(0,1,NumberOfGreebles+10);


union() {
for (i = [0:NumberOfGreebles])
{
translate([(Random[i]-0.5)*SizeX,(Random[i+1]-0.5)*SizeY,(Random[i+3]-0.5)*SizeZ]) cube([Random[i+4]*GreebleSize,Random[i+5]*GreebleSize,Random[i+6]*GreebleSize],center = true);
}
}


