/*
 * Customizable Aluminium Extrusion Brackets - https://www.thingiverse.com/thing:2503622
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2018-01-26
 * version v1.4
 * modified by Ben McLuckie for REV Robotics build system used in FTC - http://www.revrobotics.com/rev-45-1270/
 *
 * Changelog
 * --------------
 * remix
        - modified for REV Robotics
 * v1.4:
 *      - added tiny straight bracket
 * v1.3.1:
 *      - some fixes and some code cleaning. Thanks goes to Matt Stiegers (Miriax)! 
 * v1.3:
 *      - added library feature. You can use this file in your OpenSCAD project to
 *        add a bracket with a simple call. More information below.
 *        Thanks goes to Matt Stiegers (Miriax) for this suggestion!
 * v1.2:
 *      - added 25mm width option for 25-2525 (80/20 Inc.) extrusions
 * v1.1:
 *      - added 25.4mm width option for qubelok and 1010 (80/20 Inc.) extrusions 
 * v1.0:
 *      - final design
 * --------------
 *
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial license.
 * https://creativecommons.org/licenses/by-nc/3.0/
 */

 /*
 
 Library instructions
 ####################

 Installation:
   - add this OpenSCAD file to the folder of your project
   - add "use <customizable_aluminium_extrusion_plate_bracket.scad>;"
     in the head of your file.
   - add "aluminium_extrusion_bracket();" below in your program section
 
 Usage:
    The module has several parameter to change the bracket. The first value is default:
      - shape = "L", "I", "T" or "X"
      - type = "uniform" (L, T, X type), "tiny" (I type) "short" (all types), "normal" (I type) or "long" (I type)
      - support = "full", "half" or "none" (support only applies to L, T, X type)
      - width_in_millimeter = 20
      - length_in_millimeter = 60
      - bracket_height_in_millimeter = 7.0
      - number_of_rails = 1
      - screw_hole_diameter_in_millimeter = 5
      - screw_head_offset_diamter_in_millimeter = 12.0
      - screw_head_offset_height_in_millimeter = 1.5
      - number_of_extra_holes = 1
      - preview_color = "HotPink"
      - center = false, true
      - $fn = 16
 
 Example:
     
     use <customizable_aluminium_extrusion_plate_bracket.scad>;
     aluminium_extrusion_bracket( shape = "T", support = "half", center = true );
   
     This creates a origin centered T-shape bracket with half support.

 */

 // Parameter Section //
//-------------------//

/* [Bracket Settings] */

// Which part do you want to see? This may be the only setting you need to make, since all the values below have already been set from REV's own brackets.
part = "all_parts__"; //[all_parts__:All Brackets,tiny_straight_bracket__:Tiny Straight Bracket,short_straight_bracket__:Short Straight Bracket,normal_straight_bracket__:Normal Straight Bracket,long_straight_bracket__:Long Straight Bracket,short_l_shape_none_support__:Short L-shape Bracket without support,short_l_shape_half_support__:Short L-shape Bracket with half support,short_l_shape_full_support__:Short L-shape Bracket with full support,uniform_l_shape_none_support__:Uniform L-shape Bracket without support,uniform_l_shape_half_support__:Uniform L-shape Bracket with half support,uniform_l_shape_full_support__:Uniform L-shape Bracket with full support,short_t_shape_none_support__:Short T-shape Bracket without  support,short_t_shape_half_support__:Short T-shape Bracket with half support,short_t_shape_full_support__:Short T-shape Bracket with full support,uniform_t_shape_none_support__:Uniform T-shape Bracket without support,uniform_t_shape_half_support__:Uniform T-shape Bracket with half support,uniform_t_shape_full_support__:Uniform T-shape Bracket with full support,short_x_shape_none_support__:Short X-shape Bracket without support,short_x_shape_half_support__:Short X-shape Bracket with half support,short_x_shape_full_support__:Short X-shape Bracket with full support,uniform_x_shape_none_support__:Uniform X-shape Bracket without support,uniform_x_shape_half_support__:Uniform X-shape Bracket with half support,uniform_x_shape_full_support__:Uniform X-shape Bracket with full support]

// Set the width of the aluminium extrusion. If you have e.g. a 2020 one, set 20mm. If you have e.g. a 2040 one, it depends on which side you want to mount the bracket --> set 20mm or 40mm
width_in_millimeter = 13.8; //[13.8,15,20,25,25.4,30,40,45,60,80,90,120,160]

