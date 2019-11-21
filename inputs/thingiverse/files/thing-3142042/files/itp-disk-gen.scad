// Ikea led torch pinhole projector disk generator
// 2018/10/07
// Author: crashdebug
// Thingiverse link: https://www.thingiverse.com/thing:3142042
// Licensed under the Creative Commons - Attribution - Non-Commercial - 
// Share Alike license. 
//


// Maximum 100x100 image, should be white on black for best results
image_file = "image-surface.dat"; // [image_surface:100x100]
//image_file = "KnightHead.png";
//image_file = "snail_small_linear.png";

image_width = 20; // [1:30]
image_height = 20; // [1:30]

/* [Advanced] */

// set to true to check alignment of image with disk
debug_view = "false"; // [true, false]

// moves the image surface up/down
image_z_offset = -5; // [-20:20]
// adjusts the depth of the image surface
image_z_depth = 20;    // [1:20]

// customizer generates the surface in a strange way, default offset
// should be -15 when not using customizer.

// importing stl is not possible in thingiverse customizer
// import("disk_blank.stl", convexity=3);
module disk_blank()
{
    union() {
        cylinder(r1=14.9, r2=14.9, h=1, $fn=32);
        translate([0,0,1])
            cylinder(r1=14.9, r2=13.5, h=0.5, $fn=32);
        translate([0,0,1.5])
            cylinder(r1=13.5, r2=13.5, h=0.5, $fn=32);
        translate([20,0,0])
            cylinder(r1=5, r2=5, h=1, $fn=32);
        translate([10,-5,0])
            cube([10,10,1]);
    }
}

module image_surface_positioned()
{
    translate([0,0,image_z_offset])
            resize(newsize=[image_width,image_height,image_z_depth])
                surface(file = image_file, center = true);
}

module generate_disk()
{
    if ( debug_view == "false" ) {
        difference() {
            disk_blank();
            image_surface_positioned();
        }
    } else {
        union() {
            disk_blank();
            image_surface_positioned();
        }
    }
}

generate_disk();
