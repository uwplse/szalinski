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

// Monoculight
// This is my entry for the Thingiversity Technology S.T.E.A.M. Challenge:
// LightItUp. The assembled part is a functional light-up eyeball demonstrator
// to encourage kids of all ages to think about how basic lens technology works
// and how the marvelous biological optical systems in our heads (aka our eyes)
// enable us to see.

// Units are in mm

// Optimize view for Makerbot Customizer:
// preview[view:"south west", tile:"top"]

/* [Global] */
// Choose geometry to preview:
part = "All"; // [Front_Half, Back_Half, Retina_Retainer, Lens_Mold, Lens_Cutter, Mold_Pestle, Mock_Lens, Ice_Mold, All]

/* [Eye Specs] */
// Sclera sidewall thickness (thinner will be more difficult to print):
shell_th = 2.0; // [0.8:0.2:4.0]
// Back Focal Length:
bfl = 64.0; // [40.0:1.0:80.0]
// The physical diameter of the lens:
lens_diam = 28.0; // [10.0:1.0:60]
// Lens Index of Refraction (for mold design):
refractive_index = 1.41; //[1.3:0.01:1.6]

/* [Electrical] */

// Number of LEDs to use:
num_leds = 6; // [0:1:12]
// Clearance hole diameter for each LED:
led_hole_diam = 5.2; // [4.0:0.1:6.0]
// Include battery holder?
make_batt_holder = "Yes"; // [Yes, No]
// Number CR2032 batteries in the holder
n_batts = 4; // [1:1:10]
// Include hole for mounting a switch
make_switch_hole = "Yes"; // [Yes, No]
// Clearance hole diameter for switch mount
switch_hole_diam = 7.0; // [4:1:12]


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
// Special variables for facets/arcs:
$fa = 1; // minimum fragment angle
// Minimum fragment size. If your running this on a local copy
// of OpenSCAD you can turn this down to make a smoother model (render
// times will drastically increase). To work with MakerBot
// Customizer on Thingiverse, this should be set to 2
$fs = 2;
//$fs = 0.8;

// Clearance to add to pockets to ensure fit (hint: use your nozzle diameter):
fit_clearance = 0.4; // [0:0.1:2.0]
// Width of lens support ring (excluding clearance):
lens_ridge = 1.6; // [0.8:0.2:2.4]
// How far above the lens pocket the iris should extend:
iris_proud = 2.0; // [0:0.2:4]
// How much to oversize the iris around the lens pocket:
iris_oversize = 8.0; // [4:1:12]
// Slope angle of the iris cone:
iris_slope = 40; // [30:5:60]

// How much the retina retainer ring should protrude from the shell
retain_proud = 3.0; // [0:0.2:5.0]
retina_ring_proud = 1.2;

// How much the coupling protrudes from the hemisphere
coupling_ht = 2.0;
// Thickness of the coupling ring
coupling_th = 2 * fit_clearance;

// Calculated parameters
// Clear Aperture
ca = lens_diam - 2 * lens_ridge;
// Lens pocket diam
pocket_diam = lens_diam + 2 * fit_clearance;
// Inner ring radius
r1 = sqrt(pow(ca, 2) + pow(bfl, 2)) / 2;
// Outer ring radius
r0 = r1 + shell_th;
// z-plane value of the top of the lens pocket (w/o iris)
pocket_top = sqrt(pow(r0, 2) - pow(pocket_diam/2, 2));
pocket_depth = pocket_top - bfl/2;
pocket_bot = pocket_top - pocket_depth;
iris_ht = iris_oversize * tan(iris_slope);
iris_diam_bot = pocket_diam + 2 * iris_oversize;
// How much the coupling ring intrudes inside the hemisphere
coupling_intrude = sqrt(pow(r1,2) - pow(r1-coupling_th,2));

// Function to calculate lens radius of curvature
// bfl: Back Focal Length
// th: Lens thickness
// ior: Lens index of refraction
function lensrad(bfl, th, ior) = (bfl + th/ior) * (ior - 1);

