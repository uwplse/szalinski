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

// Customizable adjustable fan holder for the MK8 extruder. Fan holders for
// any custom size fan can be made and then attached on the left and/or
// right side of the extruder then adjusted for height and tilt.

// While using the customizer, you may select each individual
// part to preview using the "Part" drop down menu which is
// available in all tabs. To have a zoomed in view of an individual
// part go to the [Build plate] tab and set the "Show Build Plate"
// dropdown to "No". You may also tweak the display of the build plate
// here in accordance with your own printer platform.

// Get a good measurement for the distance (in the Y-axis)
// from the center of your extruder nozzle to the front plate
// mounting surface of your MK8 and set this value for
// noz_yoffset in the [Fan/duct] tab. It was 8mm for my MK8
// but I've seen variation on this between different extruders.
// This measurement is used to make sure the output of the
// duct vent is aimed directly at the tip of the nozzle.

// Depending on where the wires route on your extruder, you
// may want to add some rotation to the rail slides so the fan
// plate does not interfere with the wires. Adjust rail_polar_1
// for the left side and rail_polar_2 for the right side under
// the [Face Plate] tab as necessary.

// If you do add any rail_polar rotation consider setting
// duct_mount="Slot" (vs. the default of "Hole"). This way
// when mounting the duct you can compensate for the rotation
// of the rail by rotating the duct so the duct output is
// optimally aimed at the tip of the nozzle.
// You may also adjust hinge_yoff to manually recenter the fan
// plate on the extruder nozzle but then you'll need to download
// the OpenSCAD source and do it manually (this won't work in
// the Customizer).

// Measure the width and hole spacing of your fan and set
// the fan_width and fan_holedist settings in the [Fan/Duct] tab.
// Typically for a 60mm fan: fan_width=60; fan_holedist=50;
// Typically for a 40mm fan: fan_width=40; fan_holedist=32;

// Use a thread forming screw to jam the hinge slide in place
// on the dovetail. If you're using a non-low profile fan it may
// be difficult to get a driver in to tighten the screw. You
// can increase the hingeslide_dovelength variable to make a taller
// rail slide for easier access.

// The default settings are optimized for assembling with a 60mm
// fan and M3 nut/bolt hardware; printed with 0.4mm nozzle at
// 0.2mm layer thickness.

// Units are in mm

// Optimize view for Makerbot Customizer:
// preview[view:"south west", tile:"top"]

/* [Global] */
// Choose geometry to preview:
part = "All"; // [Face_Plate, Hinge_Slide, Fan_Plate_1, Fan_Plate_2, Directional_Duct, All]

/* [Face Plate] */
// Left side rail polar angle for blower clearance
rail_polar_1 = 0; // [0:5:45]
// Right side rail polar angle for blower clearance
rail_polar_2 = 20; // [0:5:45]
// Width of the MK8 extruder boss
faceplate_base_width = 42;
// Height of base
faceplate_base_height = 10;
// Depth of the base
faceplate_base_depth = 6;
// Diameter of thru-holes
faceplate_hole_diam = 4.0;
// Distance between thru-holes
faceplate_hole_dist = 31;
// Narrowest width of the rail slide
rail_width0 = 6;
// Depth of the rail slide
rail_depth = 2;
// Height of the rail slide
rail_length = 50;
// Flat bar offset of the rail
rail_offset = 2;
// Clearance between rail and coupling
rail_clear = 0.4;

/* [Hinge Slide] */
// Inscribed diameter of the hinge
hinge_diam = 8.0;
// Hinge hole diameter
hinge_holediam = 4.0;
// Clearance between couplings in axial direction
hinge_clear_axial = 0.2;
// Minor hex width of hexagonal nut pocket
hinge_nutwidth = 5.6;
// Depth of the hexnut pocket
hinge_nutdepth = 2.0;
// Hole diameter for screw stop in rail block
hingeslide_block_holediam = 2.0;
// Extra length to add to dovetail mating feature
hingeslide_dovelength = 10;
//hingeslide_dovelength = 16; // For 60mm box type fan
//hingeslide_dovelength = 6; // For 40mm low profile fan

