/*
Victorian Wallpaper Sconce
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

/* Inspired by the designs of Henry Segerman and Saul Schleimer
 *
 *   http://3dprintingindustry.com/2014/12/30/geometric-shadow-3d-printing/
 */

/* [Global] */

// Select preview to see the sconce and illumination pattern. Use "printable_object" to render an object to print. Due to the complexity of the object, the preview may have strange artifacts.
what_to_render         = "preview"; // [preview, preview_with_rays, just_the_wallpaper, printable_object]

/* [Sconce] */
sconce_dia             = 70;
sconce_height          = 130;
sconce_sides           = 6;    // [3:50]
flat_top               = "no"; // [yes, no]
sconce_taper           = 0.14; // [0:0.01:0.8]
sconce_wall_thickness  = 3;
sconce_top_dia         = sconce_dia * (1 + sconce_taper);
sconce_bottom_dia      = sconce_dia * (1 - sconce_taper);

/* [Mount] */
mount_thickness         = 10;
mount_width             = 50;
// Mount height as a percentage of the sconce height
mount_height_percentage = 0.75; // [0:0.1:1]
mount_height            = sconce_height*mount_height_percentage;
// Diameter of the wire guide
wire_guide_mm           = 5;
mount_style             = "rectangular"; // [rectangular, curved_front, oval, beveled, rounded]
// Corner size for "beveled" or "rounded"
mount_corner_size       = 0.5; // [0:0.1:1]

/* [Arm] */
arm_dia                =  20.0;
arm_height_on_mount    =  0.1;   // [0:0.05:0.9]
arm_taper              =  0.5;   // [0:0.05:0.5]
// Distance from the front of sconce to wall
distance_from_wall     =  160.0;

/* [LED] */
// Approximate distance from LED emitter die to the base of LED star or heatsink
emitter_dist_from_base = 3.5;

/* [Rear Bay] */
// The rear bay can be used to house the electronics, such as the DC converter
use_bay                    = "yes"; // [yes, no]
bay_width                  = 11.15;
bay_heigth                 = 17.44;
bay_depth                  =  3.65;
bay_clearance              =  1.0;
bay_height_on_mount        =  0.15;   // [0:0.05:0.7]
bay_z_on_mount             = (mount_height - bay_heigth) * bay_height_on_mount;

/* [Keyhole] */
// Enables a keyhole notch for attaching the mount on a nail or screw
use_keyhole            = "one"; // [none, one, two]
nail_shaft_dia         = 1.5;
nail_head_dia          = 3.5;
nail_head_thickness    = 2;
nail_clearance         = 0.25;
// distance from edge in proportion to width
from_edge              = 0.2; // [0:0.01:0.4]

slot_size              = nail_shaft_dia*3;

/* [Wallpaper] */
// Choose the wallpaper style. "External-file" won't work on the web-based Customizer
wallpaper_style        = "default";  // [default, polka-dot, external-file]
// For a printable design, avoid unsupported islands or downward pointing cusps on the tops of cutouts.
default_wallpaper      = [[[0.9,-13.8],[9.9,-3.9],[16.2,-1.2],[22.5,-6],[21,-9.6],[20.7,-12.3],[22.8,-12.9],[26.7,-11.4],[31.2,-7.2],[32.4,-0.9],[24.9,7.8],[12.6,7.8],[0.9,-4.2],[-1.5,-13.8],[-3,-26.7],[-2.1,-31.5],[1.2,-37.8],[7.5,-40.8],[14.1,-41.1],[16.5,-39.3],[15.6,-37.2],[13.5,-36.9],[4.5,-32.7],[0.6,-26.4],[-18,-18.3],[-0.3,-18],[-0.3,-23.1],[-18,-23.1],[-20.4, 30.9],[-20.4, 16.5],[-15.6,8.1],[-11.7,-14.4],[-4.2,-14.1],[-0.6, 7.5],[4.8, 18],[4.2, 31.2],[-6.9,42.9],[-26.7,-3.9],[-33,-1.2],[-39.3,-6],[-37.8,-9.6], [-37.5,-12.3],[-39.6,-12.9],[-43.5,-11.4],[-48,-7.2],[-49.2,-0.9],[-41.7,7.8],[-29.4, 7.8],[-17.7,-4.2],[-15,-14.7],[-18,-14.7],[-18.3,-26.4],[-21.3,-33.3],[-23.7,-34.5],[-27.9,-36.3],[-33.6,-37.2],[-33.6,-40.2],[-30.9,-41.1],[-20.1,-39.9],[-15.3,-33.3],[-13.5,-26.4],[-10.8,-26.4],[-13.2,-42.9],[-3,-42.9],[-6.3,-26.4]],[[0,1,2,3,4,5,6,7,8,9,10,11,12,13],[14,15,16,17,18,19,20,21,22,23],[24,25,26,27],[28,29,30,31,32,33,34,35,36],[37,38,39,40,41,42,43,44,45,46,47,48,49,50],[51,52,53,54,55,56,57,58,59,60],[61,62,63,64]]]; // [draw_polygon:100x100]

