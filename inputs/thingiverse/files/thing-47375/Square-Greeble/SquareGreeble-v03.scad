//Square Greeble
// (c) 2013 Wouter Robers


SizeX=20;
SizeY=20;
NumberOfGreeblesX=20;
NumberOfGreeblesY=20;
MinimalGreebleSize=1;
MaximumGreebleSize=3;
GreebleHeightFactor=0.5;
TwoSided="Yes"; // [Yes,No]

Random=rands(MinimalGreebleSize,MaximumGreebleSize,NumberOfGreeblesX*NumberOfGreeblesY+10);
RandomColor=rands(0,1,NumberOfGreeblesX*NumberOfGreeblesY+10);

union() {
for (i=[0:NumberOfGreeblesX-1]){
for (j=[0:NumberOfGreeblesY-1]){
color([RandomColor[i*NumberOfGreeblesY+j],RandomColor[i*NumberOfGreeblesY+j],RandomColor[i*NumberOfGreeblesY+j]]) { 
translate ([i*SizeX/NumberOfGreeblesX,j*SizeY/NumberOfGreeblesY,0])cube(
[
Random[i*NumberOfGreeblesY+j+1],
Random[i*NumberOfGreeblesY+j+2],
Random[i*NumberOfGreeblesY+j]*GreebleHeightFactor
],

center = false
);
}
}
}
}