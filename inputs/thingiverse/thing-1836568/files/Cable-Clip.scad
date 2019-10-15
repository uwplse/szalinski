// Base diameter, default is 30
diameter = 30;
// Diameter of cable. Don't forget to change the base diameter also if needed. If larger than 20 you may whant to scale the whole thing.
diameter_cable = 10;
// e.g. 1.75, 2.85, ...
filament_width = 1.75;

// Select what to print
print = 0; // [0:Both, 1:Base, 2:Clip]

/* [Hidden] */
r = diameter/2;
r_cable = diameter_cable/2;
clip_width = 5*diameter/30;

if(print == 0 || print == 1) base();
if(print == 0 || print == 2) rotate([print==2?90:0, 0 ,0]) difference() {
    clip();
    clip_hole();
}

module base() {
    difference() {
        sphere(r=r+0.2, $fn=100);
        translate([0,0,-500-(diameter/12)]) cube([1000,1000,1000], center=true);
        translate([0,0,r-0.8*r_cable]) rotate([90,0,0]) cylinder(r=r_cable, h=100, $fn=50, center=true);
        clip(1.2);
        clip_hole();
    }
    translate([-r+4.5,0,8]) {
        translate([0,clip_width/2+0.7,0]) sphere(1, $fn=20, center=true);
        translate([0,-clip_width/2-0.7,0]) sphere(1, $fn=20, center=true);
    }
}

module clip(scale=1) {
    difference() {
        rotate([90,0,0]) cylinder(r=r*scale, h=clip_width*scale, $fn=100, center=true);
        scale([0.7,1,1]) rotate([90,0,0]) cylinder(r=r-((clip_width-2)*0.8*scale), h=50, $fn=100, center=true);
        translate([0,0,-45]) cube(100, center=true);
    }
    // rotate
    translate([r-6*0.7, 0, 5]) rotate([90,0,0]) difference() {
        cylinder(r=3.5*scale, h=clip_width*scale, center=true, $fn=30);
    }
    // handle
    translate([-r+1, 0, 5+1]) rotate([90,0,0]) {
        cylinder(r=1, h=clip_width, center=true, $fn=30);
    }
}

module clip_hole() {
    translate([r-6*0.7, 6, 5]) rotate([90,0,0]) cylinder(r=(filament_width/2 + 0.1), h=2*r, $fn=30);
    translate([r-6*0.7, 2.9, 5]) rotate([90,0,0]) cylinder(r=(filament_width/2 + 0.1)*1.2, h=2*r, $fn=30);
}