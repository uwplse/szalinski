// Small outer diameter in mm (the size of the hole it fits through)
od0 = 8;
// Big outer diameter in mm (for the teeth)
od1 = 10;
// Teeth step in mm
step = 3;
// Length of the pin. Should be a multiple of the step.
depth = 15;
// Platform width
platformWidth = 20;

// Platform thickness
platformThickness = 2.4;
// thickness of the square inner piece
innerWidth = 4;

$fn=50;

module wholePin() {
    for(z=[0:step:depth]) {
        translate([0,0,z])
        cylinder(r1=od1/2,r2=od0/2,h=step);
    }
    translate([0,0,depth+step])
    cylinder(r1=od0/2, r2=od0/3, h=1);

    translate([0,0,-platformThickness])
    cylinder(r=platformWidth/2,h=platformThickness+0.01);
}

module hole() {    
    difference() {
        translate([-25,-25,0]) cube([50,50,depth+5]);
        cylinder(r=od0/2, h=depth+6);
    }
}

module innerPart() {
    translate([-innerWidth/2, -innerWidth/2,platformThickness])
    cube([innerWidth, innerWidth, depth+3.1]);
    translate([-8, -innerWidth/2, 0])
    cube([16, innerWidth, platformThickness]);
    rotate([0,0,45]) translate([0,0,depth+platformThickness+3.1])
    cylinder(r1=innerWidth/2*sqrt(2),r2=0,h=platformThickness,$fn=4);
}

module halfPin() {
    difference() {
        translate([0,(od1-od0)/2,0]) {
            difference() {
                wholePin();
                rotate([0,0,45])
                translate([-innerWidth/2, -innerWidth/2,-platformThickness-5])
                cube([innerWidth, innerWidth, 100]);
            }
        }
        translate([-100,0,-100]) cube([200,200,200]);
        hole();
    }
}

module printLayout() {
    rotate([-90,0,0])
    halfPin();

    translate([15+platformWidth/2,depth,0]) rotate([-90,0,180])
    halfPin();

    translate([30+platformWidth,0,innerWidth/2]) rotate([-90,0,0]) innerPart();
}

module testLayout() {
    translate([0,-(od1-od0)/2,0]) halfPin();
    translate([0, (od1-od0)/2,0]) rotate([0,0,180]) halfPin();
    rotate([0,0,45]) translate([0,0,-platformThickness*2]) innerPart();
}

printLayout();
//translate([0,40,0]) testLayout();