/* [Tiling] */
// Set "What to Render" to "preview" or "just_the_wallpaper" to see the effect of changes to the tile pattern
tile_wallpaper         = "yes";           // [yes, no]
// The tiles are layed out on a grid, but this controls the bounding shape
tile_arrangement       = "circular";      // [square, circular]
// For best details, use larger values for scale
tile_scale             = 0.15;            // [0.1:0.01:1]

// Horizontal grid spacing
x_shift_per_column     = 0.35;            // [0:0.05:1]
// Vertical grid spacing
y_shift_per_row        = 0.45;            // [0:0.05:1]

// Vertical column tilt
x_shift_per_row        = 0.09;            // [0:0.05:1]
// Horizontal row tilt
y_shift_per_column     = 0.55;            // [0:0.05:1]

/* [Be Twisted] */

// How do you like your world?
reality                = "straight"; // [straight, twisted]
sconce_twist           = 270;   // [0:720]
sconce_slices          = sconce_twist/10;

arm_sides              =  6;    // [0:40]
// Go ahead, twist my arm!
arm_twist              =  180;     // [0:720]
arm_slices             = arm_twist/10;

/* [Hacks] */
// Set to yes to eliminate support around sconce walls and cutouts
brim                   = "yes";  // [yes, no]

// Half the layer height is used for the brim so that it does not print.
layer_height           = 0.2;
brim_height            = layer_height/2;

/* [Hidden] */
nail_length            = 20;
nail_wall_thickness    = 2;
arm_wall_thickness     = 3.0;
peer_hole_dia          = 3.0;
// How high up should the LED be placed, as a fraction of sconce height. 
led_z_frac             = 0.45;

/* "victorian-wallpaper.scad" adapted from Victorian Background Ornament design by
 * Jakub Jankiewicz (kuba), public domain.
 *
 * Retrieved from:
 *   http://all-free-download.com/free-vector/download/victorian_background_ornament_56243.html
 *
 * Converted using Inkscape and Dan Newman's "Paths to OpenSCAD" plug-in.
 *
 * To generate your own wallpaper:
 *
 *   1) Create an Inkscape document
 *   2) Set the document size to 100 x 100 mm (File -> Document Properties...)
 *   3) Create a design within the document boundary (if auto-tracing a bitmap,
 *       it will vastly speed up rendering time if you simplify the path several
         times).
 *   4) Export to path OpenSCAD file using "Paths to OpenSCAD" plug-in
 *   5) Open generated OpenSCAD file
 *      a) Search and replace all instances of "linear_extrude(height=h)" with ""
 *      b) Wrap all poly_useXXXX calls in a module definition:
 *            module wallpaper() {
 *              ...
 *            }
 *   6) Adjust the "use" statement below if necessary
 *
 * The following loads the external wallpaper that is used when "wallpaper_style" is
 * "external":
 */
 
 use <victorian-wallpaper.scad.txt>

/* Compute the position of the LED. This value will depend on how high up the LED
 * is and how far the emitter is from the LED base.
 */

dia_to_distance       = 0.5 * cos(360/sconce_sides/2);
led_y_on_inside       = led_z_frac * sconce_top_dia    * dia_to_distance +
                    (1-led_z_frac) * sconce_bottom_dia * dia_to_distance - sconce_wall_thickness;
led_z                 = sconce_height * led_z_frac;
led_y                 = led_y_on_inside - emitter_dist_from_base;

/* Compute the maximum size of the shadow that still falls within
 * the sconce's area */

unusable_top = flat_top == "yes" ? 0 : sconce_top_dia/4;

shadow_scale = min(led_z, sconce_height - led_z - unusable_top)
    / (led_y_on_inside*2) * distance_from_wall;

$fn = 40;

/* Compute the parameters related to the arm */

arm_z_on_mount         = (mount_height - arm_dia) * arm_height_on_mount;
arm_rotation           = atan((led_z-arm_z_on_mount)/distance_from_wall);
arm_length             = (distance_from_wall)/cos(arm_rotation) +
    abs(arm_dia/2*tan(arm_rotation));

/* Utility functions */

