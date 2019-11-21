// - width of cupbvoard door
Door = 250;

// - biggest dimension of print bed
Bed = 250;

// - diameter of largest polish bottle
BottleD = 30;

// - height of tallest bottle (glass portion only)
BottleZ = 66;

// - wall thickness
T = 1.6;

// - Screw thread diameter
ScrewD1 = 4.0;

// - screw head diameter
ScrewD2 = 7.5;

// - height of screw head
HeadHt  = 4;


/* [Hidden] */
X = min(Door,Bed);
Y = BottleD +2*T;
Z = BottleZ*0.7;
Front = Z*0.6;
SliceAng = atan((Z-Front)/(BottleD));
echo(SliceAng);


difference() {
    //body
    cube([X, Y, Z]);
    //cavity
    translate([T,T,T])
        cube([X-2*T, BottleD, Z]);
    //front slice
    translate([0, T, Front]) rotate([SliceAng,0])
        translate([0,-T*4])
            cube([X, Y*2, Z]);
    //screws
    translate([0.1*X, Y-T, Z*0.7]) Screw();
    translate([0.5*X, Y-T, Z*0.7]) Screw();
    translate([0.9*X, Y-T, Z*0.7]) Screw();
    //front slices
    circDiam = Front-4*T;
    start=0.05;
    end=1-start;
    steps = floor((X-2*T)/circDiam/0.75);
    for(m=[start:(end-start)/steps:end]) 
    translate([X*m, 0, circDiam/2+2*T])
    scale([0.6,1,1])
    rotate([0,90,0]) rotate([-90,0])
    cylinder(d=circDiam, Y/2, $fn=40);

}

module Screw() {
    rotate([270,0]) union() {
        cylinder(d1=ScrewD2, d2=0, HeadHt, $fn=40);
        cylinder(d=ScrewD1, T*10, $fn=40);
        rotate([180,0]) cylinder(d=ScrewD2,Y/2);
    }
}









