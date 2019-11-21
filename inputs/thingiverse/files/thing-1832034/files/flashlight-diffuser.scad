/**
 * Parametric module to create a flashlight diffuser.
 *
 * This OpenSCAD library is part of the [dotscad](https://github.com/dotscad/dotscad)
 * project, an open collection of modules and Things for 3d printing.  Please check there
 * for the latest versions of this and other related files.
 *
 * @copyright  Chris Petersen, 2016
 * @license    http://creativecommons.org/licenses/LGPL/2.1/
 * @license    http://creativecommons.org/licenses/by-sa/3.0/
 *
 * @see        http://www.thingiverse.com/thing:1832034
 * @source     https://github.com/dotscad/things/blob/master/flashlight_diffuser/flashlight_diffuser.scad
 */

/* ******************************************************************************
 * Thingiverse Customizer parameters and rendering.
 * ****************************************************************************** */

/* ** Global tab is disabled because Customizer is broken ** [Global] */

// Inner diameter of the diffuser (e.g. 15.33 fits my Fenix LD02 AAA light)
diameter = 15.33;

// Height of the sleeve that fits over the end of the flashlight
sleeve_height = 12;

// Height of the diffuser (in case you want to make a tall one)
diffuser_height = 20;

// Type of diffuser to print (accepting pull requests for more).  Use None for testing diameter.
diffuser_type = "Dome"; // [Dome, None]

// Flat Top radius (set to 0 for a round dome)
top_radius = 7.5;

// Fillet roundover for the flat top
top_fillet = 2;

// Visual cutout to show internal structure
cross_section = false; // [true, false]

/* [Hidden] */

// Allow more triangles for a larger radius
$fn = (diameter < 40) ? 50 : 75;

// A global overlap variable (to prevent printing glitches)
$o = .1;

/* ******************************************************************************
 * Render the part
 * ****************************************************************************** */

diffuser(diameter/2, top_radius, top_fillet, sleeve_height, diffuser_type, diffuser_height, cross_section);

/* ******************************************************************************
 * Main module code below:
 * ****************************************************************************** */

// This module is copied into place so thingiverse customizer will work.
// @see https://github.com/dotscad/dotscad/blob/master/on_arc.scad
module on_arc(radius, angle) {
    x = radius - radius * cos(angle);
    y = radius * sin(angle);
    translate([x,y,0])
        rotate([0,0,-angle])
            children();
}

// Dome diffuser
module dome_diffuser(radius, top_r, top_fillet, wall, height) {
    // Yes, this is the opposite of the "diffuser" module.  It's on purpose.
    outer_r = radius;
    inner_r = radius - wall;
    // The absolute minimum "height" (center of sphere radius) for inner and outer parts
    outer_height = max(0, height - outer_r);
    inner_height = outer_height;

    difference() {
        union() {
            difference() {
                // outer dome
                union() {
                    hull() {
                        translate([0,0,outer_height]) difference() {
                            sphere(r=outer_r);
                            translate([0,0,-outer_r]) cylinder(r=outer_r*2, h=outer_r);
                        }
                        if (top_r > 0) {
                            translate([0,0,outer_height+outer_r-top_fillet]) {
                                rotate_extrude() {
                                    translate([top_r-top_fillet,0])
                                        circle(r=top_fillet);
                                }
                            }
                        }
                    }
                    cylinder(r=outer_r, h=outer_height+$o);
                }
                // inner dome
                hull() {
                    translate([0,0,inner_height]) union() {
                        sphere(r=inner_r, $fn=8);
                        hull() {
                            cylinder(r=inner_r, h=$o);
                            translate([0,0,sin(45/2)*inner_r]) cylinder(r=inner_r * cos(45/2), h=$o, $fn=8);
                        }
                    }
                    cylinder(r=inner_r, h=$o);
                }
            }
        }
        // Chop off the bottom (and a bunch that might fall 
        translate([0,0,-height]) cylinder(r=inner_r, h=height+$o);
    }
}

// Inner diffuser, since many LED flashlights are too focused and need to be spread out even more.
module inner_diffuser(radius, wall) {
    // Calculate the necessary radius value
    outer_r = radius + wall;
    // We don't want thickness to match the outer wall, just be as thin as
    // necessary to be strong but diffuse light.
    thickness = 1;
    // Calculate the height and top radius, based on the top of an octagon,
    // which should give us a 45 degree slope and a radius that matches the
    // top of the
    height = outer_r / (2 + sqrt(2));
    top_r = sqrt(2) * height;
    difference() {
        union() {
            // Top surface
            cylinder(r1=outer_r, r2=top_r, h=height);
            // Reinforcement to protect against jamming the diffuser on too hard
            translate([0,0,-thickness]) cylinder(r=outer_r, h=1+thickness);
        }
        // Lower surface
        translate([0,0,-thickness-$o]) cylinder(r1=outer_r, r2=top_r, h=height);
        // Poke a tiny hole through the center of this to prevent it from closing off the
        // inner core of the diffuser such that some slicers would allow it to be filled in.
        translate([top_r,0,0]) cylinder(r=.0001, h=radius+$o);
    }
}

module diffuser(radius, top_radius, top_fillet, sleeve_height, diffuser_type, diffuser_height, cross_section=false) {
    // Larger diameters seem to need more structure
    wall = (radius < 20) ? 1 : 2;
    // Calculate the inner and outer radius values
    inner_r = radius;
    outer_r = radius + wall;

    // Radius of the friction-fit bumps
    bump_r = .5;
    // Radius of the "circle" used for the sleeve stop ledge
    stop_r = sqrt(2)*1.5; // square rotated 45 degrees,

    // Normlize the top radius so it's not too small.
    // Will let users make their own choice about too big.
    top_r = max(top_radius, 0);

    difference() {
        union() {
            // Cone
            if (diffuser_type == "Dome")
                translate([0,0,sleeve_height-$o])
                    dome_diffuser(outer_r, top_r, top_fillet, wall, diffuser_height);
            // Internal diffuser
            if (diffuser_type != "None")
                translate([0,0,sleeve_height-bump_r])
                    inner_diffuser(radius, wall);
            // Sleeve
            difference() {
                cylinder(r=outer_r, h=sleeve_height+$o);
                translate([0,0,-$o]) cylinder(r=inner_r, h=sleeve_height*2);
            }
            // "fit" enhancements
            intersection() {
                // Copy of the cylinder above to prevent clipping outside of the main shape.
                // Includes a little extra height to let the stop-ring go high, in case this
                // is printed upside down.
                cylinder(r=outer_r, h=sleeve_height+$o+sqrt(2)*stop_r/2);
                union() {
                    // Friction-fit bumps
                    translate([-inner_r,0,bump_r])
                        for(a = [0 : 45 : 360])
                        on_arc(inner_r, a) {
                            hull() {
                                translate([-bump_r,0,0]) sphere(r=bump_r);
                                translate([0,0,sleeve_height-bump_r*2]) sphere(r=bump_r);
                            }
                        }
                    // A stop, so you don't press it on too far (also reinforces the internal diffuser)
                    // Commented out because the inner diffuser performs this function.
                    *translate([0,0,sleeve_height - .8]) rotate_extrude()
                        translate([inner_r, -sqrt(2)*stop_r/2]) hull() {
                            rotate(45) square(stop_r);
                            translate([0,.8]) rotate(45) square(stop_r);
                        }
                }
            }
        }
        // Cutout for testing purposes (openscad wireframe is too slow these days)
        if (cross_section) {
            translate([-radius*2,-radius*2,-1]) cube([radius*4,radius*4,(sleeve_height+diffuser_height)*4], center=true);
        }
    }
}

