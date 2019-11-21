// Light Dimmer Switch Plate and Knob
// (c) 2013 Wouter Robers

Knob="yes";//[yes,no]
KnobDiameter=38;
KnopHoleDiameter=4;


Plate="yes";//[yes,no]
PlateSize=66;
PlateRoundEdge=4;
PlateHoleDiameter=11;
PlateThickness=8;

Rack="yes";//[yes,no]
RackSize=80;
RackRoundEdge=8;
RackThickness=PlateThickness;

Smoothness=8;// [8:Rough,30:Medium,60:Smooth]

$fa=180/Smoothness;
$fs=30/Smoothness;


if(Rack=="yes"){
translate([-RackSize,0,0])
difference(){
translate([0,0,RackThickness/2]) scale([RackRoundEdge/2,RackRoundEdge/2,1]) rcube([RackSize/(RackRoundEdge/2),RackSize/(RackRoundEdge/2),RackThickness],2);
translate([0,0,PlateThickness/2+2]) scale([PlateRoundEdge/2,PlateRoundEdge/2,1]) rcube([(PlateSize+0.3)/(PlateRoundEdge/2),(PlateSize+0.3)/(PlateRoundEdge/2),PlateThickness+2],2);
cube(PlateSize-20,center=true);
}
}


if(Plate=="yes"){
difference(){
translate([0,0,PlateThickness/2]) scale([PlateRoundEdge/2,PlateRoundEdge/2,1]) rcube([PlateSize/(PlateRoundEdge/2),PlateSize/(PlateRoundEdge/2),PlateThickness],2);
translate([0,0,2]) cylinder(r=KnobDiameter/2+1,h=PlateThickness);
translate([0,0,-2]) cylinder(r=PlateHoleDiameter/2,h=PlateThickness);
translate([9,9,-2]) cylinder(r=4,h=PlateThickness);
}
}

if(Knob=="yes"){
translate([60,0,14]) rotate([180,0,0])
difference(){
translate([0,0,7]) rcylinder(KnobDiameter/2,KnobDiameter/2,h=14);
translate([0,0,-1]) cylinder(r=KnobDiameter/2-2,h=6);
translate([0,0,4]) cylinder(r1=KnopHoleDiameter/2*1.1,r2=KnopHoleDiameter/2,h=8);
}
}


module rcube(Size=[20,20,20],b=2)
{hull(){for(x=[-(Size[0]/2-b),(Size[0]/2-b)]){for(y=[-(Size[1]/2-b),(Size[1]/2-b)]){for(z=[-(Size[2]/2-b),(Size[2]/2-b)]){ translate([x,y,z]) sphere(b);}}}}}


module rcylinder(r1=10,r2=10,h=10,b=2)
{translate([0,0,-h/2]) hull(){rotate_extrude() translate([r1-b,b,0]) circle(r = b); rotate_extrude() translate([r2-b, h-b, 0]) circle(r = b);}}