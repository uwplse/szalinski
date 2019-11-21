// Rubbermaid Single Track Bracket Anchor

// Height of slot on largest side
slot_height = 22; // [16:32]

/* [Hidden] */
cap_height = 4;
bracket_angle = 3.3;
bracket_length = 18;
bracket_width = 8;
bracket_height = cap_height + slot_height;
base_height = 3;
base_length = bracket_length;
base_width = bracket_width + 2 *(4 + 4 + 4);

module fillet(r, h) {
    translate([r / 2, r / 2, 0])

        difference() {
            cube([r + 0.01, r + 0.01, h], center = true);

            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true);

        }
}

difference()
{
union(){
difference(){
color("red")
    translate([0,bracket_width/-2,0])
    cube([bracket_length,bracket_width,bracket_height]);

color("red")
    translate([base_length/2 - 0.5, bracket_width/-2, bracket_height])
    rotate([0,90,0])
    fillet(4,bracket_length + 2);
    
color("red")
    translate([base_length/2 - 0.5, bracket_width/2, bracket_height])
    rotate([0,90,180])
    fillet(4,bracket_length + 2);
}

difference(){
color("red")
    translate([0,base_width/-2,0])
    cube([base_length,base_width,base_height]);

color("red")
    translate([base_length/2 - 0.5, base_width/-2, base_height])
    rotate([0,90,0])
    fillet(2,bracket_length + 2);
    
color("red")
    translate([base_length/2 - 0.5, base_width/2, base_height])
    rotate([0,90,180])
    fillet(2,bracket_length + 2);
}

color("red")
    translate([base_length/2, bracket_width/2, base_height])
    rotate([0,-90,0])
    fillet(6,bracket_length);

color("red")
    translate([base_length/2, bracket_width/-2, base_height])
    rotate([0,-90,180])
    fillet(6,bracket_length);
}

color("blue")
    translate([-1.5,2.5/-2,0])
    rotate([0,bracket_angle,0])
    cube([bracket_length + 6,2.5,slot_height]);

color("green")
    translate([base_length / 2, base_width/3,-1])
    cylinder(r = 2, h = 5);

color("green")
    translate([base_length / 2, base_width/-3,-1])
    cylinder(r = 2, h = 5);
}

    
/*
// Use this to measure since ruler isn't available
color("orange")
    translate([bracket_length,0,0])
    cube([18,18,23]);
*/