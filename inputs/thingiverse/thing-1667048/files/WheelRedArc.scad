// Total Whell size (diameter)
Size = 50;
// Radius of rotated circle / Height of "Donut"
Width = 10;
// Central Hole diameter to mount in millimeters
CenterHoleDiameter=5;

/* [Hidden] */
$fn=50;
difference(){
    intersection(){
        scale([1,1,0.5]) sphere(d=Size,$fn=100);
        cube([Size*2,Size*2,Width],center=true);
    }
    if(CenterHoleDiameter > 0)cylinder(d=CenterHoleDiameter+0.5,h=Width*3,center=true);
}