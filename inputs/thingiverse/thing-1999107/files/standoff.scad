/* [Dimensions] */

// measured distance from the base to the bottom of the tube (mm)
height = 112; 

// width of the support at the base (mm)
width = 40;

// thickness of the support at the top where it connects to the rail (mm)
depth = 7; 

// thickness of the support at the base (mm)
baseDepth = 18; 

// diameter of the tube (mm)
diameter = 25.4; 

/* [Screws] */

// diameter of the screw hole (mm)
screwDiameter = 4; 

// diameter of the screw head (mm)
screwHeadDiameter = 8;

// offset of the screw head from the bottom (mm)
screwHeadOffset = 9; 

// number of screws
screwCount = 3; 

// angle of the screw holes (degrees)
screwAngle = 30; 

difference() {
    union() {
        translate([0,-depth/2,0]) cube([width,depth,height+diameter/2]);
        hull() { 
            translate([0,-baseDepth/2,0]) cube([width, baseDepth,0.01]);
            translate([0,-depth/2,0]) cube([width,depth,height]);
        }
    }
    translate([0,0,height+diameter/2]) rotate([0,90,0])
        cylinder(r=diameter/2, h=width, $fn=90);
    for(i=[1:screwCount])
    translate([i*width/(screwCount+1),0,0]) rotate([(i%2==0?-1:1) * screwAngle,0,0]) {
        cylinder(r=screwDiameter/2, h=height, center=true, $fn=90);
        translate([0,0,screwHeadOffset]) cylinder(r=screwHeadDiameter/2, h=height, $fn=90);
    }
}