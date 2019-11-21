$fn = 100; // upgrade resolution
fillet_r = 1; // radius of the rounded fillet at the base of the knob.
min_r = 16; // narrow (bottom) radius of the knob.
max_r = 16; // wide (top) radius of the knob.
base_h = 6.4; // total height of the knob base.
cyl_h = base_h - fillet_r; // calculated height of the non-fillet portion of the base.
shaft_r = 5; // outer shaft radius.
shaft_h = 12; // shaft height.
shaft_in_r = 3.2; // inner shaft radius.
shaft_in_min_wid = 5; // width from shaft flat to edge of shaft inner radius.
key_th = 1.625; // thickness of shaft key.
key_wid = 3.183; // width of shaft key from shaft outer radius to end of key.
BIG = 50; // number that is large compared to dimensions of the knob.
dt = 0.1; // fudge factor to ensure overlaps.
rim_h = 2; // rim height above knob
rim_maxr = 18.5; // rim outer radius
rim_minr = 14; // rim inner radius

// handle
translate([-min_r+2,-3,-2])
difference() {
    cube([(min_r*2)-4,6,2],center=false);
    translate([-1,2,-1])
        cube([min_r/2,2,2],center=false);
}

// knob
difference() {
    union() {
        hull() {
            rotate_extrude() {
                translate([min_r-fillet_r, 0])
                    circle(r = fillet_r);
            }
            cylinder(r1=min_r,r2=max_r,h=cyl_h,center=false);
        }

        // rim
        translate([0,0,cyl_h])
            cylinder(r=rim_maxr,h=rim_h,center=false);
    }

    // hole through everything
    translate([0,0,rim_h+1*dt])
        cylinder(r=rim_minr-2*dt,h=cyl_h+2*dt,center=false);
}

// shaft
difference() {
    cylinder(r=shaft_r,h=shaft_h+cyl_h,center=false);

    difference() {
        cylinder(r=shaft_in_r,h=shaft_h+cyl_h+2*dt,center=false);
        translate([shaft_in_min_wid-shaft_in_r,-BIG/2,-BIG/2])
            cube([BIG,BIG,BIG],center=false);
    }
}

// key
translate([shaft_r-dt,-key_th/2,0])
    cube([key_wid,key_th,shaft_h+cyl_h],center=false);
