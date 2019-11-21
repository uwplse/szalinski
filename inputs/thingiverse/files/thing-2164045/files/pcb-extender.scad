/* https://www.thingiverse.com/thing:2164045 */
// preview[view:south west, tilt:top diagonal]

// Add prongs to the bottom of the mount for additional stability
use_prongs = "yes"; // [yes:Yes, no:No]

// X-offset of the mount
offset_x = 30;
// Y-offset of the mount
offset_y = 0;
// Z-offset of the mount
offset_z = 30;

// Arm height
arm_height = 20;
// Arm width
arm_width = 10;

// Make M4 holes a bit larger, added to the diameter
m4_hole_adjustment = 0.5;

/* [Hidden] */

alu_w = 20.0;
alu_m = 6.2; // The middle groove of the 2020 extrusion
alu_side_w = (alu_w - alu_m) / 2;

base_w = alu_w * 2;
base_l = 131.5; // TEVO Tarantula i3
base_h =  4.5;

arm_y_margin = 20;

m4_d = 4.0 + m4_hole_adjustment;

extender();

module plate() {
    difference() {
        linear_extrude(height=base_h) rounded_square([base_w, base_l], 5, $fn=24);
        
        hm = alu_side_w + alu_m/2;
        ox = hm;
        oy = 10;
        translate([ox,oy,-1]) cylinder(d=m4_d, h=base_h+2, $fn=12);
        translate([base_w-ox,oy,-1]) cylinder(d=m4_d, h=base_h+2, $fn=12);
        
        translate([ox,base_l-oy,-1]) cylinder(d=m4_d, h=base_h+2, $fn=12);
        translate([base_w-ox,base_l-oy,-1]) cylinder(d=m4_d, h=base_h+2, $fn=12);
    }
}

module extender() {
    plate(); // Base
    
    // Prongs
    if (use_prongs == "yes") {
        translate([0, (base_l)/2, -alu_m]) {
            prongs();
        }
    }
    
    // Bottom right
    translate([base_w-10, arm_y_margin, base_h])
        arm();
    // Bottom left
    translate([0, arm_y_margin, base_h])
        arm();
    
    // Top right
    translate([base_w-10-1, base_l-arm_height-arm_y_margin, base_h])
        arm();
    // Top left
    translate([0, base_l-arm_height-arm_y_margin, base_h])
        arm();
    
    // Top plate
    translate([offset_x, offset_y, offset_z + base_h]) 
        plate();
}

module arm() {
    hull() {
        translate([0, 0, 0]) cube([arm_width, arm_height, 0.001]);
        translate([offset_x, offset_y, offset_z]) 
            cube([arm_width, arm_height, 0.001]);
    }
}
module prongs() {
    module pair() {
        p_w = alu_m - 0.4; // Width of a prong
        p_h = 20; // Height
        translate([alu_side_w, 0])
            cube([p_w, p_h, alu_m]);
        
        translate([base_w-alu_side_w-p_w, 0])
            cube([p_w, p_h, alu_m]);
    }
    translate([0,15]) pair();
    mirror([0,1,0]) translate([0,15]) pair();
}

/* Utils */
module rounded_square(size, radius=6, center=false) {
    w = size[0];
    h = size[1];
    
    gx = center ? 0 : w/2;
    gy = center ? 0 : h/2;
    
    hw = w/2;
    hh = h/2;
    hull()
    {
        // place 4 circles in the corners, with the given radius
        translate([gx-hw+radius, gy+hh-radius, 0]) // TL
            circle(r=radius);
        
        translate([gx+hw-radius, gy+hh-radius, 0]) // TR
            circle(r=radius);
        
        translate([gx+hw-radius, gy-hh+radius, 0]) // BR
            circle(r=radius);
        
        translate([gx-hw+radius, gy-hh+radius, 0]) // BL
            circle(r=radius);
    }
}