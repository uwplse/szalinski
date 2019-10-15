// DogHolePeg

$fa=1*1;
$fs=0.25*1;

// select type of head: rectangular or round
head_type = "rect"; // [rect, round] 
// Inch input values are internally converted to mm. Export should then be done in mm.
metric = "mm"; // [mm, inch]

/* [main] */ 

// height of head/head part
head_height = 15;
// head size x (rect head) or diameter (round head)
head_size_x = 50;
// head size y (rect head)
head_size_y = 50;
// diameter of peg hole 
base_diameter = 40.5;
// depth of peg hole, usually thickniss of working table plate
base_height = 22.0;


/* [optional] */

// centered hole for a screw or reenforcements. Set to 0 for none.
drill_hole_diameter = 0;
// head counterbore depth around drilling 
drill_hole_head_counterbore_depth = 5;
// head counterbore diameter 
drill_hole_head_counterbore_diameter = 10;
// base counterbore depth around drilling 
drill_hole_base_counterbore_depth = 5;
// base counterbore diameter 
drill_hole_base_counterbore_diameter = 10;
// add slit in peg base
base_slit_size = 3;



unit_scale = metric == "inch" ? 25.4 : 1.0;
s_head_height = head_height * unit_scale;
s_head_size_x = head_size_x * unit_scale;
s_head_size_y = head_size_y * unit_scale;
s_base_diameter = base_diameter * unit_scale;
s_base_height = base_height * unit_scale;
s_drill_hole_diameter = drill_hole_diameter * unit_scale;
s_drill_hole_head_counterbore_depth = drill_hole_head_counterbore_depth * unit_scale;
s_drill_hole_head_counterbore_diameter = drill_hole_head_counterbore_diameter * unit_scale;
s_drill_hole_base_counterbore_depth = drill_hole_base_counterbore_depth * unit_scale;
s_drill_hole_base_counterbore_diameter = drill_hole_base_counterbore_diameter * unit_scale;
s_base_slit_size = base_slit_size * unit_scale;
s_head_diameter = s_head_size_x;


difference() {
    union() {
        
        // head / top 
        translate([0,0, s_head_height/2]) {
            if (head_type == "round") {
                cylinder(s_head_height, d=s_head_diameter, center=true);
            } else {
                cube([s_head_size_x, s_head_size_y, s_head_height], center=true);
            }
        }
        
        // base/peg/hole
        translate([0,0, s_head_height]) {
            difference() {
                cylinder(s_base_height, d=s_base_diameter, center=false);
                if (s_base_slit_size > 0) {
                    translate([-s_base_diameter/2,-s_base_slit_size/2,0])
                        cube([s_base_diameter, s_base_slit_size, s_base_height], center=false);
                }
            }
        }
    };
    
    if (s_drill_hole_diameter > 0) {
        cylinder(s_base_height+s_head_height, d=s_drill_hole_diameter, center=false);
        cylinder(s_drill_hole_head_counterbore_depth, d=s_drill_hole_head_counterbore_diameter, center=false);
        translate([0,0,s_head_height+s_base_height-s_drill_hole_head_counterbore_depth]) {
            cylinder(s_drill_hole_base_counterbore_depth, d=s_drill_hole_base_counterbore_diameter, center=false);
        }
    }
    
    
}

echo(version=version());

