/* Customizable vase mode box
 * By DrLex, v1.0 2019/07
 * Released under Creative Commons - Attribution - Share Alike license */

/* [General] */
// What model to generate. When using ‘both’, don't forget to split into two parts before starting vase mode prints.
render = "both"; //[box, lid, both]

/* [Dimensions] */
// Inner width of the box. All dimensions are mm.
width = 50.0; //[1:0.1:250]

// Inner depth of the box.
depth = 25.0; //[1:0.1:250]

// Inner height of the box.
height = 70.0; //[1:0.1:250]

// Overlap of the lid when placed on the box.
lid = 25.0; //[1:0.1:50]

// Total extra gap between the box and lid.
tolerance = 0.1; //[0:0.01:1]

// Wall thickness of the box. You must set wall thickness for vase mode in your slicer program to this same value when printing, and also set number of bottom layers such that vase mode starts above this height.
wall = 0.60; //[0.2:0.01:2]

/* [Shape] */
// Box shape
shape = "rectangle"; //[rectangle, cylinder]

// Number of segments for the cylinder shape
cylinder_segments = 64; //[3:128]

/* [Hidden] */
box_width = width + 2 * wall;
box_depth = depth + 2 * wall;
box_height = height + wall;
lid_width = box_width + tolerance + 2 * wall;
lid_depth = box_depth + tolerance + 2 * wall;
lid_height = lid + wall;
ridge_h = 0.8;
ridge_a = 30;  // angle of the ridge
ridge_r = tan(ridge_a) * ridge_h;  // cone radius needed to obtain angle

if(shape == "rectangle") {
    shift_box = render == "both" ? -(box_depth + 6) : -box_depth/2;
    shift_lid = render == "both" ? 6 : -lid_depth/2;

    if(render == "box" || render == "both") {
        translate([-box_width/2, shift_box, 0]) cube([box_width, box_depth, box_height]);
    }

    if(render == "lid" || render == "both") {
        translate([-lid_width/2, shift_lid, 0]) {
            cube([lid_width, lid_depth, lid_height]);
            translate([0, 0, lid_height]) hull() {
                cylinder(ridge_h, 0, ridge_r, $fn=4);
                translate([lid_width, 0, 0]) cylinder(ridge_h, 0, ridge_r, $fn=4);
                translate([lid_width, lid_depth, 0]) cylinder(ridge_h, 0, ridge_r, $fn=4);
                translate([0, lid_depth, 0]) cylinder(ridge_h, 0, ridge_r, $fn=4);
            }
        }
    }
}
else {
    shift_box = render == "both" ? -(box_depth/2 + 6) : 0;
    shift_lid = render == "both" ? lid_depth/2 + 6 : 0;

    if(render == "box" || render == "both") {
        scale_y_b = box_depth / box_width;
        translate([0, shift_box, 0]) scale([1, scale_y_b, 1]) cylinder(box_height, box_width/2, box_width/2, $fn=cylinder_segments);
    }

    if(render == "lid" || render == "both") {
        scale_y_l = lid_depth / lid_width;
        translate([0, shift_lid, 0]) {
            scale([1, scale_y_l, 1]) {
                cylinder(lid_height, lid_width/2, lid_width/2, $fn=cylinder_segments);
            }
            // unfortunately hull cannot make a 3D shape out of two 2D circles, so make a 3D contraption instead
            translate([0, 0, lid_height]) scale([1, scale_y_l, 1]) hull() {
                cylinder(ridge_h/2, lid_width/2, lid_width/2, $fn=cylinder_segments);
                undo_scale = (lid_width/2 * scale_y_l + ridge_r) / (scale_y_l * (lid_width/2 + ridge_r));
                scale([1, undo_scale, 1]) cylinder(ridge_h, 0, lid_width/2 + ridge_r, $fn=cylinder_segments);
            }
        }
    }
}