// Function to calculate the radial sag over a supplied diameter
// rad: arc radius
// diam: diameter at which to calculate the sag
function arcsag(rad, diam) = rad - sqrt(pow(rad, 2) - pow(diam / 2, 2));

// Function to calculate the diameter from the radius and sag
// rad: arc radius
// sag: arc sag
function arcdiam(rad, sag) = 2 * sqrt(2 * rad * sag - pow(sag ,2));

// Function to calculate the leg of supplied pythagorean
// hypotenuse and the its other leg
function pyleg(hypot, leg) = sqrt(pow(hypot,2) - pow(leg, 2));

// Find a "close" radius under thin lens conditions (th=0)
thinlens_radius = lensrad(bfl=bfl, th=0, ior=refractive_index);
// Build up a real thick lens using the thin lens radius as a starting point
// Thickness of the lens contributed by the curvature
thinlens_th = arcsag(thinlens_radius, lens_diam);
// Define the lens edge thickness as the pocket_depth
lens_eth = pocket_depth;
// Now find a reasonable total lens thickness
lens_tth = thinlens_th + lens_eth;
// Use this thickness to find the prescription for a real lens
lens_radius = lensrad(bfl=bfl, th=lens_tth, ior=refractive_index);
// Actual thickness from lens curvature then will be:
lens_cth2 = lens_radius - sqrt(pow(lens_radius,2) - pow(lens_diam/2,2));
// And actual edge thickness of the lens will be:
lens_eth2 = lens_tth - lens_cth2;

// Extend the lens radius all the way out to the edge of the mold
mold_diam2 = arcdiam(lens_radius, lens_tth);
// Slope angle of the lens mold exterior
mold_slope = 45;
// Thickness between the base of the mold and the vertex of the lens radius
mold_th = 2.0;
// Depth of the radius in the mold
mold_sag = arcsag(lens_radius, mold_diam2);
// Diameter of the base of the mold
mold_diam1 = mold_diam2 + 2*((mold_th + mold_sag)/tan(mold_slope));

module ring(od, id, h) {
  // Generate a ring
  // Adapted from the openscad documentation:
  // https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Include_Statement
  //
  // Parameters
  // ----------
  // od : Outer Diameter
  // id : Inner Diameter
  // h : height
  difference() {
    cylinder(h = h, d = od);
    translate([ 0, 0, -1 ])
      cylinder(h = h+2, d = id);
  }
}

module sclera() {
    // Fixed thickness shell
    difference() {
        // Outer Shell
        sphere(r=r0);
        // Inner Shell
        sphere(r=r1);
        // Chop off the bottom to leave a hemispherical shell
        translate(v=[0, 0, -1.1*r0/2])
        cube(size=[2.1*r0, 2.1*r0, 1.1*r0], center=true);
    }
}

module pupil_support() {
    // The pupil support ring tends to have difficulty
    // printing due to the overhanginess of the dome
    // at the pole. Put in a little support cone to
    // provide support.
    flatring_th = shell_th;
    flatring_bot = pocket_bot - flatring_th;
    // Flat ring support of the pocket. Added thickness helps ensure
    // edges are printing clean by time the extruder gets to the pocket
    flatring_od = 2*sqrt(pow(r1, 2)-pow(flatring_bot,2));
    translate([0, 0, bfl/2 - shell_th])
    ring(od=flatring_od + 0.01, id=ca, h=shell_th);
    // Construct a conical support for the flatring
    supring_th = shell_th;
    supring_bot = flatring_bot - supring_th;
    supring_od = 2 * pyleg(r1, supring_bot);
    difference() {
        intersection() {
            sphere(r=r0-.01);
            translate([0, 0, flatring_bot])
            translate([0, 0, -supring_th])
            difference() {
                translate([0, 0, 0.01])
                cylinder(h=supring_th, d=supring_od);
                cylinder(h=supring_th, d1=supring_od, d2=ca);
            }
        }
        cylinder(h=2*r0, d=ca);
    }
}

