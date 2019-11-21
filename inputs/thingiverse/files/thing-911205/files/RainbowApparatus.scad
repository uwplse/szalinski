/*
The Rainbow Apparatus
Copyright (C) 2015 Marcio Teixeira

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

/* [Global] */

// Select preview to see the cup and illumination pattern. Use "printable_base" to render an object to print. Due to the complexity of the object, the preview may have strange artifacts.
what_to_render             = "preview"; // [preview, preview_with_rays, just_the_illumination, printable_base, printable_support, printable_ring, printable_eye_guard, printable_turn_wheel, printable_screen, printable_disc]

/* [Supports] */

apparatus_height           = 100;
support_thickness          = 3;
support_tab_depth          = 10;

/* [Base] */
eyeguard_radius            = 37;

/* [Rear Bay] */
// The rear bay can be used to house the electronics, such as the DC converter
use_bay                    = "yes"; // [yes, no]
bay_width                  = 11.15;
bay_heigth                 = 17.44;
bay_depth                  =  3.65;
bay_clearance              =  1.0;

/* [Disc] */

// The disc is an EXPERIMENTAL feature. FDM printers cannot print it.
use_disc                   = "no"; // [yes, no]
// For "external", you must download the standalone OpenSCAD files.
disc_pattern               = "calibration"; // [calibration, blank, external]
disc_radius                = eyeguard_radius + 2;
disc_thickness             = 2;

/* [Screen] */

layer_height               = 0.2;
screen_layers              = 1.5;

/* [hidden] */
$fn                        = 40;
svg_size                   = 100;
svg_scale                  = 0.9;


/* Like regular cube, but you can specify centering on an axis by axis basis.
 */
module ccube(size, center=[0,0,0]) {
    translate( [
        center[0] * -size[0]/2,
        center[1] * -size[1]/2, 
        center[2] * -size[2]/2
    ])

    cube(size=[size[0],size[1],size[2]]);
}

/* The following module defines a cut-out for a DC-DC converter on the back
 * of the sconce.
 *
 * As currently configured, it is sized for a micro DC converter
 * purchased from eBay as "10pcs Mini DC-DC Converter Step Down Module
 * Adjustable Output 1-17V for RC PLANE" from axeprice
 */
 module electronics_bay() {
    translate([0,0,0.1])
    hull() {
        ccube([
            bay_width  + bay_clearance*2,
            bay_heigth + bay_clearance*2,
            bay_depth  + bay_clearance*2],
            center=[1,1,0]
        );
        ccube([
            bay_width/2,
            bay_heigth+4,
            bay_depth  + bay_clearance*2],
            center=[1,1,0]
        );
    }
}

/**** Generalized coordinate system conversion routines ****
  *
  * References:
  *   http://stackoverflow.com/questions/21125987/how-do-i-convert-a-coordinate-in-one-3d-cartesian-coordinate-system-to-another-3
  *   http://gamedev.stackexchange.com/questions/26084/transform-between-two-3d-cartesian-coordinate-systems
  */

/* This function generates a combined rotation and translation matrix that takes an object into a new coordinate system,
 * or out of that coorinate system. The coordinate system must be defined by an origin and a matrix of three orthogonal
 * unit vectors. 
 */
function coorindate_system_matrix(
    cs_origin = [0,0,0], cs_axes = [[1,0,0],[0,1,0],[0,0,1]], inverse = false
) = (inverse == false) ? [
        [cs_axes[0][0], cs_axes[1][0], cs_axes[2][0], cs_origin[0]],
        [cs_axes[0][1], cs_axes[1][1], cs_axes[2][1], cs_origin[1]],
        [cs_axes[0][2], cs_axes[1][2], cs_axes[2][2], cs_origin[2]],
        [            0,             0,             0,           1]
    ] : ([
        [cs_axes[0][0], cs_axes[0][1], cs_axes[0][2],           0],
        [cs_axes[1][0], cs_axes[1][1], cs_axes[1][2],           0],
        [cs_axes[2][0], cs_axes[2][1], cs_axes[2][2],           0],
        [            0,             0,             0,           1]
    ]  * [[1,0,0,-cs_origin[0]], [0,1,0,-cs_origin[1]], [0,0,1,-cs_origin[2]], [0,0,0,1]]
);

/* This function returns a combined rotation and translation matrix that takes an object from one coordinate system
 * into another. Each coordinate system must be defined by an origin and a matrix of three orthogonal unit vectors. 
 */
