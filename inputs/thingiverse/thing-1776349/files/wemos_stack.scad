//
// WeMOS D1 Mini Stack Enclosure Script
//
// I wrote this script to generate a suitable 3-d printed enclosure for a WeMOS "stack" of shields.
// Since there are a variety of connectors, sizes and arrangements, I decided to let the customizer
// allow for various positionings of each shields port.
//
// To use, you will need to assemble your device and measure the total height of the case, and the
// height offsets for any shields that require an opening in the case.
//
// For instance, I have a WeMOS D1 Mini with a battery shield and then an SD Card shield on top of 
// that.  All have stackable headers, that have had their pins trimmed to make the stack as short
// as possible.  The resulting measurements of the stack yield the default values of this script.
//

/* [Height] */

// Final height of the stack walls.
height = 36.0;

/* [Shield Ports] */

// Distance from the bottom to the bottom of the usb connector opening (0.0 to omit)
usb_height = 1.0;
// Distance from the bottom to the bottom of the microsd shield opening (0.0 to omit)
microsd_height = 30;
// Distance from the bottom to the bottom of the battery shield connector opening (0.0 to omit)
battery_height = 18.0;
// Distance from the bottom to the bottom of the relay shield connector terminal opening (0.0 to omit)
relay_height = 0.0;

// ---------------------------------------------------------------------------------------------------------
// do not need to modify anything below here
// ---------------------------------------------------------------------------------------------------------
/* [Hidden] */

thickness = 2.0;
fudge = 0.1;

width = 38.5;
depth = 30.50;
 
cavity_width = width - (2 * thickness);
cavity_depth = depth - (2 * thickness);
cavity_height = height - thickness + fudge;

hole_diameter = 7.0;

slit_width = 4.0;
slit_height = 23.0;

// lid
rotate([0, 0, 180])
difference() {
    union () {
        translate([-(width / 2.0), 20, 0.0]) cube([width, depth, 2.0]);
        translate([-(cavity_width / 2.0), 22, 2.0]) cube([cavity_width, cavity_depth, 1.3]);            
    }
    translate([1, 22 + (cavity_depth / 2), 2.5]) cylinder(h = 5 + fudge, r1 = hole_diameter, r2 =hole_diameter, center = true);
    rotate([0, 0, 90]) translate([21.9, -12.5, 0]) cube([slit_width, slit_height, 10]);
    rotate([0, 0, 90]) translate([44.6, -12.5, 0]) cube([slit_width, slit_height, 10]);
}

// base
rotate([0, 0, 180])
union() {
    translate([13.5, -(cavity_depth / 2.0), 2]) cube([4.0, cavity_depth, 4.0]);
    translate([-16, -(cavity_depth / 2.0), 2]) cube([4.0, cavity_depth, 2.0]);
    difference () {
        translate([0, 0, height / 2.0]) cube([width, depth, height], center = true); 
        translate([0, 0, (cavity_height / 2.0) + thickness]) cube([cavity_width, cavity_depth, cavity_height], center = true);
        translate([1, 0, thickness / 2.0]) cylinder(h = thickness + fudge, r1 = hole_diameter, r2 = hole_diameter, center = true);
        rotate([0, 0, 90]) translate([9, -12.5, 0]) cube([slit_width, slit_height, 5]);
        rotate([0, 0, 90]) translate([-13, -12.5, 0]) cube([slit_width, slit_height, 5]);
        translate([-17.25, 13.0, 4]) cube([7, 3, 4]);        
        if (usb_height > 0.0)
        {
            translate([-20, -6, 1]) cube([3, 12, 8]);
        }
        if (microsd_height > 0.0)
        {
            translate([-20, -5, microsd_height]) cube([3, 12, 4]);
        }
        if (battery_height > 0.0)
        {
            translate([-20, -11, battery_height]) cube([3, 22, 8]);
        }
        if (relay_height > 0.0)
        {
            translate([-20, -6, relay_height]) cube([3, 15, 7]);
        }
    }
}