module pupil() {
    // Pupil clear aperture
    union() {
        difference() {
            children();
            cylinder(h=2*r0, d=ca);
        }
        pupil_support();
    }
}

module lens_pocket() {
    difference() {
        children();
        translate(v=[0, 0, bfl/2])
        cylinder(h=r0, d=pocket_diam);
    }
}

module iris() {
    // So we don't have a large unsupported flat area from the
    // iris cone, subtract out the inner hemisphere shell
    // then r0
    difference() {
        translate(v=[0, 0, pocket_top + iris_proud - iris_ht])
        cylinder(h=iris_ht, d1=iris_diam_bot, d2=pocket_diam);
        sphere(r=r1);
    }
}

module led_holes() {
    // Only punch holes for 1 LED or more
    if (num_leds > 0) {
    ang_step = 360 / num_leds;
    // Center the LED in the ring of the iris
    led_cent = pocket_diam/2 + iris_oversize/2;
    difference() {
        children();
        for (t = [0:ang_step:360-ang_step]) {
                rotate(a=[0, 0, t])
                translate(v=[led_cent, 0, 0])
                cylinder(h=2*r0, d=led_hole_diam, $fs=$fs/10);
            }
    }
 } else { // num_leds == 0
     // Nothing to do but return the children
     children();
 }
 }

module front_half_subassy() {
    // Front half sub-assembly
    translate(v=[0, 0, coupling_ht])
    led_holes()
    lens_pocket() // The retina pocket is the same dimension as the lens pocket
    pupil()
    union() {
        iris();
        sclera();
        coupling_ring();
    }
}

module front_half() {
    // Front half of the model including the Sclera
    // hemispherical shell, Iris, the pocket for the lens
    // and holes for the LEDs
    if (make_batt_holder == "Yes") {
        if (make_switch_hole == "Yes") {
            make_bhold()
            switch_hole()
            front_half_subassy();
        }
        else {
            make_bhold()
            front_half_subassy();
        }
    }
    else {
        if (make_switch_hole == "Yes") {
            switch_hole()
            front_half_subassy();
        }
        else {
            front_half_subassy();
        }
    }
}

module coupling_ring() {
    translate(v=[0, 0, -coupling_ht]) {
        // Good snap fit when no clearance between inner shell and
        // coupling ring OD
        ring(od=2 * r1,
             id=2 * (r1 - coupling_th),
             h=coupling_ht + coupling_intrude);
    }
}

module make_bhold() {
    // Put battery holder(s) into the shell
    batt_holder()
    children();
}


module switch_hole() {
    difference() {
        children();
        rotate([60, 0, 0])
        cylinder(h=2*r0, d=switch_hole_diam, $fs=$fs/10);
    }
}

module retina_ring() {
    // Provide a little extra bite for the retina retainer
    translate([0, 0, pocket_bot])
    ring(od=pocket_diam + 2*shell_th,
         id=pocket_diam,
         h=retina_ring_proud + pocket_depth);
}

module back_half() {
    // Back half of the model including the Sclera
    // hemisphereical shell and retina pocker
    lens_pocket() // The retina pocket is the same dimension as the lens pocket
    pupil()
    union() {
        sclera();
        retina_ring();
    }
}

module retina_retainer() {
    // Should be a tight fit so friction helps it stay put
    // Instead of 2*fit_clearance on the diameter, do 1*fit_clearance
    ring(od=pocket_diam - fit_clearance,
         id=pocket_diam - fit_clearance - shell_th,
         h=retain_proud + pocket_depth);
}

module mock_lens() {
    // Make the edge thickness portion of the lens
    cylinder(d=lens_diam, h=lens_eth2);
    translate(v=[0, 0, lens_eth2])
    // Create radiused portion of the lens
    difference() {
        translate(v=[0, 0, lens_cth2 - lens_radius])
        sphere(r=lens_radius);
        translate(v=[0, 0, -2.1*lens_radius/2])
        cube(size=2.1*lens_radius, center=true);
    }
}