// The length of the L-bracket and the short side of the T-bracket. The length of the straight bracket, the X-bracket and the longer side of the T-bracket equals two times of the L-bracket length minus the width of the aluminium extrusion.
length_in_millimeter = 46.3; //[1:200]

// The height/thickness of the bracket.
bracket_height_in_millimeter = 3.0; //[0.1:0.1:30]

// Set the number of rails/slots of the aluminium extrusion. A 2020 one has one rail per side, a 2040 have one rail or two rails.
number_of_rails = 1; //[1:1:4]

// Set 3.2 for M3, 4.3 for M4, 5.3 for M5, 6.4 for M6, 8.4 for M8, 10.5 for M10 screws
screw_hole_diameter_in_millimeter = 3.9;

// If you want to use a ISO7009/DIN125 washer, set 7.5 for M3, 9.5 for M4, 10.5 for M5, 12.5 for M6, 16.5 for M8, 20.5 for M10... Or if you don't want to use a washer, just measure the diameter of the screw head and type it in here.
screw_head_offset_diamter_in_millimeter = 7.5;

// If you want to cover the screw head completly, you can measure the height of the head of the screws and set it here. Don't forget to add the thickness of the washer! If you set a high value or maybe a higher value than the height of the bracket, you should also increase the bracket height.
screw_head_offset_height_in_millimeter = 0;

// If you need only the outer holes, then set 0. But it also makes the short type brackets unusable.
number_of_extra_holes = 3; //[0:1:4]


 // Program Section //
//-----------------//

if(part == "tiny_straight_bracket__") {
    aluminium_extrusion_bracket(shape = "I", type = "tiny", support = "", preview_color = "YellowGreen");
} else if(part == "short_straight_bracket__") {
    aluminium_extrusion_bracket(shape = "I", type = "short", support = "", preview_color = "YellowGreen");
} else if(part == "normal_straight_bracket__") {
    aluminium_extrusion_bracket(shape = "I", type = "normal", support = "", preview_color = "YellowGreen");
} else if(part == "long_straight_bracket__") {
    aluminium_extrusion_bracket(shape = "I", type = "long", support = "", preview_color = "YellowGreen");
} else if(part == "short_l_shape_none_support__") {
    aluminium_extrusion_bracket(shape = "L", type = "short", support = "none", preview_color = "DimGray");
} else if(part == "short_l_shape_half_support__") {
    aluminium_extrusion_bracket(shape = "L", type = "short", support = "half", preview_color = "DimGray");
} else if(part == "short_l_shape_full_support__") {
    aluminium_extrusion_bracket(shape = "L", type = "short", support = "full", preview_color = "DimGray");
} else if(part == "uniform_l_shape_none_support__") {
    aluminium_extrusion_bracket(shape = "L", type = "uniform", support = "none", preview_color = "DeepSkyBlue");
} else if(part == "uniform_l_shape_half_support__") {
    aluminium_extrusion_bracket(shape = "L", type = "uniform", support = "half", preview_color = "DeepSkyBlue");
} else if(part == "uniform_l_shape_full_support__") {
    aluminium_extrusion_bracket(shape = "L", type = "uniform", support = "full", preview_color = "DeepSkyBlue");
} else if(part == "short_t_shape_none_support__") {
    aluminium_extrusion_bracket(shape = "T", type = "short", support = "none", preview_color = "HotPink");
} else if(part == "short_t_shape_half_support__") {
    aluminium_extrusion_bracket(shape = "T", type = "short", support = "half", preview_color = "HotPink");
} else if(part == "short_t_shape_full_support__") {
    aluminium_extrusion_bracket(shape = "T", type = "short", support = "full", preview_color = "HotPink");
} else if(part == "uniform_t_shape_none_support__") {
    aluminium_extrusion_bracket(shape = "T", type = "uniform", support = "none", preview_color = "DarkOrange");
} else if(part == "uniform_t_shape_half_support__") {
    aluminium_extrusion_bracket(shape = "T", type = "uniform", support = "half", preview_color = "DarkOrange");
} else if(part == "uniform_t_shape_full_support__") {
    aluminium_extrusion_bracket(shape = "T", type = "uniform", support = "full", preview_color = "DarkOrange");
} else if(part == "short_x_shape_none_support__") {
    aluminium_extrusion_bracket(shape = "X", type = "short", support = "none", preview_color = "Gold");
} else if(part == "short_x_shape_half_support__") {
    aluminium_extrusion_bracket(shape = "X", type = "short", support = "half", preview_color = "Gold");
} else if(part == "short_x_shape_full_support__") {
    aluminium_extrusion_bracket(shape = "X", type = "short", support = "full", preview_color = "Gold");
} else if(part == "uniform_x_shape_none_support__") {
    aluminium_extrusion_bracket(shape = "X", type = "uniform", support = "none", preview_color = "MediumPurple");
} else if(part == "uniform_x_shape_half_support__") {
    aluminium_extrusion_bracket(shape = "X", type = "uniform", support = "half", preview_color = "MediumPurple");
} else if(part == "uniform_x_shape_full_support__") {
    aluminium_extrusion_bracket(shape = "X", type = "uniform", support = "full", preview_color = "MediumPurple");
} else if(part == "all_parts__") {
    all_parts();
} else {
    all_parts();
}

 // Module Section //
