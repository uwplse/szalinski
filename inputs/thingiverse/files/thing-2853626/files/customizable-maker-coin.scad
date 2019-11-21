// Customizable Maker Coin
// Copyright: Olle Johansson 2018
// License: CC BY-SA

//CUSTOMIZER VARIABLES

/* [Coin] */

// Type of coin
type_of_coin = 2; // [0:Rounded, 1:Cylinder, 2:Torus]

// Add design in middle
type_of_inner_design = 1; // [0:None, 1:Sun, 2:Text, 3:Image]

// Should inner design be raised or cutout?
raise_inner_design = "yes"; // [yes,no]

// Diameter of coin in mm
diameter_of_coin = 50; // [40:60]

// Thickness of coin in mm
thickness_of_coin = 10; // [6:12]

// Distance of inner circle from outer edge
distance_to_inner_circle = 15; // [5:20]
diameter_of_inner_circle = diameter_of_coin - distance_to_inner_circle;

/* [Notches] */

// Add notches on edge of coin
display_notches = "yes"; // [yes, no]

// Type of notches
type_of_notch = 1; // [0:Rounded, 1:Twisted, 2:Globe]

// Width in mm of each notch on edge
width_of_notches = 10; // [5:15]

// Number of notches around edge
number_of_notches = 12; // [6:16]

/* [Inner Sun] */

// Diameter of sun in mm (excluding rays)
diameter_of_sun = 17; // [10:25]

// Height in mm of sun ray triangles
height_sun_ray = 5; // [2:8]

// Number of triangle rays on sun
number_of_sun_rays = 48; // [8:99]

/* [Inner text] */

// Text in middle of coin
inner_text = "OLLEJ";

// Font to use on the inner text
font_on_inner_text = "Helvetica";

// Size of inner text
size_of_inner_text = 5; // [1:15]

/* [Inner image] */

// Image to show in center of coin
inner_image = "logo.png"; // [image_surface:150x150]

/* [Circle text] */

// Show text in circle around edge of coin
display_circle_text = "yes"; // [yes, no]

// Text to print in a circle around the coin
text_around_coin = "Exalted Printing";

// Font to use on the circle text
font_on_circle_text = "Helvetica";

// Rotation angle in degrees of circle text
rotation_of_circle_text = 100; // [0:360]

// Distance of text in mm from inner circle
distance_of_text = 3; // [1:5]
// TODO: Allow text to be on outer circle?

//CUSTOMIZER VARIABLES END

/* [Hidden] */

$fn=100;

/* ** Utility modules ** */

module circled_pattern(number) {
    rotation_angle = 360 / number;
    last_angle = 360 - rotation_angle;
    for(rotation = [0 : rotation_angle : last_angle])
        rotate([0, 0, rotation])
        children();
}

/* ** Modifications ** */

module circle_text() {
    translate([0, 0, thickness_of_coin / 4])
    text_on_circle(
        t = text_around_coin,
        r = diameter_of_inner_circle / 2 - distance_of_text,
        font = font_on_circle_text,
        spacing = 1.7,
        extrusion_height = thickness_of_coin / 2,
        rotate = rotation_of_circle_text,
        center = true);
}

module inner_circle() {
    translate([0, 0, thickness_of_coin / 2])
    scale(v = [1, 1, 0.25])
    sphere(d = diameter_of_inner_circle);
}

/* ** Base coin ** */

module coin() {
    if (type_of_coin == 0) rounded_coin();
    else if (type_of_coin == 1) cylinder_coin();
    else if (type_of_coin == 2) torus_coin();
}

module cylinder_coin() {
    cylinder(h = thickness_of_coin, d = diameter_of_coin, center = true);
}

module rounded_coin() {
    intersection() {
        cylinder(h = thickness_of_coin, d = diameter_of_coin, center = true);
        scale([1, 1, 0.3])
        sphere(h = thickness_of_coin * 2, d = diameter_of_coin + 1, center = true);
    }
}