function coorindate_system_change(
    cs1_origin = [0,0,0], cs1_axes = [[1,0,0],[0,1,0],[0,0,1]],
    cs2_origin = [0,0,0], cs2_axes = [[1,0,0],[0,1,0],[0,0,1]]
) = coorindate_system_matrix(cs2_origin, cs2_axes, false) * coorindate_system_matrix(cs1_origin, cs1_axes, true);

/* This function orients the Z axis of the children to point at point_to
 */
module orient_to(point_to, up = [0,0,1]) {
    
    z_unit = point_to/norm(point_to);
    x_unit = cross(up,z_unit);
    y_unit = cross(z_unit, x_unit);
    
    multmatrix(coorindate_system_matrix(cs_axes = [x_unit,y_unit,z_unit]))
        children();
}

/**** Generalized extrusion routines ****
 *
 * The native OpenSCAD linear_extrude routine extrudes a 2D shape lying on the XY plane in the
 * positive Z direction. For shadow casting, I generalize this routine so a 2D shape can be
 * extruded from an arbitrary plane down to a single point anywhere.
 *
 * For shadow casting, the point will be the light source, while the plane is the projection
 * surface (wall, floor, etc). The extruded shape defines the ray volume one must subtracted
 * from a casting surface to obtain the desired pattern.
 */
 
module extrude_plane_down_to_point(extrude_to_point = [0,0, 100], plane_origin = [0,0,0], plane_uv = [[1,0,0],[0,1,0]], preview = false) {
    
    // Transform UV vector into a set of axes for a coordinate system
    
    plane_axes = [plane_uv[0], plane_uv[1], cross(plane_uv[0], plane_uv[1])];
    
    relative_extude_to = extrude_to_point - plane_origin;
    
    // linear_extrude does not allow lateral extrusion, so decompose the local_extude_to
    // into components along UV plane and a component perpendicular to it.
    
    translate_along_uv =  plane_uv      * relative_extude_to;
    extrusion_along_z  =  plane_axes[2] * relative_extude_to;
    
    if($debug) {
        echo("plane_axes",          plane_axes);
        echo("relative_extude_to",  relative_extude_to);
        echo("translate_along_uv",  translate_along_uv);
        echo("extrusion_along_z",   extrusion_along_z);
    }
    
    mirror_z = extrusion_along_z < 0;
    
    // Compute affine transformation that rotates and translates the extuded shape into place
    
    affine_xform = coorindate_system_change(
        cs1_origin = [0,0, extrusion_along_z],
        cs2_origin = extrude_to_point,         cs2_axes = plane_axes
    );
    
    // If preview is false, we do a full extrusion along extrusion_along_z,
    // diminishing down to a pinpoint; if preview is true, just extrude enough
    // to create a thin slice.
    
    multmatrix(affine_xform)
        mirror([0, 0, mirror_z ? 1 : 0])
        linear_extrude(
                height = preview ? 0.01 : extrusion_along_z * (mirror_z ? -1 : 1),
                scale  = preview ?    1 : 0.0001
            )
            translate([-translate_along_uv[0], -translate_along_uv[1], 0])
                children();
}

/**** LED rendering routines ****/

/* Bottle caps make for cheap heat sinks for LEDs */

bottle_cap_d1 = 30.9;
bottle_cap_d2 = 26.70;
bottle_cap_h  = 5.41;

module bottle_cap() {
    difference() {
        w = 0.3;
        cylinder(
            d2 = bottle_cap_d2,
            d1 = bottle_cap_d1,
            h  = bottle_cap_h
        );
        translate([0,0,-0.1])
            cylinder(
                d2 = bottle_cap_d2 - w,
                d1 = bottle_cap_d1 - w,
                h  = bottle_cap_h - w
            );
    }
}

/* A hexagon with parallel sizes d units apart */
module hexagon(d, nSides=6) {
    w = (d/2)*tan(360/(nSides*2))*2;
    for( a = [0:360/nSides:360] ) {
        rotate([0,0,a])
            square([d,w],center=true);
    }
}

/* An 20mm LED star with the emitter at the origin,
 * optionally w/ a heat sink */

led_diameter        = 20;
led_emitter_to_base = 4;

module led_star_profile() {
    hexagon(led_diameter);
}

module led_star(heat_sink = false, led_color = "red") {
    if($what_to_render == "cutout") {
        translate([0,0,-led_emitter_to_base])
            linear_extrude(10)
                led_star_profile();
    } else {
        translate([0,0,-led_emitter_to_base]) {
            linear_extrude(1.4)
                led_star_profile();
            
            if(heat_sink)
                color("gray", 0.25)
                    mirror([0,0,1])
                        bottle_cap();
            
            cylinder(d = 8, h = led_emitter_to_base);
        }
        
        color(led_color) sphere(d = 5.5);
    }
}