//----------------//

module aluminium_extrusion_bracket( 
    shape = "L", // I, L, T or X
    type = "uniform", // tiny (I type), short (I, L, T, X type), normal (I type), long (I type), uniform (L, T, X type)
    support = "full", // none, half, full (L, T, X type)
    width_in_millimeter = (width_in_millimeter != undef) ? width_in_millimeter : 20,
    length_in_millimeter = (length_in_millimeter != undef) ? length_in_millimeter : 60,
    bracket_height_in_millimeter = (bracket_height_in_millimeter != undef) ? bracket_height_in_millimeter : 7.0,
    number_of_rails = (number_of_rails != undef) ? number_of_rails : 1,
    screw_hole_diameter_in_millimeter = (screw_hole_diameter_in_millimeter != undef) ? screw_hole_diameter_in_millimeter : 6.4,
    screw_head_offset_diamter_in_millimeter = (screw_head_offset_diamter_in_millimeter != undef) ? screw_head_offset_diamter_in_millimeter : 12.0,
    screw_head_offset_height_in_millimeter = (screw_head_offset_height_in_millimeter != undef) ? screw_head_offset_height_in_millimeter : 1.5,
    number_of_extra_holes = (number_of_extra_holes != undef) ? number_of_extra_holes : 1,
    preview_color = "HotPink",
    center = false,
    $fn = 16    
) {
    w = width_in_millimeter;
    l = length_in_millimeter;
    h = bracket_height_in_millimeter;
    hole_d = screw_hole_diameter_in_millimeter;
    hole_offset_d = screw_head_offset_diamter_in_millimeter;
    hole_offset_h = screw_head_offset_height_in_millimeter;
    holes = number_of_extra_holes + 1;
    rails = number_of_rails;
    translate_x = center ? -l + w / 2 : 0;
    translate_y = center ? -l + w / 2 : 0;

    color(preview_color) translate([translate_x, translate_y, 0]) {
        difference() {
            linear_extrude(height = h, convexity = 2){
                if(shape == "I" && type == "tiny") tiny_I_shape(w, l);
                if(shape == "I" && type == "short") short_I_shape(w, l);
                if(shape == "I" && type == "normal") normal_I_shape(w, l);
                if(shape == "I" && type == "long") long_I_shape(w, l);
                if(shape == "L" && type == "short" && support == "none") short_L_shape_none_support(w, l);
                if(shape == "L" && type == "short" && support == "half") short_L_shape_half_support(w, l);
                if(shape == "L" && type == "short" && support == "full") short_L_shape_full_support(w, l);
                if(shape == "L" && type == "uniform" && support == "none") uniform_L_shape_none_support(w, l);
                if(shape == "L" && type == "uniform" && support == "half") uniform_L_shape_half_support(w, l);
                if(shape == "L" && type == "uniform" && support == "full") uniform_L_shape_full_support(w, l);
                if(shape == "T" && type == "short" && support == "none") short_T_shape_none_support(w, l);
                if(shape == "T" && type == "short" && support == "half") short_T_shape_half_support(w, l);
                if(shape == "T" && type == "short" && support == "full") short_T_shape_full_support(w, l);
                if(shape == "T" && type == "uniform" && support == "none") uniform_T_shape_none_support(w, l);
                if(shape == "T" && type == "uniform" && support == "half") uniform_T_shape_half_support(w, l);
                if(shape == "T" && type == "uniform" && support == "full") uniform_T_shape_full_support(w, l);
                if(shape == "X" && type == "short" && support == "none") short_X_shape_none_support(w, l);
                if(shape == "X" && type == "short" && support == "half") short_X_shape_half_support(w, l);
                if(shape == "X" && type == "short" && support == "full") short_X_shape_full_support(w, l);
                if(shape == "X" && type == "uniform" && support == "none") uniform_X_shape_none_support(w, l);
                if(shape == "X" && type == "uniform" && support == "half") uniform_X_shape_half_support(w, l);
                if(shape == "X" && type == "uniform" && support == "full") uniform_X_shape_full_support(w, l);
            }
            short = (type == "short" || type == "tiny") ? 0 : 1;
            center_holes_cut(w, l, h, rails, hole_d, hole_offset_d, hole_offset_h, holes);  
            if(shape == "X" || shape == "I") arm_holes_cut(0, 1, w, l, h, rails, hole_d, hole_offset_d, hole_offset_h, holes);
            if(shape == "T" || shape == "X") arm_holes_cut(90, short, w, l, h, rails, hole_d, hole_offset_d, hole_offset_h, holes);
                                             arm_holes_cut(180, 1, w, l, h, rails, hole_d, hole_offset_d, hole_offset_h, holes);    
            if(shape != "I")                 arm_holes_cut(270, short, w, l, h, rails, hole_d, hole_offset_d, hole_offset_h, holes);
        }
    }
}

