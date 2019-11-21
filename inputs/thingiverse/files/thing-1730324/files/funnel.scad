LargeOpeningDiameter = 70; //[10:150]
SpoutDiameter = 20; //[5:50]
WallThickness = 2;
BevelHeight = 40; //[30:60]
SpoutHeight = 20; //[10:60]

$fa = 0.1;
// Funnel
translate([0,0,-BevelHeight/2]) 
difference(){
cylinder(h=BevelHeight, r1=LargeOpeningDiameter/2, r2=SpoutDiameter/2, center=true);
cylinder(h=BevelHeight+1, r1=LargeOpeningDiameter/2 - WallThickness, r2=SpoutDiameter/2-WallThickness, center=true);
}
// Spout
translate([0,0,SpoutHeight/2])
difference(){
cylinder(h=SpoutHeight,r=SpoutDiameter/2,center=true, $fs = 0.1);
cylinder(h=SpoutHeight+1,r=SpoutDiameter/2-WallThickness,center=true, $fs = 0.1);
}
//http://www.thingiverse.com/thing:1730324.
//I want to thank everyone on the Openscad Group that helped me with this.
