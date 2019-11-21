
// --------------------- Configurable Items ---------------------

$fn = 50*1;  // Quality of holes... above 50 not necessary for such small holes. (Hidden in Customizer)

// Width of hole in wall (all measurements in MM)
hole_width = 150;

// Height of hole in wall
hole_height = 95;

// T3 Retrofit Box Width
T3_width = 105;

// T3 Retrofit Box Height
T3_height = 69;

// T3 Front Lip Border
T3_indent_width = 5;

// T3 Front Lip depth (for T3 flush to wall)
T3_indent_depth = 2;

// Adapter Lip Border and Thickness
front_lip_width = 5 * 1;      // Orig 5, Hidden in Customizer
front_lip_thickness = .3 * 1;  // Orig .3, Hidden in Customizer

sheetrock_thickness = 12 * 1;  // Orig 12, Hidden in Customizer

// --------------------- Configurable Items ---------------------

cs_radius = 3.5 * 1;  // Hidden in Customizer
screw_radius = 1.5 * 1;  // Hidden in Customizer

difference()
{
    // Solid (Additive) Objects...
    
    union()
    {
        cube([hole_width, hole_height, sheetrock_thickness], true);
        translate([0,0,-(sheetrock_thickness / 2)])
        {
            cube([hole_width + (front_lip_width*2), hole_height + (front_lip_width*2), front_lip_thickness], true);
        }
    }

    // Hole (Subtractive) Objects...
    
    // T3 main body
    cube([T3_width, T3_height, sheetrock_thickness+1], true);

    // T3 front face indent
    translate([0,0,-(sheetrock_thickness / 2)])
        cube([T3_width + (T3_indent_width * 2), T3_height + (T3_indent_width * 2), T3_indent_depth], true);

    // 4 Countersunk Holes
    hole_xpos = (hole_width/2) - 4;
    hole_ypos = (hole_height/2) - 4;

    // Countersinks
    translate([hole_xpos, hole_ypos, -(sheetrock_thickness/2)-10]) cylinder(sheetrock_thickness+2, cs_radius, cs_radius);
    translate([hole_xpos, -hole_ypos, -(sheetrock_thickness/2)-10]) cylinder(sheetrock_thickness+2, cs_radius, cs_radius);
    translate([-hole_xpos, -hole_ypos, -(sheetrock_thickness/2)-10]) cylinder(sheetrock_thickness+2, cs_radius, cs_radius);
    translate([-hole_xpos, hole_ypos, -(sheetrock_thickness/2)-10]) cylinder(sheetrock_thickness+2, cs_radius, cs_radius);

    // Holes
    translate([hole_xpos, hole_ypos, -(sheetrock_thickness/2)]) cylinder(sheetrock_thickness+2, screw_radius, screw_radius);
    translate([-hole_xpos, -hole_ypos, -(sheetrock_thickness/2)]) cylinder(sheetrock_thickness+2, screw_radius, screw_radius);
    translate([hole_xpos, -hole_ypos, -(sheetrock_thickness/2)]) cylinder(sheetrock_thickness+2, screw_radius, screw_radius);
    translate([-hole_xpos, hole_ypos, -(sheetrock_thickness/2)]) cylinder(sheetrock_thickness+2, screw_radius, screw_radius);

}