module torus_coin() {
    hull() {
        rotate_extrude(convexity = 10)
        translate([diameter_of_coin / 2 - thickness_of_coin / 2, 0, 0])
        circle(d = thickness_of_coin, center = true);

        cylinder(h = thickness_of_coin, d = diameter_of_coin - thickness_of_coin, center = true);
    }
}

/* ** Notches ** */

module edge_notches() {
    circled_pattern(number_of_notches)
        notch();
}

module notch() {
    if (type_of_notch == 0) rounded_notch();
    else if (type_of_notch == 1) twisted_notch();
    else if (type_of_notch == 2) sphere_notch();
}

module sphere_notch() {
    translate([diameter_of_coin / 2, 0, 0])
    scale([0.9, 1, 1])
    sphere(d = width_of_notches, center = true);
}

module rounded_notch() {
    translate([diameter_of_coin / 2, 0, - thickness_of_coin / 2])
    scale([0.9, 1, 1])
    cylinder(h = thickness_of_coin, d = width_of_notches);
}

module twisted_notch() {
    translate([diameter_of_coin / 2, 0, - thickness_of_coin / 2])
    scale([0.9, 1, 1])
    linear_extrude(height = thickness_of_coin, convexity = 1, twist = 180, slices = 100)
    circle(d = width_of_notches, $fn = 6);
}

/* ** Inner design ** */

module inner_design(raised = false) {
    if (type_of_inner_design == 1) inner_design_sun();
    else if (type_of_inner_design == 2) inner_design_text(raised);
    else if (type_of_inner_design == 3) inner_design_image();
}

module inner_design_image() {
    scale_xy = 0.25 * diameter_of_coin / 80;
    translate([0, 0, thickness_of_coin / 4])
    //scale([0.14, 0.14, 0.06])
    scale([scale_xy, scale_xy, 0.06])
    surface(file = inner_image, center = true, convexity = 10, invert = true);
}

module inner_design_text(raised = true) {
    if (raised == true) {
        translate([0, 0, thickness_of_coin / 8])
        linear_extrude(thickness_of_coin / 4)
        text(inner_text, size = size_of_inner_text, font = font_on_inner_text, halign = "center", valign = "center");
    } else {
        translate([0, 0, - thickness_of_coin / 4])
        linear_extrude(thickness_of_coin / 2)
        text(inner_text, size = size_of_inner_text, font = font_on_inner_text, halign = "center", valign = "center");
    }
}

module inner_design_sun() {
    translate([0, 0, - thickness_of_coin / 2])
    linear_extrude(height = thickness_of_coin - thickness_of_coin / 4)
    union() {
        circle(d = diameter_of_sun, center = true);
        
        // Triangle rays on outside of circle
        circled_pattern(number_of_sun_rays)
            ray_triangle();
    }
}

module ray_triangle(diameter) {
    //height_sun_ray = sqrt(side_sun_ray * side_sun_ray + side_sun_ray/2 * side_sun_ray/2);
    side_sun_ray = (2 * height_sun_ray) / sqrt(height_sun_ray);
    translate([diameter_of_sun / 2 + height_sun_ray / 2, 0, 0])
    rotate([0, 0, 135])
    polygon(points=[[0, 0], [side_sun_ray, 0], [0, side_sun_ray]], paths = [[0, 1, 2]]);
}

/* ** Main object ** */

module maker_coin() {
    union() {
        difference() {
            coin();
            
            inner_circle();
            if (display_circle_text == "yes") circle_text();
            if (display_notches == "yes") edge_notches();
            if (raise_inner_design == "no") inner_design();
        }

        if (raise_inner_design == "yes") inner_design(raised = true);
    }
}

maker_coin();

// Placed last to preserve line numbers when debugging.
//include <text_on.scad>

// ** Include text_on.scad inline to work on Thingiverse ** */