module cast_shadow(led_origin, plane_origin = [0,0,0], plane_uv = [[1,0,0],[0,1,0]], led_color = "green") {
    
    if(
        $what_to_render == "preview" ||
        $what_to_render == "preview_with_rays" ||
        $what_to_render == "cutout") {
        // Render a preview of the LED module
        translate(led_origin)
            orient_to(plane_origin - led_origin, plane_uv[0])
                led_star(heat_sink = false, led_color = led_color);
    }
    
    if($what_to_render != "cutout") {
        color(led_color,0.25)
            extrude_plane_down_to_point(
                led_origin,
                plane_origin, plane_uv,
                $what_to_render=="preview")
                children();
    }
}

/**** Utility routines ****/

// Render a part as a cutout, adding a gap around it all all sides for clearance
module cutout(clearance=0.6) {
    $what_to_render = "cutout";
    minkowski() {
        children();
        cube(size=[clearance,clearance,clearance],center=true);
    }
}



led_z           = 0;
led_separation  = 40;

screen_diameter = 100;
screen_uv       = [[1,0,0],[0,1,0]];

wall_thickness  = 2;
base_thickness  = 10;
rim_thickness   = 10;

led_offset      = led_separation/(2* sin(60));

base_total_h    = bay_depth + base_thickness;

screen_z        = apparatus_height - rim_thickness - base_total_h;

leds = [
    ["red",     0],
    ["green", 120],
    ["blue",  240]
];

/*
 * The use of a projection disc is an EXPERIMENTAL feature. It would require
 * a far greater print resolution and accuracy than an FDM printer.
 *
 * To generate your own projection disc:
 *
 *   1) Create an Inkscape document
 *   2) Set the document size to 100 x 100 mm (File -> Document Properties...)
 *   3) Create a design within the document boundary (if auto-tracing a bitmap,
 *       it will vastly speed up rendering time if you simplify the path several
         times).
 *   4) Export to path OpenSCAD file using "Paths to OpenSCAD" plug-in
 *   5) Open generated OpenSCAD file
 *      a) Search and replace all instances of "linear_extrude(height=h)" with ""
 *      b) Wrap all poly_useXXXX calls in a module definition and separate
 *         by color:
 *
 *            module design(color) {
 *               if(color == "green") {
 *                  poly_pathXXXX(2);
 *                  ...
 *               }
 *               if(color == "red") {
 *                  poly_pathXXXX(2);
 *                  ...
 *               }
 *               if(color == "blue") {
 *                  poly_pathXXXX(2);
 *                  ...
 *               }
 *             
 *            }
 *   6) Adjust the "use" statement below if necessary
 */
     
use<hhgttg-design.scad>

module import_design(color) {
    image_scale  = screen_diameter/(svg_size/svg_scale);
    
    intersection() {
        if( what_to_render == "printable_disc" ||
            what_to_render == "just_the_illumination") {
            if($design == "blank" || use_disc == "no") {
                circle(d = screen_diameter, center=true);
            }
            else if($design == "calibration") {
                r = [[1, 1, 0], [0, 1, 0], [0, 1, 1]];
                g = [[0, 1, 1], [0, 1, 1], [1, 0, 1]];
                b = [[0, 0, 1], [1, 1, 0], [1, 1, 0]];
                
                for(x=[-1,0,1],y=[-1,0,1])
                    translate([x*30,y*30])
                        if(
                            color == "red"   && r[1+x][1+y] ||
                            color == "green" && g[1+x][1+y] ||
                            color == "blue"  && b[1+x][1+y]) {
                            if((x + y) % 2 == 0) {
                                circle(d=20, center=true);
                            }
                            else
                                square(size=[20,20], center=true);
                        }
            }
            else if($design == "external") {
                scale([image_scale,image_scale])
                    design(color);
            }
        }
        
        // Bound the design to the projection screen
        circle(d = screen_diameter, center=true);
    }
}

$debug = false;

// Compute the location of the disc such that the cells
// on the disc just barely touch

gap = 3;
disc_z = screen_z/(1+screen_diameter/(led_separation-gap));

// Compute the size and separation of the projection
// cells on the holodisc. These two values should
// be the same, if the above computation is correct.

cell_diameter   = screen_diameter *   disc_z/screen_z;
cell_separation = led_separation  *(1-disc_z/screen_z);