/* [Fan/Duct] */
// Distance from nozzle to frontplate mounting face in Y-axis
noz_yoffset = 8.0;
// Slot or hole mounting feature for the duct?
duct_mount = "Hole"; // [Hole, Slot]
// Width (and height) of the square fan
fan_width = 60; // For 60mm fan
//fan_width = 40; // For 40mm fan
// Distance between the mounting holes
fan_holedist = 50; // For 60mm fan
//fan_holedist = 32; // For 40mm fan
// Diameter of the holes to make in the mount plate
fan_holediam = 4.0;
// Clearance between the fan exterior and the plate walls interior
fan_clear = 0.2;
// Output diameter for the fan duct
duct_output_diam = 4;
// Height of the duct output for the directional duct
duct_output_height = 6.0;
// Length of the fan duct
duct_length = 38; // For 60mm fan
//duct_length = 40; // For 40mm fan
// How much to tilt the duct direction
duct_angle = 45; 
// Whether hinge should be flush with frame edge
push_hinge_to_edge = "No"; // [Yes, No]

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
// For a 45deg rail slope, the max width is simple:
rail_width1 = rail_width0 + 2*rail_depth;
// Width of the block that mates with the dovetail
hingeslide_block_width = rail_depth + 2;
// Depth of the block that mates with the dovetail
hingeslide_block_depth = rail_width1 + hingeslide_dovelength;
//hingeslide_block_depth = rail_width1 + 16;
// Height of the block that mates with the dovetail
hingeslide_block_height = 16;
// Length of the hinge
hinge_length = hingeslide_block_height;
// Transverse clearance between the hinge couplings
hinge_clear_transverse = 1.2;
// Width of the hinge coupling on the fan holder
fan_hingewidth = 9;
// Width of the walls of the fanplate
fan_wallthick = 2.0;
// Outside width of the U-coupling
uwidth = hinge_length + 2*fan_hingewidth;
// Fan carriage outer wall width
owd = fan_width + 2 * (fan_clear + fan_wallthick);
// Fan carriage inner wall width
iwd = owd - 2 * fan_wallthick;
// Chamfer offset
chamoffset = hinge_diam / 4;
// Set boolean based on Yes/No input in faceplate_rail_bracer
// This doesn't work in Customizer
//faceplate_top_brace = (faceplate_rail_bracer == "Yes") ? true : false;    
// Calculate the cone angle for the base duct
cone_angle = atan((iwd - duct_output_diam) / (2 * duct_length));
// Reinforce the top of the rails with brace?
// This doesn't work in Customizer
//faceplate_rail_bracer = "Yes"; // ["Yes", "No"]
// How far to offset the hinge from center to center fan on nozzle
hinge_yoff = (push_hinge_to_edge == "Yes") ? 0 :
    (owd/2 - uwidth/2) - (noz_yoffset + faceplate_base_depth/2);
// Set hinge_yoff manually here as necessary:
// hinge_yoff = <manual_value>;
// hinge_yoff=10.4; // For 40mm fan right side with 20deg polar rotation
// Cap vent feature for directing air flow?
//duct_capvent = "Yes"; // [Yes, No]

// Compute the hexagonal major diameter from the supplied minor width
function hexmajor(minor) = 2 * minor / sqrt(3);

// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

module rail(w0, d, l, o) {
    // w0: Short face width of the rail
    // d:  Depth of the rail
    // l:  Length of the rail
    // o:  Offset protrusion distance
    // For a 45deg rail slope, the max width is simple:
    w1 = w0 + 2*d;
    translate([-o, 0, 0])
    union() {
        translate([o/2, 0, l/2]) {
            // Flat bar
            cube([o*1.01, w0, l], center=true);
            // Round post in case rail is rotated
            translate([o/2,0,0])
            cylinder(d=w0, h=l, $fn=100, center=true);
        }
        // Dovetail bar
        difference() {
            translate([-d/2, 0, l/2])
            cube([d, w1, l], center=true);
        // Dovetail trimming blocks
            // Side 1
            translate([0, -w1/2, l/2])
            rotate(45)
            cube([2*d/sqrt(2), 2*d/sqrt(2), 1.1*l], center=true);
            // Side 2
            translate([0, w1/2, l/2])
            rotate(45)
            cube([2*d/sqrt(2), 2*d/sqrt(2), 1.1*l], center=true);
        }
     }
}

//module faceplate(topbrace=true) {
    // Parameter: topbrace (default: true) for including the
    // the brace at the top for extra rigidity. It may be
    // a challenging bridge to print so optionally omit
    // if topbrace parameter is false
    // Doesn't work in Customizer. Just always have it.
