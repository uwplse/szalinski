// Total Whell size (diameter)
Size = 50;
// Radius of rotated circle / Height of "Donut"
Radius = 5;
// Central Hole diameter to mount in millimeters
CenterHoleDiameter=5;
HollowCenter =  "yes"; // [yes,no]
ShowCrossSection =  "no"; // [yes,no]

/* [Hidden] */
$fn=50;
difference(){
    union(){
        difference(){union(){
                rotate_extrude(angle=360) translate([Size/2-Radius,0]) circle(r=Radius);
                cylinder(r=Size/2-Radius,h=Radius*2,center=true);
            }            
            if(HollowCenter == "yes") 
                rotate_extrude(angle=360) translate([Size/2-Radius,0]) circle(r=Radius*0.75);
        }
        cylinder(d=CenterHoleDiameter+1,h=Radius*2,center=true);
    }
    cylinder(d=CenterHoleDiameter,h=Radius*3,center=true);
    if(ShowCrossSection == "yes"){
        translate([0,0,-50]) cube([100,100,100]);
        translate([0,-50,0]) cube([100,100,100]);
    }
}