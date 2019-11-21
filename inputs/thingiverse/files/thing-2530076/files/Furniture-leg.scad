//Very simple furniture leg... so Roomba can vacuum underneath ;)

leg_width  =  60;
leg_height = 100;

screw_hole_diameter =  2;
screw_hole_height   = 30;

translate([0, 0, leg_height/2]) {

    difference() {
        cube([leg_width, leg_width, leg_height], center=true);
    
        translate([0, 0, leg_height/2-screw_hole_height/2]) {
            cylinder(screw_hole_height, screw_hole_diameter, screw_hole_diameter, center=true);
        }
    }
}


