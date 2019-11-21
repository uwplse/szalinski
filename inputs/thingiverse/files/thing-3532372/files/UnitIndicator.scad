
// Insert a bit of extra space to get a better fit. May vary based on printer.
extra_spacing = 1.5;

// The diameter of the base at the bottom
base_diameter_lower = 32;

// The diameter of the base at the top
base_diameter_upper = 28;

// The height of the base
base_diameter_height = 4;

// The width of the slot, this allows the marker to flex a bit making it easier to put on. (Set to 0 for no slot)
slot_width = 3.2;

/* [Hidden] */
$fn = 100;

difference() {
    
    cylinder(d=base_diameter_lower+extra_spacing,h=base_diameter_height);
    translate([0,0,-0.1])
        cylinder(d2=base_diameter_lower+extra_spacing,d1=base_diameter_upper+extra_spacing,h=base_diameter_height);
    
    translate([0,0,base_diameter_height*3/4]) {
        cylinder(d=base_diameter_lower+extra_spacing+1,h=base_diameter_height);
    }
    
    if (slot_width > 0) {
        translate([0,-slot_width/2,-0.1]) {
            cube([base_diameter_lower,slot_width,base_diameter_height*2]);
        }
    }
    
    
}