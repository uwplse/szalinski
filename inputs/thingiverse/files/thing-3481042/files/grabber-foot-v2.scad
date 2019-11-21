
// Constant/Utility
inch_from_mm = 25.4; // we assume units are mm below
function polyRad(innerRad, fn) = innerRad/cos(180/fn);
function aPolyRad(outerRad, fn) = outerRad*tan(180/fn);

// Printer variables
mm = 1.033898305084746; // Account for 1 unit not quite being mm
zmm = 1;
extrude_width = 0.5*mm;
clearance = 0.3*mm;

// Measurements
s_thick = 0.2*zmm; // thickness of small
l_thick = 0.9*zmm; // thickness of large
lw = 12.3*mm;     // width of large
sw =  8.8*mm;     // width of small
so = 3.7*mm;      // to end of small
lo = 6.7*mm;      // to end of large
hole_diam = 4*mm-clearance;

// Dimensions
hole_fn = 6;

foot_width = 30*mm;
foot_height = 40*mm;
foot_thick = 7.4*zmm;

groove_depth = 1.5*zmm;
groove_width = 3*mm;
groove_space = 2*mm;
groove_shape = 1; // 1 = square, 2 = v-shape

clip_give = 0.3*hole_diam;
clip_width = 2*hole_diam;
clip_inset = 1*zmm;
clip_top = clip_inset+0.6*zmm;
clip_thru = s_thick+l_thick+clearance;
clip_height = clip_top+4*zmm;
clip_fn = 20;

bracket_length = 12.1*mm;
bracket_width = extrude_width*2;

snap_rad = extrude_width;

module clip_slot() {
    translate([foot_width/2-lw/2-clearance,
               foot_height/2
                    +polyRad(lw/2,20)
                    -lo
                    -hole_diam
                    -2*clearance,
               0]) {
        cube([lw+2*clearance,
              clip_width+2*clearance,
              clip_inset]);
    }
    
}

// Model
module foot() {
    difference() {
        // Chasis
        cube([foot_width,foot_height,foot_thick]);
        // Ribs
        for (i = [0
                 :groove_width+groove_space
                 :foot_height]
            ) {
            translate([0,i,foot_thick])
            rotate([0,90,0])
            linear_extrude(height=foot_width)
            if (groove_shape == 2) {
                polygon(points=[
                    [0,0],
                    [groove_depth,groove_width/2],
                    [0,groove_width]]
                );
            } else {
                square([groove_depth,groove_width]);
            }
        }
        // Opening for attachment
        translate([foot_width/2,foot_height/2,0]) {
            // rounded end
            cylinder(h=clip_thru+clip_top,
                     r=polyRad(lw/2,20)+clearance, 
                     $fn=20);
            // bulk of it
            translate([-(lw+clearance)/2,
                       -(foot_height+clearance)/2,
                       0])
            cube([lw+clearance,
                  (foot_height+clearance)/2,
                  clip_thru+clip_top]);
            // space for snap mount to flex
            translate([0,
                       polyRad(lw/2,20)+clearance
                           -lo
                           -hole_diam/2-clearance,
                       clip_top+clip_thru])
            cylinder(h=clip_height-clip_top-clip_thru,
                     r=polyRad(hole_diam/2+clearance,
                               hole_fn)
                        +4*extrude_width,
                     $fn=hole_fn);
        }
        
        clip_slot();
    }
    
    // clip snap mount
    translate([foot_width/2,
               foot_height/2
                    +polyRad(lw/2,20)+clearance
                    -lo-hole_diam/2-clearance,
               clip_top+clip_thru])
    difference() {
        cylinder(h=clip_height-clip_thru-clip_top,
                 r=polyRad(hole_diam/2+clearance,
                           hole_fn)
                        +extrude_width,
                 $fn=hole_fn);
        cylinder(h=clip_height-clip_top-clip_thru,
                 r=polyRad(hole_diam/2+clearance,                       hole_fn),
                 $fn=hole_fn);
    }
    
    // snap
    translate([foot_width/2
                    -tan(180/hole_fn)
                    *(hole_diam/2+clearance),
               foot_height/2
                    +polyRad(lw/2,20)+clearance
                    -lo
                    -hole_diam/2-clearance,
               clip_top+clip_thru+snap_rad]) {
        // One side...
        translate([0,
                   hole_diam/2+clearance,
                   0])
        rotate([0,90,0])
        cylinder(h=2*tan(180/hole_fn)*
                   (hole_diam/2+clearance),
                 r=snap_rad,
                 $fn=20);
        // ... and the other.
        translate([0,
                   -hole_diam/2-clearance,
                   0])
        rotate([0,90,0])
        cylinder(h=2*tan(180/hole_fn)*
                   (hole_diam/2+clearance),
                 r=snap_rad,
                 $fn=20);
    }
    
    // bracket
    difference() {
        translate([foot_width/2,
                   foot_height/2
                        +polyRad(lw/2,20)
                        +clearance
                        -bracket_length,
                   0])
        union() {
            // One side
            translate([lw/2
                       -bracket_width
                       +clearance,0,0])
            cube([bracket_width+2,
                  bracket_length,
                  clip_top]);
            // Other side
            translate([-lw/2-clearance-2,0,0])
            cube([bracket_width+2,
                  bracket_length,
                  clip_top]);
        }
        clip_slot();
    }
}
module clip() {
    translate([-lw/2,
               -hole_diam/2,
               0])
    cube([lw,
          clip_width,
          clip_inset]);
//    cylinder(h=clip_inset, r=clip_rad, $fn=clip_fn);
    difference() {
        cylinder(h=clip_height-(snap_rad+clearance)*2,
                 r=hole_diam/2,
                 $fn=30);
        translate([0,0,clip_top+clip_thru+snap_rad])
        rotate_extrude(convexity=10)
        translate([hole_diam/2,0,0])
        circle(r=snap_rad+clearance, $fn=20);
    }
    translate([0,0,
               clip_height-(snap_rad+clearance)*2])
    cylinder(h=(snap_rad+clearance)*2,
             r1=hole_diam/2,
             r2=hole_diam/2-snap_rad,
             $fn=30);
}

// actually produce one (could have more)
translate([0,0,foot_thick])
rotate([180,0,0])
foot();

translate([-3,-lw/2-clearance*2,0])
rotate([0,0,90])
clip();