module lens_mold() {
    // Carve out the lens radius
    difference() {
        cylinder(h=mold_th + mold_sag, d1=mold_diam1, d2=mold_diam2);
        translate(v=[0, 0, lens_radius + mold_th])
        sphere(r=lens_radius, $fs=$fs/2);
    }
}

module ice_mold() {
    // Create a mold which can be filled with water, then frozen
    // to make a melt away lens mold
    // How much extra to add to the base of the mold
    icemold_excess = 1.2;
    // Diameter of the icemold
    icemold_diam = mold_diam1 + 2.0;
    icemold_depth = mold_th + mold_sag + icemold_excess;
    translate([0, 0, icemold_depth])
    rotate([180, 0, 0])
    difference() {
        translate([0, 0, 0.01])
        cylinder(h=icemold_depth, d=icemold_diam);
        lens_mold();
    }
}

module lens_cutter() {
    // Insert to press into uncured silicone in the lens mold
    // to form the lens clear aperture
    grip_len = 15; // Length of cutter grip handle
    // Make the cutter flush with the total lens thickness
    cutter_sag = lens_tth;
    // Width of the cutter
    cutter_wd = arcdiam(lens_radius, cutter_sag);
        translate(v=[0, 0, grip_len]) // Move back up to XY plane
        difference() { // Core it out
            intersection () {
                translate(v=[0, 0, cutter_sag - lens_radius])
                sphere(r=lens_radius);
                cylinder(h=2*grip_len, d=cutter_wd, center=true);
            }
            cylinder(h=2.1*grip_len, d=lens_diam, center=true);
        }
}

module mold_pestle() {
    // Use the mold as a mortar and this part as a pestle
    // for post process finishing of the mold surface.
    // You can affix sandpaper to the round end and
    // put the other end in a drill chuck. It's probably
    // advisable to print this part with a brim as it's tall
    // and may get knocked over on the platen.
    // Total length of the pestle:
    pestle_length = 50;
    // Base diameter 3/8" and 1/2" are common max drill chuck sizes
    pestle_diam1 = 9.2; // 3/8" chuck
    //pestle_diam1 = 12.4; // 1/2" chuck
    // Length of the chuck before starting the taper
    chuck_length = 15.0;
    union() {
        cylinder(h=chuck_length, d=pestle_diam1);
        // Cone handle part of the pestle
        translate(v=[0, 0, chuck_length])
        cylinder(h=pestle_length - chuck_length, d1=pestle_diam1,
                 d2=lens_diam);
        // Put the mock lens at the top of the pestle
        translate(v=[0, 0, pestle_length])
        mock_lens();
    }
}

// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
// Routines for generating the battery holder
// Inspired from bmcage's "Coin battery pack - No soldering needed"
// http://www.thingiverse.com/thing:79502 (thingiverse.com/bmcage)

// CR2032 Coin cell diameter
batt_diam = 19.8;
// CR2032 Coin cell thickness
batt_th = 3.0;
// Edge thickness of battery holder retainer walls
bhold_th = 1.2;
// Diameter of the battery mounting plate
bplate_diam = batt_diam + 2 * fit_clearance + 2*bhold_th;
// Depth of the holder geometry
bplate_depth = n_batts * batt_th + 2 * fit_clearance + bhold_th;
// How far inboard of the shell is needed to fit the whole plate
bplate_offset = arcsag(rad=r1, diam=2*bplate_diam);
// Depth of pocket for holding batteries
bpocket_depth = bplate_depth - bhold_th;
// Diameter of pocket for holding batteries
bpocket_diam = batt_diam + 2 * fit_clearance;
// Wire clearance diameter
wire_diam = 1.2;


module mock_cr2032() {
    // CR2032 mock-up
    translate(v=[0, 0, batt_diam/2])
    rotate(a=[0, 90, 0])
    cylinder(h=batt_th, d=batt_diam);
}

