/* Author: Robert Niemöller */

//Diameter of the hole to be drilled
hole_diameter = 2;
//Thickness of the plank you want the hole in
plank_thickness = 18;
//Height of the plastic part to guide the drill
drill_guidance = 5;

/* [Hidden] */
//Distance from hole to side
length = max( 30, plank_thickness * 2 );
//Tickness of the outer guides
thickness = 4;
//Total height
height = drill_guidance + 25;

z_offset = (plank_thickness - hole_diameter < thickness) ? drill_guidance : 0;

$fn = 24;
difference(){
    cube([ length, plank_thickness + 2 * thickness, height ]);
    translate([ thickness, -1 + 0.001, z_offset -0.001 ])
        cube([ length - 2 * thickness, thickness + 1, height - thickness - z_offset ]);
    translate([ thickness, plank_thickness + thickness - 0.001, z_offset -0.001 ])
        cube([ length - 2 * thickness, thickness + 1, height - thickness - z_offset ]);
    translate([ -1, thickness, drill_guidance ])
        cube([ length + 2, plank_thickness, height ]);
    translate([ length/2, plank_thickness/2 + thickness, -1])
        cylinder( d = hole_diameter, h = height + 1 );
}