module all_parts() {
    pos0 = 0;
    pos1 = length_in_millimeter * 2 - width_in_millimeter + 5;
    pos2 = pos1 * 2;
    pos3 = pos1 * 3;
    pos4 = pos1 * 4;
    pos5 = pos1 * 5;    
    translate([pos0, pos0, 0]) aluminium_extrusion_bracket(shape = "L", type = "short", support = "none", preview_color = "DimGray");
    translate([pos0, pos1, 0]) aluminium_extrusion_bracket(shape = "L", type = "short", support = "half", preview_color = "DimGray");
    translate([pos0, pos2, 0]) aluminium_extrusion_bracket(shape = "L", type = "short", support = "full", preview_color = "DimGray");
    translate([pos1, pos0, 0]) aluminium_extrusion_bracket(shape = "L", type = "uniform", support = "none", preview_color = "DeepSkyBlue");
    translate([pos1, pos1, 0]) aluminium_extrusion_bracket(shape = "L", type = "uniform", support = "half", preview_color = "DeepSkyBlue");
    translate([pos1, pos2, 0]) aluminium_extrusion_bracket(shape = "L", type = "uniform", support = "full", preview_color = "DeepSkyBlue");
    translate([pos2, pos0, 0]) aluminium_extrusion_bracket(shape = "T", type = "short", support = "none", preview_color = "HotPink");
    translate([pos2, pos1, 0]) aluminium_extrusion_bracket(shape = "T", type = "short", support = "half", preview_color = "HotPink");
    translate([pos2, pos2, 0]) aluminium_extrusion_bracket(shape = "T", type = "short", support = "full", preview_color = "HotPink");
    translate([pos3, pos0, 0]) aluminium_extrusion_bracket(shape = "T", type = "uniform", support = "none", preview_color = "DarkOrange");
    translate([pos3, pos1, 0]) aluminium_extrusion_bracket(shape = "T", type = "uniform", support = "half", preview_color = "DarkOrange");
    translate([pos3, pos2, 0]) aluminium_extrusion_bracket(shape = "T", type = "uniform", support = "full", preview_color = "DarkOrange");
    translate([pos4, pos0, 0]) aluminium_extrusion_bracket(shape = "X", type = "short", support = "none", preview_color = "Gold");
    translate([pos4, pos1, 0]) aluminium_extrusion_bracket(shape = "X", type = "short", support = "half", preview_color = "Gold");
    translate([pos4, pos2, 0]) aluminium_extrusion_bracket(shape = "X", type = "short", support = "full", preview_color = "Gold");
    translate([pos5, pos0, 0]) aluminium_extrusion_bracket(shape = "X", type = "uniform", support = "none", preview_color = "MediumPurple");
    translate([pos5, pos1, 0]) aluminium_extrusion_bracket(shape = "X", type = "uniform", support = "half", preview_color = "MediumPurple");
    translate([pos5, pos2, 0]) aluminium_extrusion_bracket(shape = "X", type = "uniform", support = "full", preview_color = "MediumPurple"); 
    translate([pos0, pos3, 0]) aluminium_extrusion_bracket(shape = "I", type = "tiny", preview_color = "YellowGreen");
    translate([pos1, pos3, 0]) aluminium_extrusion_bracket(shape = "I", type = "short", preview_color = "YellowGreen");
    translate([pos2, pos3, 0]) aluminium_extrusion_bracket(shape = "I", type = "normal", preview_color = "YellowGreen");
    translate([pos3, pos3, 0]) aluminium_extrusion_bracket(shape = "I", type = "long", preview_color = "YellowGreen");    
}