module faceplate() {
    union() {
    rotate([90, 0, 0]) translate([0, faceplate_base_height/2, 0])
    union() {
    //translate([0, faceplate_base_height/2, faceplate_base_depth/2]) {
    difference() {
    // Base block
    cube([faceplate_base_width, faceplate_base_height,
          faceplate_base_depth], center=true);
    // Thru holes
    translate([faceplate_hole_dist/2, 0, 0])
    cylinder(h=1.1*faceplate_base_depth, d=faceplate_hole_diam,
        $fn=100, center=true);
    translate([-faceplate_hole_dist/2, 0, 0])
    cylinder(h=1.1*faceplate_base_depth, d=faceplate_hole_diam,
        $fn=100, center=true);
    }
    }
    // Left Side rail
    translate([-faceplate_base_width/2, 0, 0])
    rotate([0,0,rail_polar_1])
    rail(rail_width0, rail_depth, rail_length, rail_offset);
    // Right Side rail
    translate([faceplate_base_width/2, 0, 0])
    rotate([0, 0, 180-rail_polar_2])
    rail(rail_width0, rail_depth, rail_length, rail_offset);
    // Top side cross brace
    //if (topbrace) { // Doesn't work in Customizer
        brace_height = faceplate_base_height / 2;
        translate([0, 0, rail_length-brace_height/2])
        cube([faceplate_base_width, rail_width0,
        brace_height], center=true);
    //    }
    }
}

module hingeslide() {
    // Slide coupling
    translate([hingeslide_block_width + rail_offset, 0, 0])
    difference() {
        // Base
        translate([-(hingeslide_block_width + rail_offset),
                     -hingeslide_block_height/2, 0])
        cube([hingeslide_block_width, hingeslide_block_height,
              hingeslide_block_depth]);
        // Rail cutout
        translate([0, 0, -0.1])
        rail(rail_width0 + 2*rail_clear, rail_depth + rail_clear,
              rail_length, rail_offset);
        // Arrestor hole cutout
        translate([-rail_offset, 0,
                   hingeslide_block_depth - 3*hingeslide_block_holediam/2])
        rotate([0,-90,0])
        cylinder(h=hingeslide_block_width*1.1,
                 d=hingeslide_block_holediam, $fn=100);
    }
    // Hinge
    difference() {
        difference() {
        union() {
            difference() {
                translate([-hinge_diam, -hinge_length/2, 0])
                cube([hinge_diam, hinge_length, hinge_diam]);
                // Cutout for top-round
                translate([-hinge_diam, 0, hinge_diam])
                cube([hinge_diam, 1.1*hinge_length, hinge_diam], center=true);
                }
                translate([-hinge_diam/2, -hinge_length/2, hinge_diam/2])
                rotate([-90,0,0])
                cylinder(d=hinge_diam, h=hinge_length, $fn=100);
            }
                // Cutout for bottom chamfer
                translate([-(hinge_diam + chamoffset), 0, 0])
                rotate([0, 45, 0])
                cube([hinge_diam/sqrt(2), 1.1*hinge_length,
                       hinge_diam/sqrt(2)], center=true);
    }
        translate([-hinge_diam/2, 0, hinge_diam/2])
        rotate([-90,0,0])
        cylinder(d=hinge_holediam, h=1.1*hinge_length, $fn=100, center=true);
    }
}

module holepunch() {
    // Punch the mounting holes for the fan
    // in the fan plate.
    x1 = -(fan_width + 2 * (fan_clear + fan_wallthick) - fan_holedist)/2;
    x2 = x1 - fan_holedist;
    y1 = -x1;
    y2 = y1 + fan_holedist;
    translate([x1, y1, 0])
    cylinder(d=fan_holediam, h=4*fan_wallthick, center=true, $fn=100);
    translate([x2, y1, 0])
    cylinder(d=fan_holediam, h=4*fan_wallthick, center=true, $fn=100);
    translate([x1, y2, 0])
    cylinder(d=fan_holediam, h=4*fan_wallthick, center=true, $fn=100);
    translate([x2, y2, 0])
    cylinder(d=fan_holediam, h=4*fan_wallthick, center=true, $fn=100);   
}

