Height=8;
OuterDiameter=25;
InnerDiameter=15;
HoleDiameter=5;
BottomThickness=2;
PoleDiameter=60;
TopZOffset=5;
$fn=120;

difference(){
    cylinder(r=OuterDiameter/2,h=Height);
    translate([0,0,BottomThickness])cylinder(r=InnerDiameter/2,h=Height);
    translate([0,0,-0.01])cylinder(r=HoleDiameter/2,h=Height);
    translate([0,OuterDiameter,PoleDiameter/2+TopZOffset])rotate([90,0,0])cylinder(r=PoleDiameter/2,h=OuterDiameter*2);
}