// The spindle diameter is the incribed circle
spindle_r       = cell_separation*0.5/sin(60) - cell_diameter/2-1;

outer_diameter  = screen_diameter + 10;

if($debug) {
    echo("Cell diameter:",   cell_diameter);
    echo("Cell separation:", cell_separation);
    echo("Spindle radius:",  spindle_r);
}

module led_projector() {
    for( led = leds ) {
        led_origin = [
            led_offset * cos(led[1]),
            led_offset * sin(led[1]),
            led_z
        ];
        
        screen_origin = [0, 0, screen_z];
        
        cast_shadow(led_origin, screen_origin,
                screen_uv, led[0])
            import_design(led[0]);
    }
}

module screen_rim() {
    lip_size = 2;
    lip_h    = 1;
    difference() {
        translate([0,0,screen_z-lip_h])
        union() {
            linear_extrude(rim_thickness) {
                // Loops for support arms
        
                for(a=[0,120,240])
                    rotate([0,0,a])
                        translate([-outer_diameter/2 -support_thickness/2,0,0])
                            circle(r = support_thickness*2);


                difference() {
                    circle(d = outer_diameter);
                    circle(d = screen_diameter);
                }
            }
            // Lip for membrane
            linear_extrude(lip_h)
                difference() {
                    circle(d = outer_diameter);
                    circle(d = screen_diameter-lip_size*2);
                }
        }
        
            
        // Cutout for support arms
        cutout() supports();
    }
}

module screen_retainer() {
    lip_h    = 1;
    translate([0,0,screen_z-lip_h])
        union() {
            linear_extrude(rim_thickness-lip_h) {
                difference() {
                    circle(d = screen_diameter-1);
                    //circle(d = screen_diameter-3);
                }
            }
        }
}

module screen_membrane(clearance=0.6) {
    linear_extrude(layer_height*screen_layers)
        circle(d = screen_diameter-clearance*2);
}

module holodisc() {
    difference() {
        translate([0,0,disc_z])
            linear_extrude(disc_thickness)
                difference() {
                    circle(r=disc_radius);
                    circle(r=spindle_r);
                }
                
        // Subtract out the cutouts
        if($what_to_render == "printable_disc")
            led_projector();
    }
}

module circle_with_ridges(r, wall_thickness, ridge_depth = 0.5, ridge_mm = 3) {
    difference() {
        circle(r = r);
        
        if(wall_thickness > 0) {
            circle(r = r - wall_thickness);
        }
        
        if(ridge_depth > 0 && $what_to_render != "cutout") {
            nRidges     = round((r*PI)/ridge_mm);
            ridge_angle = 360/nRidges;
        
            for(a=[0:ridge_angle:360])
                rotate([0,0,a+60])
                    translate([r,0,0])
                        square([wall_thickness*ridge_depth*2,ridge_mm],center=true);
        }
    }
}

module center_cover(top_z, bot_z, barrier_z, r, ridge = 0.5, sink_into_base = 1,  wall_thickness = 1) {
    echo(r);
    total_h        = top_z + sink_into_base;
    
    barrier_top    = total_h - wall_thickness/2;
    barrier_bot    = barrier_z + sink_into_base;
    barrier_h      = barrier_top - barrier_bot;

    difference() {
        translate([0,0,-sink_into_base])
            union() {
                // Side walls
                linear_extrude(total_h)
                    circle_with_ridges(r, wall_thickness, ridge);
                    
                
                // Top lid with spindle hole
                if($what_to_render != "cutout")
                    translate([0,0, total_h - wall_thickness])
                        linear_extrude(wall_thickness)
                            difference() {
                                circle(r = r);
                                circle(r = spindle_r);
                            }
                            
                // Light barrier
                if(barrier_h > 0)
                    for(a=[0,120,240])
                        rotate([0,0,a+60])
                            translate([r/2,0, barrier_top - barrier_h/2])
                                cube([
                                    r - wall_thickness,
                                    wall_thickness,
                                    barrier_h],
                                center=true);
            }
            
        if($what_to_render != "cutout")
            led_projector($design = "none");
            
        // Remove the spindle
        cutout() central_spindle();
        
        // Cutout for wires
        if(barrier_h > 0 && $what_to_render != "cutout")
            wire_channels();
    }
}

module turn_wheel(eye_guard = false, wall_thickness = 1) {
    disc_gap          = 0.5;
    eyeguard_gap      = 1;
    
    // The eye guard sits just inside the turn wheel and
    // recesses into the base by a bit
    
