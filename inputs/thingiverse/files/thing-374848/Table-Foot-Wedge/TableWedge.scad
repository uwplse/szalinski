NumberofSteps = 5;
WidthofStep = 12;
DepthofStep = 19;
HeightofStep =3;

for(Step = [1:NumberofSteps])
{
translate([0,DepthofStep*(Step-1),0])
cube([WidthofStep,DepthofStep,HeightofStep*Step]);
} 