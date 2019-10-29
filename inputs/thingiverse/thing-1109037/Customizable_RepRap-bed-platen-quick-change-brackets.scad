// Copyright 2015 Arthur Davis (thingiverse.com/artdavis)
// This file is licensed under a Creative Commons Attribution 4.0
// International License.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

// Occasionally my nozzle or fan duct will crash into one of the
// binder clips securing down my platen. These customizable flush
// mount brackets hold the platen down while staying out of the
// way. Also it's much quicker installing and removing the platen
// with these brackets; two eccentric retainers just need to be
// rotated out of the way allowing the platen to easily lift out.
//
// While using the customizer, you may select each individual
// part to preview using the "Part" drop down menu which is
// available in all tabs. To have a zoomed in view of an individual
// part go to the [Build plate] tab and set the "Show Build Plate"
// dropdown to "No". You may also tweak the display of the build plate
// here in accordance with your own printer platform.
//
// Set "bed_y_mount_height" equal to the nominal center to center
// distance of the bed mounting holes in the y-axis. The default of
// 209mm works for the MK2 (http://reprap.org/wiki/PCB_Heatbed)
//
// Measure the thickness of your build platen and set "platen_thick"
// equal to this value. The default value of 2.4mm works for a 3/32"
// plate.
//
// The brackets are naturally larger than your platen so they'll
// need to be oriented diagonally when printing in order to fit.
//
// To assemble, orient the long edges of the brackets prallel to the
// Y-axis and arrange the short edges (the stops) kitty-corner each
// other. Put an eccentric retainer over each mount slot and affix to
// the bed as usual. Preferably use button cap screws to minimize
// the Z protrusion.
//
// If the plastic eccentrics stops are too flimsy to secure your platen
// you can try printing them thicker by addjusting the "eccentric_thick"
// value. Alternatively, reinforcing the eccentrics stops with fender
// washers works well. If any of the corners are still not securely held
// in place, just build up that corner of the platen with several layers
// of tape.
//
// The brackets should be snug against the platen on all four sides.
// The eccentric retainers will hold the platen down. To quickly remove
// the platen turn the front two eccentrics to release the platen then
// lift up and slide it out.

// Units are in mm

// Optimize view for Makerbot Customizer:
// preview[view:"south west", tile:"top"]

/* [Global] */
// Choose geometry to preview:
part = "All"; // [Bracket_Xslot, Bracket_Yslot, Eccentric, All]

/* [Config] */
// Bed center to center mounting hole height (in y-axis)
bed_y_mount_height = 209; // [100:420]
// Thickness of the print platen
platen_thick = 2.4; // [1:0.1:15]
// Length of the slots for bracket postion adjustment
slot_length = 6; // [3:0.5:10]
// Wall thickness between holes and edges
wall_thick = 1.5; // [1:0.5:6]
// Thru-hole diameter for screw hardware
hole_diam = 3.4; // [2:0.1:5]
// Length of the bracket stop arm
stop_length = 40; // [10:200]
// Diameter of the eccentric retainer
eccentric_diam = 18; // [10:30]
// Thickness of the eccentric retainer
eccentric_thick = 1.0; // [0.2:0.1:3.0]

/* [Build Plate] */
use <utils/build_plate.scad>;
// Show build plate?
show_build_plate = "Yes"; // [Yes, No]
// For display only, doesn't contribute to final object
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//For "Manual" option: Build plate x dimension
build_plate_manual_x = 200; //[100:400]
//For "Manual" option: Build plate y dimension
build_plate_manual_y = 200; //[100:400]
if (show_build_plate == "Yes") {
    build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y); 
}

/* [Hidden] */
// Herein variable definitons hidden from Customizer
delta = 0.01; // CSG overlap tolerance
x_width = slot_length + 2 * wall_thick;
x_height = hole_diam + 2 * wall_thick;
y_width = x_height;
y_height = x_width;
xbracket_height = bed_y_mount_height + x_height;
ybracket_height = bed_y_mount_height + y_height;

// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
module xbracket() {
    translate([0, 0, platen_thick/2]) {
    difference() {
        union() {
            cube([x_width, xbracket_height, platen_thick], center=true);
            translate([(stop_length+x_width-delta)/2,
                       (xbracket_height-x_height)/2, 0])
                cube([stop_length + delta,
                      x_height, platen_thick], center=true);
        }
        translate([0, bed_y_mount_height/2, 0])
            slot();
        translate([0, -bed_y_mount_height/2, 0])
            slot();
    }}
}

module ybracket() {
    translate([0, 0, platen_thick/2]) {
    difference() {
        union() {
            cube([y_width, ybracket_height, platen_thick], center=true);
            translate([-(stop_length+y_width-delta)/2,
                       -(ybracket_height-y_height)/2, 0])
                cube([stop_length + delta,
                      y_height, platen_thick], center=true);
        }
        translate([0, bed_y_mount_height/2, 0]) {
            rotate([0, 0, 90])
            slot();
        }
        translate([0, -bed_y_mount_height/2, 0]) {
            rotate([0, 0, 90])
            slot();
        }
    }}
}

module slot(w=slot_length, d=hole_diam, t=2*platen_thick) {
    union() {
        cube([w-d, d, t], center=true);
        translate([(w-d)/2, 0, 0])
            cylinder(h=t, d=d, center=true, $fn=50);
        translate([-(w-d)/2, 0, 0])
            cylinder(h=t, d=d, center=true, $fn=50);
    }
}

module eccentric() {
    translate([0, 0, eccentric_thick/2]) {
        difference() {
            cylinder(h=eccentric_thick, d=eccentric_diam, center=true, $fn=50);
            translate([-(eccentric_diam - hole_diam)/2 + wall_thick, 0, 0])
                cylinder(h=2*eccentric_thick, d=hole_diam, center=true, $fn=50);
        }
    }
}

// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

module all_geom() {
    rotate([0, 0, -40]) 
    {
        translate([-x_width, 0, 0])
            xbracket();
        translate([0, -y_height, 0])
            rotate([0, 0, 180])
            ybracket();
    }
    translate([3*eccentric_diam/2, 0, 0]) {
        eccentric();
        translate([3*eccentric_diam/2, 0, 0])
            eccentric();
    }
    translate([0, -3*eccentric_diam/2, 0])
        eccentric();
    translate([3*eccentric_diam/2, -3*eccentric_diam/2, 0])
        eccentric();
}

// Allow MakerBot Customizer to generate STL based on part selection
module print_part() {
    if (part == "Bracket_Xslot") {
        rotate([0, 0, -40])
            xbracket();
    } else if (part == "Bracket_Yslot") {
        rotate([0, 0, -40])
            ybracket();
    } else if (part == "Eccentric") {
        eccentric();
    } else if (part == "All") {
        all_geom();
    } else {
        all_geom();
    }
}


// For running in native OpenSCAD
//show_build_plate = "No"; // Default is Yes
//part = "Bracket_Xslot";
//part = "Bracket_Yslot";
//part = "Eccentric";
//part = "All";
print_part();