    inset              = wall_thickness + eyeguard_gap;
    sink_into_base     = 1;
    
    echo("Eyeguard radius: ", eyeguard_radius);
    echo("Disc radius: "    , disc_radius);
    
    // Radius of cover is a bit less than the disc to make it easy
    // to turn the disc by hand.
    center_cover(
        top_z          = disc_z - disc_gap + (eye_guard ? 0 : inset),
        barrier_z      = eye_guard ? -sink_into_base : undef,
        r              = eyeguard_radius   + (eye_guard ? 0 : inset),
        ridge          = eye_guard ? 0 : 0.5,
        sink_into_base = eye_guard ? sink_into_base : 0,
        wall_thickness = wall_thickness
    );
}

module eye_guard() {
    turn_wheel(true);
}

module central_spindle(clearance = 0.6) {
    cylinder(
        r  = spindle_r - clearance,
        h = disc_z + disc_thickness);
    cylinder(
        r2 = spindle_r - clearance,
        r1 = led_offset*0.40,
        h = disc_z - clearance
    );
    
    // Let the spindle extend a bit into the base so
    // that cutouts for the eyeguard work properly
    translate([0,0,-base_total_h/2])
    cylinder(
        r = led_offset*0.40,
        h = base_total_h/2
    );
}

module wire_channels() {
    // Torus shaped wire guides (top and bottom)
    for(z=[0,-base_total_h])
        rotate_extrude() translate([led_offset,z]) circle(d=5);
    
    // Vertical vias
    for(a=[0,120,240]) {
        rotate([0,0,a+60])
            translate([led_offset,0,-base_total_h-0.5])
                cylinder(d=5,h=base_total_h+1);
    }
}

module base(clearance = 0.6) {
    
    difference() {
        union() {
            translate([0,0,-base_total_h])
                cylinder(d=outer_diameter, h = base_total_h);
            
            central_spindle(clearance);
        }
        
        // Subtract out the cutout for the LEDs
        cutout(clearance=1) led_projector();
        
        wire_channels();
        
        // Electronics bay and wire exit
        rotate([0,0,30])
            translate([0,led_offset,-base_total_h-0.2]) {
                if(use_bay == "yes")
                    electronics_bay();
            
                // Wire outlet
                rotate([-90,0,0])
                    cylinder(d=5,h=outer_diameter-led_offset);
            }
        
        // Cutout for support arms
        cutout() supports();
        
        // Cutout for recessed eye_guard
        cutout(clearance=0.5) eye_guard();
    }
}

module support_profile(thickness=3) {
    square(size = [thickness,screen_z+base_total_h]);
    translate([0,thickness])
        square(size = [support_tab_depth, base_total_h-thickness*2]);
    
        translate([0,screen_z+base_total_h])
        difference() {
            translate([-thickness, -thickness])
                square(size = [
                    thickness*2,
                    rim_thickness+thickness]
                );
            square(size = [
                thickness*2,
                rim_thickness+thickness]
            );
        }
}

module supports() {
    support_h = screen_z + base_total_h + rim_thickness;
    
    for(a=[0,120,240]) {
        rotate([0,0,a])
            translate([-outer_diameter/2,support_thickness/2,-base_total_h])
                rotate([90,0,0])
                linear_extrude(support_thickness)
                    support_profile(support_thickness);
    }
}

module apparatus() {
    translate([0,0,base_total_h]){
        screen_rim();
        base();
        if(use_disc == "yes") holodisc();
        led_projector($what_to_render = what_to_render);
        supports();
        turn_wheel();
        eye_guard();
    }
}

if(what_to_render == "printable_base") {
    base();
} else if(what_to_render == "printable_support") {
    linear_extrude(support_thickness)
        support_profile(support_thickness);
} else if(what_to_render == "printable_ring") {
    screen_rim();
} else if(what_to_render == "screen_retainer") {
    screen_retainer();
} else if(what_to_render == "printable_disc") {
    holodisc($what_to_render = what_to_render, $design = disc_pattern);
} else if(what_to_render == "printable_screen") {
    screen_membrane();
} else if(what_to_render == "just_the_illumination") {
    for( c = ["red", "blue", "green"] )
        color(c,0.33) import_design(c, $design = disc_pattern);
} else if(what_to_render == "printable_turn_wheel") {
    rotate([180,0,0]) {
        turn_wheel();
    }
} else if(what_to_render == "printable_eye_guard") {
    rotate([180,0,0]) {
        eye_guard();
    }
} else{
    apparatus($design = disc_pattern);
}