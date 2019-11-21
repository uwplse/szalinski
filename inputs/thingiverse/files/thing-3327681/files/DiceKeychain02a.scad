// Keychain Dice Roller Generator
// 2019/1/1
// Author: crashdebug
// Licensed under the Creative Commons - Attribution - Non-Commercial - 
// Share Alike license. 
//

// disk user parameters
// -----------------------------------------------
// chamfer height
chamfer_height = 3;                 // [0:1:4]
// number of sides of the disk
disk_sides = 6;                     // [5:1:16]

// hanger user parameters
// -----------------------------------------------
// generate keychain hanger attachment
generate_hanger = "true";           // [true, false]
// thickness of hanger
hanger_thickness = 5; 
// width of hanger
hanger_width = 11; 
// length of hanger
hanger_length = 14;
// hanger hole diameter
hanger_hole_dia = 5;
// hanger position in degress (0=right side, 90=top, etc.)
hanger_position = 90;     

// dice user parameters
// -----------------------------------------------
// dice font
font_face = "Segoe UI";               // ["Segoe UI","Segoe UI Symbol","Roboto"]
// font style
font_style = "Bold";                // ["Bold","Black","Regular"]
// dice letter size
char_size = 8;
// text1 is on top, text3 is on bottom, the other wrap around the sides
text1 = "E";
text2 = "A";
text3 = "F";
text4 = "B";
text5 = "C";
text6 = "D";

// p____review[view:south, tilt:top]

/* [Hidden] */

// Construct font string here as thingiverse customizer does not like ":"
font = str(font_face,":style=",font_style);

// disk params
thickness = 13;
radius = 15.5;
chamfer = chamfer_height;
small_r = radius-chamfer;
disk_fn = disk_sides;
sphere_r = 11;
sphere_fn = 64;


module disk(thickness, r, small_r, chamfer_height, fn) {
    t = thickness-2*chamfer_height;
    union() {
        cylinder(chamfer_height,small_r,r, $fn=fn);
        translate([0,0,chamfer_height]) cylinder(t,r,r, $fn=fn);
        translate([0,0,chamfer_height+t]) cylinder(chamfer_height,r,small_r, $fn=fn);
    }
}  

module disk_w_hole(thickness, r, small_r, chamfer_height, fn_disk, r_sphere, fn_sphere) {
    difference() {
        disk(thickness,r,small_r,chamfer_height,fn_disk);
        translate([0,0,thickness/2]) sphere(r_sphere, $fn=fn_sphere);
    }
}

module hanger(thickness, width, length, hole_dia) {
    cube_len = length - width/2;
    hole_r = hole_dia/2;
    difference() {
        union() {
            translate([0, -width/2, 0]) cube([cube_len, width, thickness]);
            translate([cube_len, 0, 0]) cylinder(thickness, width/2, width/2);
        }
        translate([cube_len, 0, -1]) cylinder(thickness+2, hole_r, hole_r, $fn = 16);
    }
}

module hanger_positioned() {
    rotate([0,0,hanger_position])
        translate([sphere_r, 0, (thickness-hanger_thickness)/2]) 
            hanger(hanger_thickness, hanger_width, hanger_length, hanger_hole_dia);
}

//render() {
    
    union() {
        disk_w_hole(thickness,
                    radius,
                    small_r,
                    chamfer,
                    disk_fn,
                    sphere_r,
                    sphere_fn);

        if ( generate_hanger == "true" ) hanger_positioned();
    }

    translate([0,0,cube_size/2]) rotate([90,0,0]) 
        labeled_dice(symbols1);

//}

//////////////////////////////////////////////
//////////////////////////////////////////////
// dicegen code

char_thickness = 1;

//symbols1 = ["+", "L", "+", "U", "N", "A"];
symbols1 = [text1, text2, text3, text4, text5, text6];

// geometry detail
// default: char=16, dice=32
// hi-res: char=32, dice=64
char_fn = 32;
dice_fn = 64;
// dice size parameters
cube_size = 15;
sphere_radius = 10.36;

module extext(c, size=char_size, thickness=char_thickness, fn=char_fn) {
    // extrude text
	linear_extrude(thickness) {
		text(c, size = size, font = font, halign = "center", valign = "center", $fn = fn);
	}
}

module dice_base(radius=sphere_radius, size=cube_size, fn=dice_fn) {
    intersection() {
        sphere(radius, $fn=fn);
        cube(size, center=true);
    }
}

module symbols_arranged(symbols, offset) {
    translate([0,0,offset]) extext(symbols[1]);
    rotate([-90,0,0]) translate([0,0,offset]) extext(symbols[0]);
    rotate([90,0,0]) translate([0,0,offset]) extext(symbols[2]);
    
    rotate([0,90,0]) translate([0,0,offset]) extext(symbols[3]);
    rotate([0,180,0]) translate([0,0,offset]) extext(symbols[4]);
    rotate([0,270,0]) translate([0,0,offset]) extext(symbols[5]);
}

module labeled_dice(symbols) {
    offs = cube_size/2-char_thickness+0.1;
    difference() {
        dice_base();
        symbols_arranged(symbols, offs);
    }
}