module wall_attach() {
    // Spherical interface to the inner shell
    difference() { // Truncate at battery plane
        translate(v=[r1 - bplate_offset, 0, 0])
        difference() { // Truncate bottom half of sphere
            sphere(r=r1+0.1); // Slight oversize to help CSG
            translate(v=[0, 0, -2.1*r1/2])
            cube(size=2.1*r1, center=true);
        }
        translate(v=[2.1*r1/2, 0, 0])
        cube(size=2.1*r1, center=true);
    }
}

module holder_boss() {
    union() {
        intersection() {
            union() {
                wall_attach();
                // The battery holder needs a little raft to get it up above
                // the centering ring without an overhang
                translate(v=[r1 - bplate_offset, 0, -coupling_ht])
                cylinder(h=coupling_ht+0.01, d=2*r1);
            }
            union() {
                translate(v=[0, 0, bplate_diam/2]) rotate(a=[0, 90, 0])
                cylinder(h=2.1*bplate_offset, d=bplate_diam, center=true);
                // Use cube for bottom half so holder is printable
                translate(v=[-bplate_offset, -bplate_diam/2, 0])
                cube([bplate_depth + bplate_offset, bplate_diam, bplate_diam/2]);
                // And a raft piece
                translate(v=[-bplate_offset, -bplate_diam/2, -coupling_ht])
                cube([bplate_depth + bplate_offset, bplate_diam, coupling_ht]);
            }
        }
          // Use cube for bottom half
          translate(v=[bplate_depth/2, 0, bplate_diam/4])
          cube([bplate_depth, bplate_diam, bplate_diam/2], true);
    }
}

module batt_pocket() {
    // Battery pocket solid (needs to be subtracted from boss)
    translate(v=[0, 0, bplate_diam/2])
    rotate(a=[0, 90, 0])
    cylinder(h=bpocket_depth, d=bpocket_diam);
    // Also include a hole in the bottom to help push the batteries back out
    removal_cutout_width = 6;
    removal_cutout_depth = pocket_diam + 2*coupling_ht;
    translate([0, -removal_cutout_width/2, -1.1*coupling_ht])
    cube([bpocket_depth, removal_cutout_width, removal_cutout_depth]);
}

module wire_holes() {
    // Holes for wires (needs to be subtracted from boss)
    $fs=$fs/10; // Locally increase resolution of facets
    wire_len1 = bplate_depth + bplate_offset + 2*shell_th;
    wire_xoff1 = bplate_offset + shell_th;
    wire_yoff1 = bplate_diam / 2 - wire_diam/2 - 2 * fit_clearance;
    wire_zoff1 = wire_diam/2 + 2 * fit_clearance;
    wire_len2 = bplate_depth + bplate_offset + 2*shell_th;
    wire_xoff2 = bplate_offset + bhold_th/2 + 2*shell_th;
    wire_yoff2 = bplate_diam / 4;
    wire_zoff2 = bplate_diam / 2;
    wire_len3 = batt_diam + 2*coupling_ht + 2*shell_th;
    wire_zoff3 = 1.1*(coupling_ht + shell_th);
    hole_diam = wire_diam + fit_clearance;
    wire_xoff3 = bplate_depth - (bhold_th + hole_diam) / 2;
    wire_zoff4 = wire_len3 - wire_zoff2;
    // Bottom corner holes (penetrate outer shell)
    translate([-wire_xoff1, -wire_yoff1, wire_zoff1]) rotate([0, 90, 0])
    cylinder(h=wire_len1, d=hole_diam);
    translate([-wire_xoff1, wire_yoff1, wire_zoff1]) rotate([0, 90, 0])
    cylinder(h=wire_len1, d=hole_diam);
    // Backplane holes and front face dedents (penetrate outer shell)
    translate([-wire_xoff2, -wire_yoff2, wire_zoff2]) rotate([0, 90, 0])
    cylinder(h=wire_len2, d=hole_diam);
    translate([-wire_xoff2, wire_yoff2, wire_zoff2]) rotate([0, 90, 0])
    cylinder(h=wire_len2, d=hole_diam);
    // Backplane wire channels
      // Horizontal channel
        translate([0, 0, wire_zoff2])
        rotate([90, 0, 0])
        cylinder(h=2*wire_yoff2, d=hole_diam, center=true);
      // Vertical channels
        translate([0, -wire_yoff2, -wire_zoff4])
        cylinder(h=wire_len3, d=hole_diam);
        translate([0, wire_yoff2, -wire_zoff4])
        cylinder(h=wire_len3, d=hole_diam);
    // Frontplane wire channels
    translate([wire_xoff3, 0, -wire_zoff3])
    cylinder(h=wire_len3, d=hole_diam);
    translate([wire_xoff3, 0, bplate_diam/4])
    rotate([90, 0, 0])
    cylinder(h=wire_len3, d=hole_diam, center=true);
}

