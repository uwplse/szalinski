length=150; // [50:150]
diameter=10; // [5:100]
// Horizontal clearance
clearance=0;
base_thickness=6; // [2:10]
wall_thickness=2; // [2:10]
notch_distance=40; // [20:40]
notch_width=2; // [2:5]
miter_height=3; // [2:5]
miter_width=10; // [5:10]

// Mount screw diameter, set to 0 to disable screw recesses.
screw_diameter=4.5;
screw_head_diameter=9.5;
screw_head_height=3;


/* [Hidden] */

half_clearance=clearance / 2;
height=base_thickness + diameter;
width=diameter + clearance + wall_thickness * 2;
screw_head_radius=screw_head_diameter/2;
screw_radius=screw_diameter/2;
max_cutout_size=diameter + miter_height + 1;

module cylinder_outer(height,radius,fn=60){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);}

difference() {
    union() {
        // main rectangle
        cube([length, width, height]);
        ridge_length=20 + notch_width;
        // the V rise around the notch
        translate([notch_distance - (miter_width), width, 0]) rotate([90, 0, 0]) linear_extrude(width) polygon([
                [0, 0],
                [0, height],
                [miter_width, height + miter_height],
                [miter_width + notch_width, height + miter_height],
                [miter_width * 2 + notch_width, height],
                [miter_width * 2 + notch_width, 0],
            ]);
    }
    // top retangular channel
    translate([0, wall_thickness, base_thickness + diameter * 0.5]) cube([length, diameter + clearance, 50]);

    // V channel that rod sits in
    translate([0, wall_thickness, base_thickness + diameter * 0.5]) rotate([90,0,0]) rotate([0,90,0]) linear_extrude(length) polygon([
    [0,1],
    [0,0],
    [diameter * 0.5 + half_clearance, -diameter * 0.5],
    [diameter + clearance, 0],
    [diameter + clearance, 1]
    ]);
    
    // notch
    translate([notch_distance, 0, base_thickness - 1]) cube([notch_width, width, max_cutout_size]);
    // screw holes
    if(screw_diameter) {
        for(x_offset=[10, length/2, length-10]) {
            translate([x_offset, width / 2, 0]) {
                union() {
                    translate([0,0,base_thickness-screw_head_height + 0]) cylinder_outer(screw_head_height + max_cutout_size, screw_head_radius);
                    cylinder_outer(base_thickness, screw_radius);
                }
            }
        }
    }
}