/*  text on ....
    This is a rework of version 3 of write.scad to use the new OpenSCAD internal text() primitive.
    All credit to Harlan Martin (harlan@sutlog.com) for his great effort on the original.
    Great thanks to t-paul (and the OpenSCAD dev team) on adding the new text() primitive.
*/

// Defaults
// Defaults for all modules
default_t = "text_on";
default_size = 4; // TODO - Can we make this 10?? To match internal size? There is an underlying value in text() -- This masks that.
default_font = "Liberation Mono";
default_spacing = 1; // Spacing between characters. There is an underlying value in text() -- This masks that. We try and match it here.
default_rotate = 0; // text rotation (clockwise)
default_center = true; //Text-centering
default_scale = [1,1,1];
default_extrusion_height = 2; //mm letter extrusion height

//Defaults for Cube
default_cube_face = "front"; // default face (top,bottom,left,right,back,front)
default_sphere_rounded = false; // default for rounded letters on text_on_sphere
default_cube_updown = 0; // mm up (-down) from center on face of cube
default_cube_rightleft = 0; // mm right(-left) from center on face of cube

//Defaults for Sphere
default_sphere_northsouth = 0;
default_sphere_eastwest = 0;
default_sphere_spin = 0; // TODO:Different to rotate? or up/down. Better name?

//Defaults for Cylinder (including circle as it is on top/bottom)
default_circle_middle = 0; // (mm toward middle of circle)
default_circle_ccw = false; // write on top or bottom in a ccw direction
default_circle_eastwest = 0;
default_cylinder_face = "side";
default_cylinder_updown = 0;

// Internal values - don't play with these :)
// This is much more accurate than the PI constant internal to Openscad.
internal_pi = 3.1415926535897932384626433832795028841971693993751058209;
internal_pi2 = internal_pi * 2;

// Internal values - You might want to play with these if you are using a proportional font
internal_space_fudge = 0.80; // Fudge for working out lengths (widths) of strings

debug = true;

function width_of_text_char(size, spacing) = size * internal_space_fudge * spacing;
function width_of_text_string_num_length(length, size, spacing) = width_of_text_char(size, spacing) * length;
//function width_of_text_string(t, size, spacing) = width_of_text_string_num_length(len(t), size, spacing);

//Rotate 1/2 width of text if centering    
//One less -- if we have a single char we are already centred..
function rotation_for_center_text_string(t, size, spacing, r, rotate, center) = (center) ? (width_of_text_string_num_length(len(t) - 1, size, spacing) / 2 / (internal_pi2 * r) * 360) : 0;

//Angle that measures width of letters on perimeter of a circle (and sphere and cylinder)
function rotation_for_character(size, spacing, r, rotate = 0) = (width_of_text_char( size, spacing ) / (internal_pi2 * r)) * 360 * (1 - abs(rotate) / 90);

function default_if_undef(val, default_val) = (val != undef) ? val : default_val;


