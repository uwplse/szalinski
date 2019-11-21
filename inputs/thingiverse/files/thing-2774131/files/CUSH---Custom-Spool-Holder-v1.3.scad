/* == Customizer Settings ================================================ */
/*[Gimbal Settings]*/

// in mm, e.g. control box width (with clamps) or outer dimensions (without clamps)
inner_bracket_width = 152; // v1.1: raised from 150 to gain some additional play
//inner_bracket_width = 125; // TUSH dimensions

// in mm, base material thickness of all parts
base_thickness = 3.0;

// in mm, optionally add some thickness to the spool guide and clamp to gain stability
additional_thickness = 0; // v1.3: added parameter, 0 for regular version
//additional_thickness = 7; // v1.3: broad version

// in mm, 0 for no hole
//screw_hole_diameter = 0.0;
screw_hole_diameter = 4; // v1.3: used for all new SLTs

// in mm, 0 for no clamps (inner bracket width will become outer width)
clamp_thickness = 3;

// in mm, 0 for no clamps
clamp_pin_length = 15;
//clamp_pin_length = 0; // TUSH dimensions

// in mm, raise bearings further from surface
bearing_padding_bottom = 2;

// in mm, lower/raise distance between bearings
bearing_distance_offset = 0;
//bearing_distance_offset = -33; // Small Spool (TUSH dimensions) for Tornado Box

// in mm, affects minimum spool guide diameter
bearing_diameter = 22;

// in mm, affects axis height
bearing_thickness = 7;

// in mm, affects axis diameter
bearing_bore = 8;

// in mm, affects height of bearing spacer, 0 for no spacer
bearing_spacer_height_offset = 0.5;

// in mm, affects radius of bearing spacer
bearing_spacer_radius_offset = 1.5;

// in mm, increases fixture diameter to keep spool on bearings
spool_guide_offset = 5;

// Surface detail level
resolution = 50; // [30:Draft, 50:Normal, 80:Smooth]


/* == Draw Spool Holder ================================================== */
spool_guide_diameter = bearing_diameter + spool_guide_offset;
SpoolHodler($fn=resolution);


/* == Modules ============================================================ */

/* Click-in (TUSH like) bearing fixture
 axis_diameter - inner diameter of the bearing
 axis_height - thickness of the bearing / 2
 guide_diameter - outer diameter of the spool guide
 padding_bottom - additional spacing between bearing and fixture base
 spacer_radius_offset - radius of the optional bearing spacer
 spacer_height_offset - height of the optional bearing spacer
 screw_diameter - diameter of the optional bolt hole
 thickness - thickness of the base material
 res - resolution
*/
module BearingFixture(axis_diameter = bearing_bore, axis_height = bearing_thickness/2,
                      guide_diameter = spool_guide_diameter,
                      padding_bottom = bearing_padding_bottom,
                      spacer_radius_offset = bearing_spacer_radius_offset,
                      spacer_height_offset = bearing_spacer_height_offset,
                      screw_diameter = screw_hole_diameter,
                      thickness = base_thickness, add_thickness = additional_thickness,
                      res = resolution) {
    difference() {
        union() {
            translate([guide_diameter/2, guide_diameter/2 + padding_bottom, 0]) {
                translate([0,0,thickness+add_thickness]) {
                    // axis
                    cylinder(h = spacer_height_offset + axis_height,
                             d = axis_diameter, $fn = res);
                    // bearing axis wheel spacer
                    cylinder(h = spacer_height_offset,
                             d = axis_diameter + spacer_radius_offset*2,
                             $fn = res);
                }
                // upper (rounded) base
                cylinder(h = thickness+add_thickness, d = guide_diameter, $fn = res);
            }
            // lower (rectangular) base
            cube([guide_diameter, guide_diameter/2 + padding_bottom, thickness+add_thickness]);
        }
        // axis bolt hole
        translate([guide_diameter/2, guide_diameter/2 + padding_bottom, -1]) {
            cylinder(h = thickness+add_thickness + axis_height + 2, d = screw_diameter, $fn = res);
        }
    }
}
//BearingFixture();

/* Basic spool holder comprised of two bridged BearingFixtures */
module BasicSpoolHoder() {
    thickness = base_thickness;
    base_width = inner_bracket_width + 2 * clamp_thickness - spool_guide_diameter
                 + bearing_distance_offset;
    base_height = max(clamp_thickness, thickness) + spool_guide_diameter/2
                  + bearing_padding_bottom;

    union() {
        // left bearing fixture
        translate([0,max(clamp_thickness, thickness),0]) {
            BearingFixture();
        }
        // bridge between bearing fixtures
        translate([spool_guide_diameter,0,0]) {
            cube([base_width - spool_guide_diameter, base_height, thickness]);
        }
        // spacer bettween two fixtures
        cube([base_width + spool_guide_diameter, max(clamp_thickness, thickness),
              thickness + bearing_thickness/2 + bearing_spacer_height_offset]);
        // reight bearing fixture
        translate([base_width,max(clamp_thickness, thickness),0]) {
            BearingFixture();
        }
    }
}
//BasicSpoolHoder();

/* Spool holder comprised of the BasicSpoolHoder and (optional) "clamp" brackets */
module SpoolHodler() {
    clamp_thickness_z = base_thickness + additional_thickness + bearing_thickness/2 + bearing_spacer_height_offset;

    union() {
        translate([-bearing_distance_offset/2,clamp_pin_length,0]) {
            BasicSpoolHoder();
        }
        if (bearing_distance_offset < 0 && bearing_distance_offset < -clamp_thickness) {
            UClampSoft(w = inner_bracket_width, h = clamp_pin_length, d = clamp_thickness,
                    dz = clamp_thickness_z);
        } else {
            UClamp(w = inner_bracket_width, h = clamp_pin_length, d = clamp_thickness,
                   dz = clamp_thickness_z);

        }
    }
}
//SpoolHodler();

/* U-shaped "clamp" (bracket) based on inner dimensions and thickness
 [w] inner width (space between two pins)
 [h] inner height (pin length)
 [d] clamp diameter
 [dz] clamp z diameter
*/
module UClamp(w, h, d, dz) {
    difference() {
        cube([w+2*d,h+d,dz]);
        translate([d,-1,-1]) {
            cube([w,h+1,dz+2]);
        }
    }
}
//UClamp(10,10,10,10);
//UClamp(20,10,15,8);

/* U-shaped "clamp" (bracket) based on inner dimensions and thickness
 [w] inner width (space between two pins)
 [h] inner height (pin length)
 [d] clamp diameter
 [dz] clamp z diameter (thtickness)
*/
module UClampSoft(w, h, d, dz) {
    module UCLeft() {
        union() {
            hull() {
                cube([d,h,dz]);
                translate([d/2,d/2+h,0]) cylinder(d=d, h=dz);
            }
            hull() {
                translate([d,h,0]) cube([w/2,d,dz]);
                translate([d/2,d/2+h,0]) cylinder(d=d, h=dz);
            }
        }
    }
   union() {
       UCLeft();
       translate([w+2*d,0,0]) mirror([1,0,0]) UCLeft();
   }
}
//UClampSoft(20,10,15,8);
