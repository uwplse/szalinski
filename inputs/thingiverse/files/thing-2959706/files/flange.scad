//*******************************************************************************
// 
// Flange for mounting Multimeter holder or other things to parts from the Modular Mounting System by yyh1002
// (https://www.thingiverse.com/thing:2194278)
// Written by Ippokratis Anastasiadis 2018
// using OpenSCAD 2015.03-2
// 
//*******************************************************************************

$fn=36;
fudge=.1;
inner_width = 45;
inner_depth = 19;
height = 36;
wall_thickness = 4.4;
flap_width = 15;
screw_hole = 4.4;
brace_thickness = 6;
brace_curvature = 4;
standoff_depth = 2;
standoff_width = 16;

fixture_file = "Mounting_Braket_Pieces-Bolt_Side_fixed.stl";

// ---- 
cube_width = inner_width+2*wall_thickness;
cube_depth = inner_depth/2+wall_thickness;

// ----

translate ([0,height/2+5,0]) rotate ([-90,0,0]) part_front();
translate ([0,-height/2-5,0]) rotate ([90,0,0]) part_rear();

module part_front() {
    union() {        
        rotate([0,0,180])
        part_rear();
        // standoff
        translate([0,-cube_depth-standoff_depth/2-fudge,0])
        cube ([standoff_width, standoff_depth+2*fudge, standoff_width ], center = true);
        // mms fixture 
        translate([7.5,-cube_depth-standoff_depth,9.7])
        rotate([0,90,180])
        import(fixture_file, convexity=3);
    }
}


module part_rear() {
    union() {
        translate([0,cube_depth/2,0])
        difference() {
            cube ([cube_width, cube_depth, height], center = true);
            translate([0,-cube_depth/2,-fudge/2])
            cube ([inner_width, inner_depth, height+2*fudge], center = true);
        }
    }
    translate([inner_width/2+wall_thickness/2,cube_depth/2,0]) 
    flange();
    translate([-inner_width/2-wall_thickness/2,cube_depth/2,0])
    rotate([180,0,180])
    flange();
}

module flange () {
    difference () {
        hull() {
            cube ([wall_thickness, cube_depth, height], center = true);
            translate([wall_thickness+flap_width/2,-(cube_depth-wall_thickness)/2,0])
            rotate([90,0,0])
            cylinder (d=flap_width, h=wall_thickness+2*fudge, center = true);
        }
        union() {
            translate([0,wall_thickness,0])
            hull() {
                translate([brace_curvature,0,-(height-2*brace_thickness-brace_curvature)/2])
                rotate([90,0,0])
                cylinder (d=brace_curvature, h=cube_depth, center = true);
                translate([brace_curvature,0,(height-2*brace_thickness-brace_curvature)/2])
                rotate([90,0,0])
                cylinder (d=brace_curvature, h=cube_depth, center = true);
                translate([wall_thickness+flap_width/2,-(cube_depth-wall_thickness)/2,0])
                rotate([90,0,0])
                cylinder (d=flap_width-.5, h=wall_thickness+2*fudge, center = true);
            }
           translate([wall_thickness+flap_width/2,-2*fudge,0])
            rotate([90,0,0])
            cylinder (d=screw_hole, h=cube_depth, center = true);
        }
    } 
}