module symmetry(axis) {
    mirror(axis) {
        children();
    }
    children();
}

/* A rectangle with an identity crisis */
module vary_rect(size=[1,1], variation, corner=0) {
    corner_size = min(size[0],size[1])/2 * min(corner,0.99);
    if(variation == "oval") {
        scale([size[0],size[1]])
            translate([0.5,0.5])
                circle(d=1);
    } else if(variation == "beveled") {
        hull() {
            translate([corner_size,0])
                square(size=[size[0]-corner_size*2,size[1]]);
            translate([0,corner_size])
                square(size=[size[0],size[1]-corner_size*2]);
        }
    } else if(variation == "rounded") {
        translate([corner_size,0])
            square(size=[size[0]-corner_size*2,size[1]]);
        translate([0,corner_size])
            square(size=[size[0],size[1]-corner_size*2]);
        for( dx = [corner_size, size[0]-corner_size],
             dy = [corner_size, size[1]-corner_size])
            translate([dx,dy])
                circle(r=corner_size);
    } else {
        square(size=size);
    }
}

/* Like regular cube, but you can specify centering on an axis by axis basis;
 * you can also give it round corners.
 */
module ccube(size, center=[0,0,0], variation = "flat", roundness=0) {
    translate( [
        center[0] * -size[0]/2,
        center[1] * -size[1]/2, 
        center[2] * -size[2]/2
    ])

    if(variation == "curved_front") {
        scale([size[0],size[1]])
            linear_extrude(size[2])
            translate([0.5,0.5])
                circle(d=1);
        cube(size=[size[0],size[1]/2,size[2]]);
    } else {
        mirror([0,1,0])
            rotate([90,0,0])
                linear_extrude(size[1])
                    vary_rect(
                        size=[size[0],size[2]],
                        variation=variation,
                        corner=mount_corner_size
                    );
    }
}

/* Like a cylinder, but you can specify number of sides and give it a twist */
module ccylinder(h=1, d1=1, d2=1, center=false, sides=40, twist=0, slices=20) {
    if(twist > 0) {
        translate([0, 0, center ? -h/2 : 0])
            linear_extrude(h, scale=d2/d1, twist=twist, slices=slices)
                circle(d=d1,$fn = sides);
    } else {
        cylinder(d1=d1, d2=d2, h=h,center=center,$fn = sides);
    }
}

/* The following modules define a keyhole slot for mounting a nail */
 
module slot() {
	hull() {
        children();
        translate([0,0,nail_wall_thickness])
            children();
    }
    hull() {
        translate([0,0,nail_wall_thickness])
            children();
        translate([0,slot_size,nail_wall_thickness])
            children();
    }
}

module nail_slot(which="all",h=0) {
    if(which=="all") {
        difference() {
            nail_slot("enclosure",h);
            nail_slot("cutout");
        }
    }
    else
    translate([0,-slot_size,0])
    if(which == "cutout") {
        slot()
            translate([0,0,-0.1])
            cylinder(
                d = nail_head_dia + nail_clearance*2,
                h = nail_head_thickness + nail_clearance*2 + 0.1
            );
            
        slot()
            mirror([0,0,1])
            cylinder(
                d = nail_shaft_dia + nail_clearance*2,
                h = nail_head_thickness + nail_length + nail_clearance*2
            );
    } else if (which == "enclosure") {
        enc_h = max(h, nail_head_thickness + nail_wall_thickness*2 + nail_clearance*2);
        hull() {
            cylinder(
                d = nail_head_dia + nail_clearance*2 + nail_wall_thickness*2,
                h = enc_h
            );
            translate([0,slot_size,0])
            cylinder(
                d = nail_head_dia + nail_clearance*2 + nail_wall_thickness*2,
                h = enc_h
            );
        }
    }
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
            bay_width + bay_clearance*2,
            bay_heigth + bay_clearance*2,
            bay_depth + bay_clearance*2],
            center=[1,1,0]
        );
        ccube([
            bay_width/2,
            bay_heigth+4,
            bay_depth + bay_clearance*2],
            center=[1,1,0]
        );
    }
}


