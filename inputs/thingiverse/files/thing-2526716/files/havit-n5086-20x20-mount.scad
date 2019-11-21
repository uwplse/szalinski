clearance = 0.1;

use_version = 2;

base_plate_length = 20;
base_plate_height = 3;
base_plate_corner_radius = 3;

base_plate_hole_diameter = 4.4;
base_plate_hole_offset = 3;

coupler_width = 30;
coupler_height = 10;
coupler_wall_width = 2.6;
coupler_inner_cut_width = 15.8;
coupler_screw_hole_diameter = 4.4;
coupler_screw_nut_diameter = 7;
coupler_screw_head_diameter = 5.8;
coupler_screw_head_height = 2;

base_plate_width = coupler_width + 2*base_plate_hole_diameter + 4*base_plate_hole_offset;


difference() {
    roundedRectangle(base_plate_width, base_plate_length, base_plate_height, base_plate_corner_radius);
    
    // Left screw hole
    translate([base_plate_corner_radius/2+base_plate_hole_offset,base_plate_length/2,-clearance]) {
        cylinder(d=base_plate_hole_diameter, h=base_plate_height+2*clearance, $fn=96);
    }

    // Right screw hole
    translate([base_plate_width-base_plate_corner_radius/2-base_plate_hole_offset,base_plate_length/2,-clearance]) {
        cylinder(d=base_plate_hole_diameter, h=base_plate_height+2*clearance, $fn=96);
    }
}

translate([base_plate_width/2-coupler_width/2, base_plate_length/2, base_plate_height+coupler_screw_hole_diameter/2+coupler_wall_width+coupler_height]) {
    
    if (use_version == 1)
        version1();
    else
        version2();
}

module version1 () {
    rotate(90, [0,1,0]) {
        difference() {

            width = coupler_screw_hole_diameter+2*coupler_wall_width;

            union() {
                cylinder(d=width, h=coupler_width, $fn=96);
                translate([0,-width/2,0]) {
                    cube([width/2+coupler_height, width, coupler_width]);
                }
            }

            // Screw hole
            translate([0,0,-clearance]) {
                cylinder(d=coupler_screw_hole_diameter, h=coupler_width+2*clearance, $fn=96);
            }
            
            // Screw head
            translate([0,0,coupler_width-coupler_screw_head_height]) {
                cylinder(d=coupler_screw_head_diameter, h=coupler_screw_head_height+clearance, $fn=96);
            }
            
            // Nut
            translate([0,0,-clearance]) {
                rotate(30, [0,0,1]) {
                    cylinder(d=coupler_screw_nut_diameter, h=coupler_screw_head_height+clearance, $fn=6);
                }
            }
            
            // Outer cuts
            cut_width = (coupler_width - coupler_inner_cut_width) / 2;
            translate([
                -coupler_screw_hole_diameter/2-coupler_wall_width-clearance,
                -coupler_screw_hole_diameter/2-coupler_wall_width-clearance,
                -clearance
            ]) {
                cube([1+coupler_screw_hole_diameter+2*coupler_wall_width,width+2*clearance,cut_width+2*clearance]);
            }
            translate([
                -coupler_screw_hole_diameter/2-coupler_wall_width-clearance,
                -coupler_screw_hole_diameter/2-coupler_wall_width-clearance,
                coupler_width-cut_width-clearance
            ]) {
                cube([1+coupler_screw_hole_diameter+2*coupler_wall_width, width+2*clearance,cut_width+2*clearance]);
            }
        }
    }
}

module version2 () {
    rotate(90, [0,1,0]) {
        difference() {

            width = coupler_screw_hole_diameter+2*coupler_wall_width;

            union() {
                cylinder(d=width, h=coupler_width, $fn=96);
                translate([0,-width/2,0]) {
                    cube([width/2+coupler_height, width, coupler_width]);
                }
            }

            // Screw hole
            translate([0,0,-clearance]) {
                cylinder(d=coupler_screw_hole_diameter, h=coupler_width+2*clearance, $fn=96);
            }
            
            // Screw head
            translate([0,0,coupler_width-coupler_screw_head_height]) {
                cylinder(d=coupler_screw_head_diameter, h=coupler_screw_head_height+clearance, $fn=96);
            }
            
            // Nut
            translate([0,0,-clearance]) {
                rotate(30, [0,0,1]) {
                    cylinder(d=coupler_screw_nut_diameter, h=coupler_screw_head_height+clearance, $fn=6);
                }
            }
            
            // Inner cut
            translate([
                -coupler_screw_hole_diameter/2-coupler_wall_width-clearance,
                -coupler_screw_hole_diameter/2-coupler_wall_width-clearance,
                coupler_width/2-coupler_inner_cut_width/2
            ]) {
                cube([coupler_screw_hole_diameter+2*coupler_wall_width,width+2*clearance,coupler_inner_cut_width]);
            }
        }
    }
}

module roundedRectangle(width, depth, height, radius) {
    hull () {    
        translate([radius,radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
        translate([width-radius,radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
        translate([radius,depth-radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
        translate([width-radius,depth-radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
    }
}