module fancarriage(height=hinge_diam){
    // Parameters
    // height: how tall the carriage will be. Default is the hinge_diam
    //         set it to fan_wallthick for a flat plate
    difference() {
        // Outer wall
        translate([-owd, 0, 0])
        cube([owd, owd, height]);
        // Only need to cut out inner wall if there is enough height
        // for a pocket
        if (height > fan_wallthick) {
            // Inner wall
            translate([-(iwd + fan_wallthick), fan_wallthick, fan_wallthick])
            cube([iwd, iwd, height]);
        }
        // Blow hole
        translate([-owd/2, owd/2, 0])
        cylinder(d=iwd - 2*fan_wallthick,
                 h=4*fan_wallthick, center=true, $fn=100);
        holepunch();
    }
}

module ductplate(){
    d0 = fan_holedist*sqrt(2);
    d1 = d0 - fan_holediam;
    d2 = d0 + fan_holediam;
    d3 = d2 + 2*fan_holediam;
    intersection() {
        union() {
            difference() {
                // Outer wall
                translate([-owd, 0, 0])
                cube([owd, owd, fan_wallthick]);
                // Blow hole
                translate([-owd/2, owd/2, 0])
                cylinder(d=iwd - 2*fan_wallthick,
                         h=4*fan_wallthick, center=true, $fn=100);
                //holepunch();
                translate([-owd/2, owd/2, 0])
                difference() {
                    cylinder(d=d2, h=2.1*fan_wallthick,
                             $fn=100, center=true);
                    cylinder(d=d1, h=2.2*fan_wallthick,
                             $fn=100, center=true);
                }
            }
                difference()
                {
                    translate([-owd, 0, 0])
                    cube([owd, owd, fan_wallthick]);
                    translate([-owd/2, owd/2, 0])
                    cube([iwd, iwd, 2.1*fan_wallthick], center=true);
                }
            }
        translate([-owd/2, owd/2, 0])
        cylinder(d=d3, h=2.1*fan_wallthick, $fn=100, center=true);   
        }
}

module fanplate() {
    // U-coupling
    union() {
    translate([hinge_diam, hinge_yoff, 0])
    difference() {
        // Exterior U-coupling base
        difference() {
        union() {
            difference() {
                translate([-hinge_diam, 0, 0])
                cube([2*hinge_diam, uwidth, hinge_diam]);
                // Cutout for the top round
                translate([hinge_diam/2, -0.1, hinge_diam/2])
                cube([hinge_diam, 1.1*uwidth, hinge_diam]);
            }
            // Top round
            translate([hinge_diam/2, 0, hinge_diam/2])
            rotate([-90, 0, 0])
            cylinder(d=hinge_diam, h=uwidth, $fn=100);
        }
        // Bottom chamfer
        translate([hinge_diam/2 + chamoffset, -0.1, 0])
        rotate([0, 45, 0])
        cube([hinge_diam/sqrt(2), 1.1*uwidth, hinge_diam/sqrt(2)]);
        }
        // Interior cut for the hinge mate
        translate([-hinge_clear_transverse,
                   fan_hingewidth - hinge_clear_axial, -0.1])
        cube([hinge_diam*1.1 + hinge_clear_transverse,
              hinge_length + 2*hinge_clear_axial, hinge_diam*1.1]);
        // Thru hole for the hinge pin
        translate([hinge_diam/2,-0.1,hinge_diam/2])
        rotate([-90,0,0])
        cylinder(d=hinge_holediam, h=1.1*uwidth, $fn=100);
        // Hex nut pocket
        translate([hinge_diam/2, uwidth - hinge_nutdepth, hinge_diam/2])
        rotate([-90,0,0])
        cylinder(h=4, d=hexmajor(hinge_nutwidth), $fn=6);
    }
    // Carriage for holding the fan
        fancarriage();
    }

}

module simpleduct() {
    // Simple conical duct for directing air from the fan
    translate([owd/2, -owd/2, 0])
    fancarriage(height=fan_wallthick);
    difference() {
        translate([0, 0, fan_wallthick - 0.01])
        cylinder(h=duct_length, d1=owd,
                 d2=duct_output_diam + 2*fan_wallthick, $fn=100);
        translate([0, 0, fan_wallthick - 0.05])
        cylinder(h=duct_length*1.01, d1=iwd,
                 d2=duct_output_diam, $fn=100);
    }
}