module sconce_and_arm() {
    difference() {
        union() {
            ccylinder(
                h=sconce_height,
                d2=sconce_top_dia,
                d1=sconce_bottom_dia,
                sides = sconce_sides,
                twist= (reality == "twisted") ? sconce_twist : 0,
                slices = sconce_slices
            );
            arm_rod();
        }
    
        wire_hole();
    
        // Remove the interior of the sconce
        intersection() {
            ccylinder(
                h=sconce_height+0.1,
                d2=sconce_top_dia-sconce_wall_thickness*2,
                d1=sconce_bottom_dia-sconce_wall_thickness*2,
                sides  = sconce_sides,
                twist  = (reality == "twisted") ? sconce_twist : 0,
                slices = sconce_slices
            );
            translate([-sconce_dia,-sconce_dia,sconce_wall_thickness])
                cube(size=[sconce_dia*2,sconce_dia*2,sconce_height]);
        }
    
        if(flat_top == "no")
            for(a=[0:360/sconce_sides:360])
                rotate([0,0,a + ((reality == "twisted") ? sconce_twist : 0)])
                translate([0, sconce_top_dia/2, sconce_height+sconce_top_dia/8])
                rotate([90,0,0])
                cylinder(h=sconce_top_dia,d=sconce_top_dia/2);
    }
}

module brim() {
    cylinder(h=brim_height, d=sconce_top_dia,$fn=sconce_sides);
    
    // Also eliminate support at the wire guide
    #mount_translation()
        translate([mount_width/2,wire_guide_mm/4,0])
        cube(size=[
                wire_guide_mm,
                wire_guide_mm/2,
                brim_height
             ],center=true);
}

module mount_translation() {
    translate([-mount_width/2,-distance_from_wall+led_y_on_inside,0])
        children();
}

module cube_bezel(size, inset=5, depth=1, shell=0, variation="flat") {
    difference() {
        union() {
            translate([inset,0,inset])
            ccube(size=[
                size[0] - inset*2,
                size[1],
                size[2] - inset*2
            ],variation=variation);
            
            hull() {
                translate([inset,0,inset])
                ccube(size=[
                    size[0] - inset*2,
                    size[1] - depth,
                    size[2] - inset*2
                ],variation=variation);
                
                ccube(size=[
                    size[0],
                    size[1] - depth*2,
                    size[2]
                ],variation=variation);
            }
        }
        
        // If a shell variable is specified, then cut
        // out the interior, leaving the rear open
        
        if(shell) {
            translate([inset+shell,0,inset+shell])
            ccube(size=[
                size[0] - inset*2 - shell*2,
                size[1] - shell,
                size[2] - inset*2 - shell*2
            ],variation=variation);
            
            hull() {
                translate([inset+shell, 0 ,inset+shell])
                ccube(size=[
                    size[0] - inset*2 - shell*2,
                    size[1] - depth + - shell,
                    size[2] - inset*2 - shell*2
                ],variation=variation);
            
                translate([shell, -1,shell])
                ccube(size=[
                        size[0] - shell*2,
                        size[1] - depth*2 - shell + 1,
                        size[2] - shell*2
                ],variation=variation);
            }
        }
    }
}

module mount() {
    difference() {
        mount_translation()
            difference() {
                cube_bezel(size=[
                    mount_width,
                    mount_thickness,
                    mount_height
                 ], variation = mount_style);
            
                // Guide for the wires
                translate([mount_width/2,0,-1])
                rotate([0,0,0])
                cylinder(h=arm_z_on_mount+arm_dia/2,d=wire_guide_mm);
                
                // Keyhole for nail
                from_edge = mount_width*from_edge;
                pos = (use_keyhole == "one") ? [mount_width/2] : [from_edge, mount_width-from_edge];
                for (p = pos) {
                    translate([p,0,mount_height-from_edge])
                        rotate([-90,180,0])
                            nail_slot("cutout");
                }
                
                // Cutout for dc converter
                if(use_bay == "yes") {
                    translate([mount_width/2,-0.2,bay_z_on_mount])
                        rotate([-90,0,0])
                            electronics_bay();
                }
            }
        wire_hole();
    }
}

module arm_transform() {
    translate([0, led_y_on_inside, led_z + arm_dia/2])
        rotate([90+arm_rotation,0,0])
            children();
}

module arm_rod() {
    difference() {
        arm_transform()
            ccylinder(
                h=arm_length,
                d1=arm_dia*(1-arm_taper),
                d2=arm_dia,
                sides= (reality == "twisted") ? arm_sides : 40,
                twist= (reality == "twisted") ? arm_twist : 0,
                slices=arm_slices
            );
    
        mount_translation()
        translate([0,-mount_thickness*2,0])
        cube(size=[
                mount_width,
                mount_thickness*3,
                mount_height
        ]);
    }
}

module wire_hole() {
    arm_transform()
        ccylinder(
            h=arm_length + 0.1,
            d1=arm_dia*(1-arm_taper) - arm_wall_thickness*2,
            d2=arm_dia               - arm_wall_thickness*2,
            sides= (reality == "twisted") ? arm_sides : 40,
            twist= (reality == "twisted") ? arm_twist : 0,
            slices=arm_slices
        );
}

