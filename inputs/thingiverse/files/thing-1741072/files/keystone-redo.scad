/*
 *  This is a cleaned up version of the keystone mounting jack by
 *  jsadusk on thingiverse.com.  I've changed it so you can make
 *  keystone patch panels with an arbitrary number of rows and columns.
 *
 *  I've also added some optional mounting brackets that will fit M5 
 *  screws.
 * 
 *  Shawn Wilson
 *  Aug 27, 2016
 */
 
/****************
 * Modify the settings below accordingly.  
 * 
 * For example, the following values will make a 16 port patch panel 
 * that can be mounted in a standard 19in rack:
 *
 *  num_jacks = 16;
 *  num_rows = 1;
 *  wall_thickness_x = 6.5625;
 *  wall_thickness_y = 6.5625;
 *  mounting_brackets = true;
 *
 ****************/

// Number of columns 
num_jacks = 4;
// Number of rows
num_rows = 2;

// Pad the height of each row (mm).  Industry standard is 6.5625.
height_padding = 6.5625;  

// Pad the spacing between each jack (mm).  Industry standard is 6.5625.
width_padding = 6.5625;

// Specify if you want mounting holes on the sides.
mounting_brackets = true ;

// in mm
mount_hole_diameter = 5.5;

/* 
 *  The soffits are the overhangs that make the front of the faceplate
 *  look pretty.  However, leaving the soffits off can make it easier to
 *  pop the jack out from the front with a screwdriver.
 */
top_soffit = true;
bottom_soffit = true;
/***************/


/* [hidden] */
wall_thickness_x = height_padding;
wall_thickness_y = width_padding;

wall_height = 10;
jack_length = 20.5;
jack_width = 15;
bracket_width = 15;

catch_overhang = 2;
small_clip_depth = catch_overhang;
big_clip_depth = catch_overhang + 2;
big_clip_clearance = 1.7;
small_clip_clearance = 6.5;

outer_length = jack_length + big_clip_depth +
                            (wall_thickness_x * 2);
outer_width = jack_width + (wall_thickness_y * 2);
;
total_outer_length = outer_length * num_rows;
total_outer_width = outer_width * num_jacks;
mount_hole_distance = (outer_width * num_jacks) + bracket_width;

echo ("-----------------");
echo ("jack width:", outer_width, "jack length:", outer_length);
echo ("total width:", total_outer_width, "total length", total_outer_length);
echo ("distance between mounting holes:", mount_hole_distance);
echo ("-----------------");

/*
 *  This is the overhang that hides the clips so you can't see
 *  them from the front. 
 */
module clip_soffit(overhang = 2) {
  rotate([90, 0, 0]) {
    linear_extrude(height = outer_width) {
      polygon(points = [[0,0],
                        [overhang, 0],
                        [2 + overhang, 2],
                        [0,2]],
              paths = [[0,1,2,3]]);
    }
  }
}


/* 
 *  This draws a single keystone module. 
 */
module keystone() {
    union() {
    
        difference() {
          difference() {
            cube([outer_length, outer_width, wall_height]);
            translate([wall_thickness_x, wall_thickness_y, big_clip_clearance]) {
              cube([outer_length, jack_width, wall_height]);
            }
          }
          translate([wall_thickness_x + small_clip_depth, wall_thickness_y, 0]){
            cube([jack_length, jack_width, wall_height + 1]);
          }
        }
    
        cube([wall_thickness_x, outer_width, wall_height]);
        translate([outer_length - wall_thickness_x,0,0]) {
          cube([wall_thickness_x, outer_width, wall_height]);
        }

        /* Draw the soffits if requested. */
        if (bottom_soffit) {
            translate([wall_thickness_x, outer_width, wall_height - 2]) {
              clip_soffit(overhang = 0);
            }
        }
        if (top_soffit) {
            translate([outer_length - wall_thickness_x, 0, wall_height - 2]) {
              rotate([0, 0, -180]) {
                clip_soffit(overhang = 4);
              }
            }
        }
    }
}




union() {
    /* Draw the patch panel. */
    for (j = [0 : num_rows - 1] ) {
        for (i = [0 : num_jacks - 1] ) {
            translate([j * outer_length, i * outer_width, 0]) keystone();
        }
        
        /* Add some mounting brackets if requested. */
        if (mounting_brackets) {           
            difference() {
                translate([j * outer_length, -1 * bracket_width, 0]) 
                    cube([outer_length, bracket_width, wall_height]);
                translate([(j * outer_length) + (outer_length / 2),
                           -1 * bracket_width / 2, 
                           0])
                    cylinder(r = mount_hole_diameter / 2, 
                             h = wall_height, 
                             $fn = 100);
            }
            difference() {
                translate([j * outer_length, outer_width * num_jacks, 0]) 
                    cube([outer_length, bracket_width, wall_height]);
                translate([(j * outer_length) + (outer_length / 2), 
                             (num_jacks * outer_width) + (bracket_width) / 2, 
                           0])
                    cylinder(r = mount_hole_diameter / 2,
                             h = wall_height, 
                             $fn = 100);
            }
        }
    }
 }