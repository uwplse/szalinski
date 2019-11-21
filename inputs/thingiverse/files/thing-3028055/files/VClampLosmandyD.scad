//////////////////////////////////////////////////////
// Vixen-style dovetail clamp
//
// Designed for attached relatively light-weight 
// equipment, like a finder or guide scope, to a
// Vixen-style dovetail plate.  
//
// The length of the clamp is set by the clamp_length
// parameter.  Counterbored screw holes for equipment
// attachment are specified in the screw_holes[] 
// vector.  
// 
// The various holes are sized for US #8 machine screw 
// hardware.  The holes are intended to be snug to 
// minimize free play. 
//
// This design should be adaptable to Losmandy-style 
// plates by suitably modifying the dovetail bar
// parameters.
//////////////////////////////////////////////////////
// (c) 2018 Les Niles
// This design is licensed under the Creative Commons 
// Attribution license http://creativecommons.org/licenses/by/4.0/

// Dimension parameters
mm = 1.0;
inches = 25.4*mm;

clamp_length = 2.5*inches; // Overall length of the dovetail clamp to print

// The following is an array of screw hole locations. A counterbored screw hole will be  
// created at each location. Each item in the array is an x,y pair, where x is the
// distance from one end of the clamp and y is the distance from the centerline.
screw_holes = [[0.33*inches, 0], [clamp_length-0.33*inches, 0], [clamp_length/2, 0.4*inches], 
                [clamp_length/2, -0.4*inches]];

// #8 machine screw hardware
screw_dia = 0.175*inches; // Sets diameter of screw holes
screw_head_thick = 0.22*inches; // Sets depth of counterbore
screw_head_dia = 0.33*inches;  // Sets diameter of counterbore
nut_dia = (11/32)*inches; // Sets depth and width of nut pocket
nut_thick = 0.14*inches;  // Sets thickness of nut pocket

// Vixen dovetail bar dimensions.  It should be possible to adjust for other types of dovetails
// by changing these parameters.
bar_width = 2.88*inches;  // Width of the dovetail bar at its base, less 0.04" -- the difference 
                         // ensures that the clamp won't bottom out. 
bar_depth = .256*inches;  // Thickness of the dovetail bar
clamp_angle = 30;   // The angle of each side of the dovetail bar, in degrees  15 degrees is too low but does do the job but increase to 30 which seems more accurate when measured. 
bar_offset = bar_depth*sin(clamp_angle);  // Amount a side of the dovetail bar angles in

// Parameters for this dovetail clamp
clamp_base_depth = 0.4*inches;  // Thickness of the clamp base
clamp_jaw_thick = 0.2*inches;  // Width of the jaw at its narrowest (the point where dovetail bar is widest)
clamp_end_thick = 0.1*inches;
jaw_thick = clamp_jaw_thick+bar_offset;   // Thickness of the jaw at its top
jaw_base_width = jaw_thick+0.1*inches;

clearance = 0.01*inches;    // A small gap between parts that move against each other

delta = 0.02*inches;  // A small amount for padding, e.g. to ensure that differences are complete

module V_clamp(length) {
    rotate([90,0,90]) {
        linear_extrude(height = length) {
            polygon([[0,0], [0, clamp_base_depth+bar_depth], 
                    [clamp_jaw_thick+bar_offset, clamp_base_depth+bar_depth],
                    [clamp_jaw_thick, clamp_base_depth], 
                    [clamp_jaw_thick+bar_width, clamp_base_depth], 
                    [clamp_jaw_thick+bar_width-bar_offset, clamp_base_depth+bar_depth],
                    [2*clamp_jaw_thick+bar_width, clamp_base_depth+bar_depth], 
                    [2*clamp_jaw_thick+bar_width, 0],
                    [0,0]]);
        }
    }
}
        
module V_jaw(length) {
    rotate([90,0,90]) {
        linear_extrude(height = length) {
            polygon([[0,0], [0, clamp_base_depth+bar_depth], 
                    [clamp_jaw_thick+bar_offset, clamp_base_depth+bar_depth],
                    [clamp_jaw_thick, clamp_base_depth], 
                    [jaw_base_width, clamp_base_depth], 
                    [jaw_base_width, 0], [0,0]]);
        }
    }
}

module trimmed_jaw(extra=0) {
    difference() {
        V_jaw(clamp_length);
        end_trimmer(clamp_end_thick+extra);
        translate([clamp_length,0,0]) 
            mirror([1,0,0]) 
                end_trimmer(clamp_end_thick+extra);
    }
}

module end_trimmer(offset) {
    translate([0,bar_width+delta,0])
    rotate([90,0,0]) {
        linear_extrude(height = bar_width+2*delta) {
            polygon([[offset,clamp_base_depth], 
                    [-delta, clamp_base_depth], [-delta, -delta],
                    [offset+(clamp_base_depth+delta)/2, -delta]]);
        }
    }
}

module screw_holes() {
    // Two holes with nut pockets for the clamping screws
    union() {
        translate([0.3*clamp_length, bar_width-0.2*inches, clamp_base_depth-(nut_dia/2)])
            rotate([90,0,0]) cylinder(bar_width, d=screw_dia, $fs=1);
        translate([0.3*clamp_length-nut_dia/2, jaw_base_width+0.2*inches, clamp_base_depth-nut_dia])
            cube([nut_dia, nut_thick, nut_dia+delta]);
    }
    union() {
        translate([0.7*clamp_length, bar_width-0.2*inches, clamp_base_depth-(nut_dia/2)])
            rotate([90,0,0]) cylinder(bar_width, d=screw_dia, $fs=1);
        translate([0.7*clamp_length-nut_dia/2, jaw_base_width+0.2*inches, clamp_base_depth-nut_dia])
            cube([nut_dia, nut_thick, nut_dia+delta]);
    }
    
    // Counterbored holes for attachment to this dovetail mount
    centerline = bar_width/2+clamp_jaw_thick-0.025*inches;
    for (h = screw_holes) {
        union() {
            translate([h[0], centerline+h[1], -delta]) {
                cylinder(clamp_base_depth+2*delta, d=screw_dia, $fs=1);
            }
            translate([h[0], centerline+h[1], clamp_base_depth-screw_head_thick]) {
                cylinder(screw_head_thick+delta, d=screw_head_dia, $fs=1);
            }
        }
    }           
}


 
translate([0,-0.2*inches,0]) {
    rotate([90,0,0]) 
        difference() {
            trimmed_jaw(clearance);
            screw_holes();
        }
}

difference() {
    V_clamp(clamp_length);
    trimmed_jaw(0);
    screw_holes();
}