/* Shadow surface definitions. Modify desired_shadow to choose which */

/* The shadow surface should be defined within a unit
   square x, y = [ -1 : 1 ]
 */

/* Custom shadow imported from a SVG path          
 */

module external_shadow_definition() {
    scale([1/50,1/50])
        wallpaper();
}

module default_shadow_definition() {
    scale([1/50,1/50])
        polygon(points = default_wallpaper[0], paths = default_wallpaper[1]);
}

module polka_dot_shadow_definition() {
    scale([1/50,1/50])
        circle(d = 100);
}

module desired_shadow() {
    tile_shadow()
    mirror([1,0,0])
        if(wallpaper_style == "polka-dot") {
            polka_dot_shadow_definition();
        } else if(wallpaper_style == "external-file") {
            external_shadow_definition();
        } else if(wallpaper_style == "default") {
            default_shadow_definition();
        }
}

/* Custom shadow imported from a SVG path          
 */

function tile_within_bounds(x,y) =
    (tile_arrangement == "square"   && x >= -1 && x <= 1 && y >= -1 && y <= 1) ||
    (tile_arrangement == "circular" && sqrt(x*x + y*y) <= 1)
;

module tile_shadow() {
    if(tile_wallpaper == "no") {
        children();
    } else {
        for( tile_x = [-10:10], tile_y = [-10:10] ) {
            dx = 2*tile_scale * (tile_x * (x_shift_per_column+1) + tile_y * (x_shift_per_row));
            dy = 2*tile_scale * (tile_x * (y_shift_per_column)   + tile_y * (y_shift_per_row+1));
            
            if( tile_within_bounds(dx,dy) )
                translate([ dx, dy, 0])
                    scale([tile_scale,tile_scale])
                        children();
        }
    }
}

/* End of shadow surface definitions */

module shadow_center() {
    translate([0,led_y,led_z])
        sphere(r=1);
}

/* A small hole on the sconce indicates the position where the LED
 * needs to be mounted
 */
module shadow_center_hole() {
    translate([0,led_y_on_inside + sconce_wall_thickness/2,led_z])
    rotate([90,0,0])
        cylinder(d=peer_hole_dia, h=sconce_wall_thickness*1.2, center=true);
}

/* Extrudes the wallpaper outline to a single point coinciding with the
 * emitter of the LED lamp */
module project_shadow(what_to_render) {
    translate([0,led_y,led_z])
        rotate([90,0,0])
            translate([0,0,distance_from_wall])
                mirror([0,0,1])
                    if(what_to_render == "preview") {
                        linear_extrude(0.1)
                            scale([shadow_scale,shadow_scale])
                                children();
                    } else {
                        linear_extrude(distance_from_wall, scale=0.001)
                            scale([shadow_scale,shadow_scale])
                                children();
                    }
}

/* Cut out the outline of the mount from the shadow so no light falls on it */
module cut_mount_from_shadow() {
    difference() {
        desired_shadow();
        
        translate([ -mount_width/shadow_scale/2, -led_z/shadow_scale])
            vary_rect(
                size=[mount_width/shadow_scale,mount_height/shadow_scale],
                variation=mount_style,
                corner=mount_corner_size
            );
    }
}

/* Extruded object which when subtracted from the sconce causes the LED
 * to cast the desired illumination pattern.
 */
module ray_volume() {
    project_shadow(what_to_render)
        cut_mount_from_shadow();
}

/* The entire sconce, with ray volume subtracted */
module sconce() {
    difference() {
        sconce_and_arm();
        ray_volume();
        shadow_center_hole();
    }
    mount();
    
    /* Drawing a brim keeps Cura from trying to build support on the external walls */
    
    if(what_to_render == "printable_object" && brim == "yes")
        brim();
}

if(what_to_render == "preview") {
    sconce();
    shadow_center();
    
    #project_shadow(what_to_render = "preview")
        cut_mount_from_shadow();
}
else if(what_to_render == "preview_with_rays") {
    sconce();
    shadow_center();
    
    #ray_volume();
}
else if(what_to_render == "just_the_wallpaper") {
    #project_shadow(what_to_render = "preview")
        cut_mount_from_shadow();
}
else if(what_to_render == "printable_object") {
    sconce();
    
    //ccube(size=[100,200,10], center=[0,0,0], roundness=0);
    //#ccube(size=[100,200,10], center=[0,0,0], roundness=10);
}

//round_rect(size=[100,200], roundedness=1);