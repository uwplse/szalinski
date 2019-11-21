/**
 * SSD DRIVE BAY ADAPTER
 * by 5hwb
 * 2018-08-12
 */

$fn=60;

// Thickness of main frame
frame_z = 3;

// Thickness of sides
side_z = 10;

// Width of frame elements
stick_w = 6;

// Diameter of side screw holes
screw_x = 2.9;

// Diamater of SSD screw holes
screw_z = 3;

// Width of drive bay
bay_x = 101.6;

// Height of side screw holes
bay_s_x = 6.35;

// Length of gap between side screw holes
bay_s_y = 60;

// Width of gap between SSD screw holes
ssd_s_x = 61.71;

// Length of gap between SSD screw holes
ssd_s_y = 76.6;

gap = (bay_x-ssd_s_x)/2 - stick_w/2;

//translate([0,0,3]) cube([69.85,100.45,7]);
//%translate([-gap-stick_w/2,0,0]) cube([bay_x,5,20]);

difference() {
    // MAIN SHAPE
    union() {
        // SSD cross
        stick(0,0,ssd_s_x,ssd_s_y);
        stick(0,ssd_s_y,ssd_s_x,0);
        
        // Left arms
        stick(-gap,0,-gap,bay_s_y, side_z);
        stick(0,0,-gap,0);
        stick(0,ssd_s_y,-gap,bay_s_y);
        
        // Right arms
        stick(ssd_s_x+gap,0,ssd_s_x+gap,bay_s_y, side_z);
        stick(ssd_s_x,0,ssd_s_x+gap,0);
        stick(ssd_s_x,ssd_s_y,ssd_s_x+gap,bay_s_y);
        
    }
    
    // SSD SCREW HOLES
    translate([0,0,-frame_z/2])
        cylinder(r=screw_z/2, h = frame_z*2);
    translate([ssd_s_x,0,-frame_z/2])
        cylinder(r=screw_z/2, h = frame_z*2);
    translate([0,ssd_s_y,-frame_z/2])
        cylinder(r=screw_z/2, h = frame_z*2);
    translate([ssd_s_x,ssd_s_y,-frame_z/2])
        cylinder(r=screw_z/2, h = frame_z*2);
    
    // DRIVE BAY SCREW HOLES
    translate([-gap-stick_w,0,bay_s_x]) rotate([0,90,0])
        cylinder(r=screw_x/2, h=stick_w*2);
    translate([-gap-stick_w,bay_s_y,bay_s_x]) rotate([0,90,0])
        cylinder(r=screw_x/2, h=stick_w*2);
    
    translate([ssd_s_x+gap-stick_w,0,bay_s_x]) rotate([0,90,0])
        cylinder(r=screw_x/2, h=stick_w*2);
    translate([ssd_s_x+gap-stick_w,bay_s_y,bay_s_x]) rotate([0,90,0])
        cylinder(r=screw_x/2, h=stick_w*2);
}

module stick(x1, y1, x2, y2, z=frame_z) {
    hull() {
        translate([x1,y1,0]) cylinder(r=stick_w/2, h=z);
        translate([x2,y2,0]) cylinder(r=stick_w/2, h=z);
    }
}