module tiny_I_shape(w, l) {
    polygon( points = [[l * 2 - w - ((l - w) / 2), l - w], [l * 2 - w - ((l - w) / 2), l], [l - w, l], [l - w, l - w]]);
}

module short_I_shape(w, l) {
    polygon( points = [[l * 2 - w - ((l - w) / 2), l - w], [l * 2 - w - ((l - w) / 2), l], [(l - w) / 2, l], [(l - w) / 2, l - w]]);
}

module normal_I_shape(w, l) {
    polygon( points = [[l * 2 - w - ((l - w) / 2), l - w], [l * 2 - w - ((l - w) / 2), l], [0, l], [0, l - w]]);
}

module long_I_shape(w, l) {
    polygon( points = [[l * 2 - w, l - w], [l * 2 - w, l], [0, l], [0, l - w]]);
}

module short_L_shape_none_support(w, l) {
    polygon( points=[[l - w, (l - w) / 2], [l, (l - w) / 2], [l, l], [0, l], [0, l - w], [l - w, l - w]]);
}

module short_L_shape_half_support(w, l) {
    polygon( points=[[l - w, (l - w) / 2], [l, (l - w) / 2], [l, l], [0, l], [0, l - w], [(l - w) / 2, l - w], [l - w , (l - w) / 2]]);
}

module short_L_shape_full_support(w, l) {
    polygon( points=[[l - w, (l - w) / 2], [l, (l - w) / 2], [l, l], [0, l], [0, l - w]]);
}

module uniform_L_shape_none_support(w, l) {
    polygon( points=[[l - w, 0], [l, 0], [l, l], [0, l], [0, l - w], [l - w, l - w]]);
}

module uniform_L_shape_half_support(w, l) {
    polygon( points=[[l - w, 0], [l, 0], [l, l], [0, l], [0, l - w], [(l - w) / 2, l - w], [l - w , (l - w) / 2]]);
}

module uniform_L_shape_full_support(w, l) {
    polygon( points=[[l - w, 0], [l, 0], [l, l], [0, l], [0, l - w]]);
}

module short_T_shape_none_support(w, l) {
    polygon( points=[[l - w, (l - w) / 2], [l, (l - w) / 2], [l, l * 2 - w - ((l - w) / 2)], [l - w, l * 2 - w - ((l - w) / 2)], [l - w, l], [0, l], [0, l - w], [l - w, l - w]]);
}

module short_T_shape_half_support(w, l) {
    polygon( points=[[l - w, (l - w) / 2], [l, (l - w) / 2], [l, l * 2 - w - ((l - w) / 2)], [l - w, l * 2 - w - ((l - w) / 2)], [l - w, l + (l - w) / 2], [(l - w) / 2, l], [0, l], [0, l - w], [(l - w) / 2, l - w], [l - w , (l - w) / 2]]);
}

module short_T_shape_full_support(w, l) {
    polygon( points=[[l - w, (l - w) / 2], [l, (l - w) / 2], [l, l * 2 - w - ((l - w) / 2)], [l - w, l * 2 - w - ((l - w) / 2)], [0, l], [0, l - w]]);
}

module uniform_T_shape_none_support(w, l) {
    polygon( points=[[l - w, 0], [l, 0], [l, l * 2 - w], [l - w, l * 2 - w], [l - w, l], [0, l], [0, l - w], [l - w, l - w]]);
}

module uniform_T_shape_half_support(w, l) {
    polygon( points=[[l - w, 0], [l, 0], [l, l * 2 - w], [l - w, l * 2 - w], [l - w, l + (l - w) / 2], [(l - w) / 2, l], [0, l], [0, l - w], [(l - w) / 2, l - w], [l - w , (l - w) / 2]]);
}

module uniform_T_shape_full_support(w, l) {
    polygon( points=[[l - w, 0], [l, 0], [l, l * 2 - w], [l - w, l * 2 - w], [0, l], [0, l - w]]);
}