module text_on_circle(t = default_t,
                      //Object-specific
                      locn_vec = [0, 0, 0],
                      r,
                      eastwest = default_circle_eastwest,
                      middle = default_circle_middle,
                      ccw = default_circle_ccw,

                      //All objects                      
                      extrusion_height = default_extrusion_height,
                      rotate = default_rotate,
                      center = default_center,
                      
                      //All objects -- arguments as for text()
                      font = undef,
                      size = default_size,
                      direction = undef,
                      halign = undef,
                      valign = undef,
                      language = undef,
                      script = undef,
                      spacing = default_spacing) {
//    echo (str("text_on_circle:","There are " ,len(t) ," letters in t" , t));
//    echo (str("text_on_circle:","rotate=" , rotate));
//    echo (str("text_on_circle:","eastwest=" , eastwest));

    if((halign != undef) || (halign != undef)) {
        echo(str("text_on_circle:","WARNING " , "halign and valign are NOT supported."));
    }

    ccw_sign = (ccw == true) ? 1 : -1;
    rtl_sign = (direction == "rtl") ? -1 : 1;
    ttb_btt_inaction = (direction == "ttb" || direction == "btt") ? 0 : 1;
    rotate_z_outer = -rotate + ccw_sign * eastwest;
    rotate_z_inner = -rtl_sign * ccw_sign * ttb_btt_inaction * rotation_for_center_text_string(t, size, spacing, r-middle, rotate, center);
    rotate(rotate_z_outer, [0, 0, 1] )
    rotate(rotate_z_inner, [0, 0, 1] )
    translate(locn_vec)
    for(l = [0 : len(t) - 1]) {
        //TTB/BTT means no per letter rotation
        rotate_z_inner2 = -ccw_sign * 90 + ttb_btt_inaction * rtl_sign * ccw_sign * l * rotation_for_character(size, spacing, r - middle, rotate = 0);   //Bottom out=-270+r
        //TTB means we go toward center, BTT means away
        vert_x_offset = (direction == "ttb" || direction == "btt") ? (l * size * ((direction == "btt") ? -1 : 1)) : 0;
        rotate(rotate_z_inner2, [0, 0, 1])
        translate([r - middle - vert_x_offset, 0, 0])
        rotate(-ccw_sign * 270, [0, 0, 1]) // flip text (botom out = -270)
        text_extrude(t[l],
                center = true,
                font = font,
                size = size,
                rotate = undef,
                spacing = spacing,
                direction = undef, //We don't pass direction ( misaligns inside text() ). TODO: Investigate why
                language = language,
                script = script,
                halign = halign,
                valign = valign,
                extrusion_height = extrusion_height);
    }
}

// Print a single character or a string at the desired extrusion height
// Passes on values to text() that are passed in
// TODO: Add x,y,z rotations get text facing the right way from the start)
module text_extrude( t = default_t,
                     extrusion_height = default_extrusion_height,
                     center = default_center, // Fudgy. YMMV. // TODO:center_extrusion, or extrusion offset??
                     rotate = default_rotate,
                     scale = default_scale, // For scaling by different on axes (for widening etc)
                     // Following are test() params (in addition to t=)
                     font = default_font,
                     size = default_size,
                     direction = undef,
                     halign  = undef,
                     valign = undef,
                     language = undef,
                     script = undef,
                     spacing = default_spacing) {
    //echo (str("text_extrude:","There are " ,len(t) ," letters in text" , t));
    //echo (str("text_extrude:","extrusion_height=" , extrusion_height));
    
    if(center == true) {
        if((halign != undef) || (valign != undef)) {
            echo(str("text_extrude:","WARNING " , "When center is true, then halign and valign are NOT supported."));
        }
    }
    
    // As arguments are explicitly set as undef (from higher functions) as they come down (they don't get defaults in this function as they are set as something)
    // we need to check and replace any that we don't want to be undef
    t = default_if_undef(t, default_t);
    font = default_if_undef(font, default_font);
    extrusion_height = default_if_undef(extrusion_height, default_extrusion_height);
    center = default_if_undef(center, default_center);
    rotate = default_if_undef(rotate, default_rotate);
    spacing = default_if_undef(spacing, default_spacing);
    size = default_if_undef(size, default_size);
    
    halign = (center) ? "center" : halign ;
    valign = (center) ? "center" : valign ;
    extrusion_center = (center) ? true : false ;
    
    scale(scale)
    rotate(rotate, [0, 0, -1]) //TODO: Do we want to make this so that the entire vector can be set?
    linear_extrude(height = extrusion_height, convexity = 10, center = extrusion_center)
    text(text = t,
            size = size,
            $fn = 40,
            font = font,
            direction = direction,
            spacing = spacing,
            halign = halign,
            valign = valign,
            language = language,
            script = script);
}

