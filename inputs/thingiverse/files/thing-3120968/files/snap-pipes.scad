// ################################################################################
// SnapPipes: A connector for two cylindrical pipes
//
// https://www.thingiverse.com/thing:3120968
// written by @na0tta (https://twitter.com/na0tta)
//
// Released under the Creative Commons - Attribution - Non-Commercial
// ################################################################################

// --------------------------------------------------------------------------------
// Parameters [unit of measure: millimeter (mm)]
// --------------------------------------------------------------------------------
// resosution
$fn = 128;

// 1st pipe (+X)
r1 = 48.6/2;
thickness1 = 3.2;

// 2nd pipe (-X)
r2 = 66.8/2;
thickness2 = 3.2;

// common params
height = 25.0;
rod_thickness = 10;
rod_length = 10.0;
open_angle = 90;  // [80,100] might work well (180< produces weird shape)


// --------------------------------------------------------------------------------
// Entry point
// --------------------------------------------------------------------------------
main();


// --------------------------------------------------------------------------------
// Modules
// --------------------------------------------------------------------------------
module main() {
    snap_pipe_with_rod(r1, height, thickness1, open_angle, rod_length/2, rod_thickness);
    mirror([1,0,0])
        snap_pipe_with_rod(r2, height, thickness2, open_angle, rod_length/2, rod_thickness);
}


module snap_pipe_with_rod(r, h, thickness, open_angle, rod_length, rod_thickness) {
    union() {
        translate([r+thickness+rod_length,0,0])
        snap_pipe(r, h, thickness, open_angle);
        
        difference() {
            rod_length2 = rod_length + r;
            translate([rod_length2/2,0,0])
                cube(size=[rod_length2, rod_thickness, h], center=true);
            
            offset = h*0.001;
            translate([r+thickness+rod_length,0,0])
                cylinder(h=h+offset, r=r, center=true);
        }
    }
}


module snap_pipe(r, h, thickness, open_angle) {
    union() {
        // C-shape
        difference() {
            torus(r+thickness, r, h);
        
            d = (r+thickness)*1.5;
            x = d * cos(open_angle/2);
            y = d * sin(open_angle/2);
            linear_extrude(height=h*2, center=true, convexity=10, twist=0)
                polygon([[0,0], [x,y], [x,-y]]);
            
            eps = r*0.0001;
            translate([x+r-eps,0,0])
                cube(size=[r*2, y*2, h*2], center=true);
        }
        
        // create circled ends
        offset = thickness/5; // locate circled-ends little bit outer
        d = r + thickness/2 + offset;
        x = d * cos(open_angle/2);
        y = d * sin(open_angle/2);
        translate([x,y,0])
            cylinder(h=h, r=thickness, center=true);
        translate([x,-y,0])
            cylinder(h=h, r=thickness, center=true);
    }
}


module torus(outer_r, inner_r, h) {
    offset = h*0.001;
    difference() {
        cylinder(h=h, r=outer_r, center=true);
        cylinder(h=h+offset, r=inner_r, center=true);
    }
}
