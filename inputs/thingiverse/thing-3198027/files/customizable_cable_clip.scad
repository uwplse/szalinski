// Customizable cable clip
// by Frederic RIBLE F1OAT / 2018/11/05

cables_count = 3; // [1:10]

// (in mm)
cables_diameter = 8;

// (in mm)
cables_spacing = 0;

// (in mm)
thickness = 2;

// (in mm)
gap = 2;

// (in mm)
width = 10;

// (in mm)
screw_diameter = 4.5;


// Following variables are not parameters
epsilon = 0.1+0;
$fn=50+0;

outer = cables_diameter+2*thickness;

module clip() {
    difference() {
        union() {
            for (c=[0:cables_count-1]) {
                translate([0,c*(cables_diameter+cables_spacing),0]) {
                    cylinder(h=width, d=outer, center=true);
                }
            }
            translate([outer/2-thickness-gap/2, -width/2-outer/2, 0]) {
                rotate([0, 90, 0]) {
                    bracket();
                }
            }
        }
        cut = width+outer/2;
        translate([outer/2-thickness, -cut-epsilon, -width/2-epsilon]) {
            rotate([0, -90, 0]) {
                cube([width+2*epsilon, cut+2*epsilon, gap]);
            }
        }
        for (c=[0:cables_count-1]) {
            translate([0,c*(cables_diameter+cables_spacing),0]) {
                cylinder(h=width+epsilon, d=cables_diameter, center=true);
            }
        }
        ll = (cables_count-1)*(cables_diameter+cables_spacing);
        translate([0,ll/2,0]) {
            cube([cables_diameter*0.6, ll, width+2*epsilon], center=true);
        }
    }
}

module bracket() {
    difference() {
        union() {
            translate([-width/2, 0, -thickness-gap/2]) {
                cube([width, width/2+outer/2, 2*thickness+gap]);
            }
            cylinder(h=2*thickness+gap, d=width, center=true);
        }
        cylinder(h=2*thickness+gap+2*epsilon, d=screw_diameter, center=true);
    }
}

clip();