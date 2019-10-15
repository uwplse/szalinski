
lhsOrRhs=1; //Select Lhs or Rhs servo holder


$fn=50; //bigger = smoother/slower

//Parametric rc servo model
//Enetr dimensions as per jpg 
a=29.5;
b=24;
c=27;
d=13;
e=33;
f=16.5;
//g=32.3;
h=27.5;
i=20;
j=6;


mountingHoleDiameter=2;
mountingHoleDepth=19;
splineShaftDiameter=10;
splineShaftHeight=20;
cableHeight=4;
cableWidth=8;
cableLength=15;
//body
module body()
{
cube([d,b,c],center=false); 

//tabs
translate([0,-(e-b)/2,f])
{
    cube([d,e,(i-f)],center=false); 
}
//splineShaft
translate([d/2,j,c])
{
cylinder(h=splineShaftHeight,d=splineShaftDiameter,center=false);
}

//lead 
//translate([-cableWidth/2+d/2,-cableLength,0]) //centered
translate([0,-cableLength,0]) //offset
{
   cube([cableWidth,cableLength,cableHeight],center=false); 
}
}
module mountingHoles()
{
translate([d/2,-(h-b)/2,i-mountingHoleDepth])
{
    cylinder(h=mountingHoleDepth*2,d=mountingHoleDiameter,center=false);
    translate([0,h,0])
    {
      cylinder(h=mountingHoleDepth*2,d=mountingHoleDiameter,center=false); 
    }
}
}


module display()  //with holes for display only
{
    translate([-d/2,-j,0])//center model around spline shaft
    {
    difference()
    {
    body();
    mountingHoles();
    }
}
}
module RCServo() // with mounting hole geometry
{
    translate([-d/2,-j,-a])//center model around spline shaft edit
    {
    
    body();
    mountingHoles();
    
}
}







//Servo Holder made using Servo model

strength=3;
slotGap=5;
slotOffset=-1; //change to get slot in correct position
length=e+strength*2;
width=d-.1;
height=a+slotGap+strength*2;

module mount()
{
difference()
{

//mount
cube([length,width,height],center=true); 
union()
    {
//minus rcServo
translate([b/2-j,0,height/2-strength-slotGap])
rotate([0,0,90])
RCServo();

//minus slot for servo arm

//translate([0,0,height/2-slotGap-strength])
translate([0,0,a/2+slotOffset])
cube([length-strength*2,d,slotGap],center=true); 
    }
}
}

if(lhsOrRhs==0)
{
//lhs

rotate([-90,0,0])
mount();
}



if(lhsOrRhs==1)
{
//rhs

mirror([1,0,0])
rotate([-90,0,0])
mount();
}