module bhold_assy() {
    // Battery holder sub-assembly
    difference() {
        holder_boss();
        batt_pocket();
    }
}

module batt_holder_standalone() {
    // Generate the battery holder sub-assembly by itself
    //wall_attach();
    translate([0, 0, coupling_ht])
    difference() {
        bhold_assy();
        wire_holes();
    }
}

module batt_holder() {
    // Generate the battery holder in the context of the full
    // assembly.
    difference() {
        union() {
            children();
            translate([bplate_offset-r1, 0, coupling_ht])
            bhold_assy();
        }
        translate([bplate_offset-r1, 0, coupling_ht])
        wire_holes();
    }
}

// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

module all_geom() {
    dx = 1.1 * r0;
    dy = 1.75 * r0;
    translate(v=[-dx, 0, 0]) front_half();
    translate(v=[ dx, 0, 0]) back_half();
    translate(v=[ -1.2*dx, dy, 0]) retina_retainer();
    translate(v=[ 0, -dy, 0]) mold_pestle();
    translate(v=[ 1.4*dx, dy, 0]) ice_mold();
    translate(v=[ 0, dy, 0]) lens_mold();
    translate(v=[ dx, -dy, 0]) lens_cutter();
    translate(v=[ -dx, -dy, 0]) mock_lens();
}

// Allow MakerBot Customizer to generate STL based on part selection
module print_part() {
    if (part == "Front_Half") {
        front_half();
    } else if (part == "Back_Half") {
        back_half();
    } else if (part == "Pupil_Support") {
        pupil_support(); // Development tool
    } else if (part == "Retina_Retainer") {
        retina_retainer();
    } else if (part == "Lens_Mold") {
        lens_mold();
    } else if (part == "Lens_Cutter") {
        lens_cutter();
    } else if (part == "Mold_Pestle") {
        mold_pestle();
    } else if (part == "Mock_Lens") {
        mock_lens();
    } else if (part == "Batt_Holder") {
        batt_holder_standalone(); // Development tool
    } else if (part == "Custom_Trim") {
        // Useful for cutting out small sections for print testing
        difference() {
            //trim_amount = 27; // For front_half
            trim_amount = 25; // For back_half
            translate(v=[0, 0, -trim_amount])
            back_half();
            //front_half();
            translate(v=[0, 0, -100])
            cube(size=200, center=true);
        }
    } else if (part == "Ice_Mold") {
        ice_mold();
    } else if (part == "All") {
        all_geom();
    } else {
        all_geom();
    }
}

//part = "Front_Half";
//part = "Back_Half";
//part = "Pupil_Support"; // Development tool
//part = "Retina_Retainer";
//part = "Lens_Mold";
//part = "Mold_Pestle";
//part = "Lens_Cutter";
//part = "Mock_Lens";
//part = "Custom_Trim"; // Development tool
//part = "Batt_Holder";  // Development tool
//part = "Ice_Mold";
//part = "All";
//show_build_plate = "No";
print_part();