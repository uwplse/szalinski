
// Length of main shaft; notch is centered at this height.
main_length = 200;

// Diameter at the top of the main shaft
diameter_top = 3.6;

// Diameter at the bottom of the main shaft
diameter_bottom = 8;

// Length of head above the center of the notch.
head_length = 15;

// length of bottom section; 0 to disable
tail_length = 10;

// Diameter at the top of the tail
tail_diameter_top = 8;

// Diameter at the bottom of the tail; overridden to 0 if round_tail is set to true.
tail_diameter_bottom = 0;

// curved rather than conical tail section. overrides tail_diameter_bottom if true.
round_tail = true;

$fn = $preview ? 32 : 128;

translate([0,0,diameter_bottom/2]) rotate([90,0,0]) difference() {
    union() {
        cylinder(d1=diameter_bottom, d2=diameter_top, h=main_length);
        translate([0,0,main_length]) resize([diameter_top,diameter_top,head_length*2]) sphere(r=10);
        if (tail_length != 0) {
            if (round_tail) {
                    resize([tail_diameter_top,tail_diameter_top,tail_length*2]) sphere(r=1);
            } else {
                translate([0,0,-tail_length]) cylinder(d1=tail_diameter_bottom, d2=tail_diameter_top, h=tail_length);
            }
        }
    }
    translate([0,0,main_length]) rotate_extrude(angle = 360, convexity = 2) translate([diameter_top*4/3, 0, 0]) circle(r = diameter_top);
}