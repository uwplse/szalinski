// Pocket Operator Case Button Generator
// 2019/06/02
// Author: crashdebug
// Licensed under:
// Creative Commons - Attribution - Non-Commercial - Share Alike license. 
// https://www.thingiverse.com/crashdebug
//

// user parameters
// Characters to imprint on the buttons
characters = "abc";
// "☀☢☂⛇☄★⚡♥☘"

// Character size
char_size = 4.0;                    // [0:0.1:6]                
// Style of imprinting
style = "emboss";                   // [emboss, deboss]
// Character imprinting depth
profile_depth = 0.6;                // [0:0.1:2]

/* [Button Size] */
// Button height in mm
button_height = 6.0;                // [4:0.1:8]              
// Button radius in mm
button_radius = 3.5;
// Button top fillet radius in mm
button_fillet_radius = 0.6;
// Space between buttons
button_spacing = 15;

/* [Font settings Size] */
// Font to use
font_face = "Segoe UI";               // ["Segoe UI","Segoe UI Symbol","Roboto"]
// font style
font_style = "Bold";                // ["Bold","Black","Regular"]

// Character offset in mm to adjust centering
char_x_offset = 0.0;                // [-5:0.1:5]              
// Character offset in mm to adjust centering
char_y_offset = 0.0;                // [-5:0.1:5]              


/* [Hidden] */
//font = "Segoe UI:style=Bold";

// Construct font string here as thingiverse customizer does not like ":"
font = str(font_face,":style=",font_style);

char_fn = 32;
char_thickness = profile_depth*2;

b_h = button_height;
b_r = button_radius;
b_fr = button_fillet_radius;

make_buttons();

module make_buttons()
{
    offs = button_spacing;
    num_buttons = len(characters);
    //echo(num_buttons);
    if ( num_buttons > 4 ) {
        // create square arrangement of buttons
        side_len = ceil(sqrt(num_buttons));
        echo(side_len);
        idx = 0;
        for ( y = [0:side_len-1] )
            for ( x = [0:side_len-1] ) {
                //echo(idx);
                idx = y*side_len+x;
                if ( idx < num_buttons ) {
                    c = characters[idx];
                    translate([x*offs,-y*offs,0])
                        button_with_char(c);
                }
                    
            }
            
        
    } else {
        // create simple linear pattern
        for ( i = [0:num_buttons-1] ) {
            c = characters[i];
            translate([i*offs,0,0])
                button_with_char(c);
        } 
    }
}

module button_with_char(c)
{
    if ( style == "emboss" ) {
        union() {
            button_complete();
            create_char(c);
        }
    } else {
        difference() {
            button_complete();
            create_char(c);
        }
    }
}  

module create_char(c)
{
    translate([char_x_offset,char_y_offset,b_h-char_thickness/2]) 
        extext(c);
}

module extext(c, size=char_size, thickness=char_thickness, fn=char_fn) {
    // extrude text
	linear_extrude(thickness) {
		text(c, size = size, font = font, halign = "center", valign = "center", $fn = fn);
	}
}

module button_poly()
{
    hull() {
        polygon([[0,b_h],[b_r,0],[0,0]]);
        translate([b_r-b_fr,b_h-b_fr]) circle(b_fr, $fn=16);
    }
}

module button_cap()
{
    difference() {
        rotate_extrude($fn=32) button_poly();
        cylinder(b_h-2, b_r-1, b_r-1, $fn=32);
    }
}

module button_cross()
{
    union() {
        cylinder(b_h-2, 1, 1, $fn=32);
        translate([0,0,1.5]) cube([b_r*2+3,1.5,3], center=true);
    }
}

module button_complete()
{
    union() {
        button_cap();
        button_cross();
    }
}