module short_X_shape_none_support(w, l) {
    polygon( points=[[l - w, (l - w) / 2], [l, (l - w) / 2], [l, l-w], [l * 2 - w, l - w], [l * 2 - w , l], [l, l], [l, l * 2 - w - ((l - w) / 2)], [l - w, l * 2 - w - ((l - w) / 2)], [l - w, l], [0, l], [0, l - w], [l - w, l - w]]);
}

module short_X_shape_half_support(w, l) {
    polygon( points=[[l - w, (l - w) / 2], [l, (l - w) / 2], [l, (l - w) / 2], [l * 2 - w - (l - w) / 2, l - w], [l * 2 - w, l - w], [l * 2 - w , l], [l + (l - w) / 2, l], [l, l + (l - w) / 2], [l, l * 2 - w - ((l - w) / 2)], [l - w, l * 2 - w - ((l - w) / 2)], [l - w, l + (l - w) / 2], [(l - w) / 2, l], [0, l], [0, l - w], [(l - w) / 2, l - w], [l - w , (l - w) / 2]]);
}

module short_X_shape_full_support(w, l) {
    polygon( points=[[l - w, (l - w) / 2], [l, (l - w) / 2], [l * 2 - w, l - w], [l * 2 - w , l], [l, l * 2 - w - ((l - w) / 2)], [l - w, l * 2 - w - ((l - w) / 2)], [0, l], [0, l - w]]);
}

module uniform_X_shape_none_support(w, l) {
    polygon( points=[[l - w, 0], [l, 0], [l, l-w], [l * 2 - w, l - w], [l * 2 - w , l], [l, l], [l, l * 2 - w], [l - w, l * 2 - w], [l - w, l], [0, l], [0, l - w], [l - w, l - w]]);
}

module uniform_X_shape_half_support(w, l) {
    polygon( points=[[l - w, 0], [l, 0], [l, (l - w) / 2], [l * 2 - w - (l - w) / 2, l - w], [l * 2 - w, l - w], [l * 2 - w , l], [l + (l - w) / 2, l], [l, l + (l - w) / 2], [l, l * 2 - w], [l - w, l * 2 - w], [l - w, l + (l - w) / 2], [(l - w) / 2, l], [0, l], [0, l - w], [(l - w) / 2, l - w], [l - w , (l - w) / 2]]);
}

module uniform_X_shape_full_support(w, l) {
    polygon( points=[[l - w, 0], [l, 0], [l * 2 - w, l - w], [l * 2 - w , l], [l, l * 2 - w], [l - w, l * 2 - w], [0, l], [0, l - w]]);
}

module center_holes_cut(w, l, bracket_h, number_of_rails, hole_d, hole_offset_d, hole_offset_h, number_of_holes) {
    translate([l - w / 2, l - w / 2, 0]) {
        translate([-w / 2, -w / 2, 0]) {
            for(middle_hole_x = [1 : number_of_rails]) {
                for(middle_hole_y = [1 : number_of_rails]) {
                    x_pos = w / number_of_rails * middle_hole_x - w / number_of_rails / 2;
                    y_pos = w / number_of_rails * middle_hole_y - w / number_of_rails / 2;
                    translate([ x_pos, y_pos, 0]) {
                        hole_shape(bracket_h, hole_d, hole_offset_d, hole_offset_h);
                    }
                }
            }
        }
    } 
}

module arm_holes_cut(rotation, extra_hole, w, l, bracket_h, number_of_rails, hole_d, hole_offset_d, hole_offset_h, number_of_holes) {
    translate([l - w / 2, l - w / 2, 0]) {
        rotate([0, 0, rotation]) {
            translate([0, -w / 2, 0]) {
                for(hole = [1 : number_of_holes + extra_hole - 1]) {
                    for(rail = [1 : number_of_rails]) {
                        x_pos = (l - w) / (number_of_holes) * hole + w / 2 - w / number_of_rails / 2;
                        y_pos = w / number_of_rails * rail - w / number_of_rails / 2;
                        translate([x_pos, y_pos, 0]) {
                            hole_shape(bracket_h, hole_d, hole_offset_d, hole_offset_h);
                        }
                    }
                }
            }
        }
    }
}

module hole_shape(bracket_h, hole_d, hole_offset_d, hole_offset_h) {
    translate([0, 0, -1]) {
        cylinder(d = hole_d, h = bracket_h + 3);
    }
    translate([0, 0, bracket_h - hole_offset_h]) {
        cylinder(d = hole_offset_d, h = hole_offset_h + 1);
    }
}