module directduct(duct_mount=duct_mount) {
    // More complex directional duct
    M = [ [1, 0, 0, 0],
          [0, 1, tan(duct_angle), 0],
          [0, 0, 1, 0],
          [0, 0, 0, 1] ];
    translate([0, 0, fan_wallthick])
    union() {
        translate([owd/2, -owd/2, -fan_wallthick])
        if (duct_mount == "Hole")
            fancarriage(height=fan_wallthick);
        else if (duct_mount == "Slot")
            ductplate(); 
        difference() {
            union() {
            // Skewed duct
            multmatrix(M)
            difference() {
                // Duct cone outer shell
                cylinder(h=duct_length, d1=iwd,
                         d2=duct_output_diam + 2*fan_wallthick, $fn=100);
                // Duct cone inner shell
                // (2 small offsets to remove CSG critical overlap)
                translate([0, 0, -0.05])
                cylinder(h=duct_length, d1=iwd - 2*fan_wallthick,
                         d2=duct_output_diam, $fn=100);
                translate([0, 0, 0.05])
                cylinder(h=duct_length, d1=iwd - 2*fan_wallthick,
                         d2=duct_output_diam, $fn=100);
            }
            //if (duct_capvent == "Yes")
            //    // Cap for the top
            //    translate([0, duct_length * tan(duct_angle),
            //               duct_length - fan_wallthick])
            //    cylinder(h=fan_wallthick, d=duct_output_diam + 2*fan_wallthick);
            }
            //if (duct_capvent == "Yes")
            //    // Output nozzle cutter
            //    translate([0,
            //               duct_length * tan(duct_angle) + duct_output_diam*.8,
            //               duct_length-duct_output_height/2+0.1])
            //    cube([duct_output_diam+2*fan_wallthick,
            //          duct_output_diam+2*fan_wallthick,
            //          duct_output_height], center=true);
            // Cut the top perpendicular to the tilt of the
            // cone to direct air at the nozzle tip
            ventod = duct_output_diam + 2*fan_wallthick; // Outer diameter of vent 
            cuwd = ventod * 2; // cutter cube width 
            ydc = duct_length * tan(duct_angle); // y-coord of duct output center
            translate([0, ydc - ventod/2, duct_length])
            rotate([-duct_angle, 0, 0])
            translate([0, duct_output_diam/2 + fan_wallthick, cuwd/2])
            cube(cuwd, center=true);
        }
    }
}

// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

module all_geom() {
    dx = 10;
    dy = 10;
    // Face_Plate
    //faceplate(topbrace=faceplate_top_brace);
    faceplate();
    // Hinge_Slide
    translate([-faceplate_base_width, 0, 0])
        hingeslide();
    // Fan_Plate_1
    translate([-(2*hinge_diam + dx), hinge_length/2 + dy, 0])
    fanplate();
    // Fan_Plate_2
    translate([2*hinge_diam + dx, hinge_length/2 + dy, 0])
    rotate([0, 0, 180])
    mirror([0,1,0]) fanplate();
    // Ducts
    translate([owd/2+dx, -(owd/2 + 3*dy/2) , 0])
    //simpleduct();
    rotate([0,0,-90])
    directduct(duct_mount="Slot");
    // Directional_Duct
    translate([-(owd/2+dx), -(owd/2 + 3*dy/2) , 0])
    rotate([0,0,90])
    directduct();
}

// Allow MakerBot Customizer to generate STL based on part selection
module print_part() {
    if (part == "Face_Plate") {
        //faceplate(topbrace=faceplate_top_brace);
        faceplate();
    } else if (part == "Hinge_Slide") {
        hingeslide();
    } else if (part == "Fan_Plate_1") {
        fanplate();
    } else if (part == "Fan_Plate_2") {
        mirror([0, 1, 0])
        fanplate();
    } else if (part == "Simple_Duct") {
        simpleduct();
    } else if (part == "Directional_Duct") {
        directduct();
    } else if (part == "All") {
        all_geom();
    } else {
        all_geom();
    }
}


// For running in native OpenSCAD
//show_build_plate = "No"; // Default is Yes
//part = "Face_Plate";
//part = "Hinge_Slide";
//part = "Fan_Plate_1";
//part = "Fan_Plate_2";
//part = "Simple_Duct";
//part = "Directional_Duct";
part = "All";
print_part();
