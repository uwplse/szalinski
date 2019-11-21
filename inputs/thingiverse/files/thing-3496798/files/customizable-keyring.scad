// (c) 2019 Pavel Suchmann <pavel@suchmann.cz>
// Licensed under the terms of "Creative Commons - Public Domain Dedication"
//
// Note the source code would be more succint with minkowski()
// but its use is not recommended by Customizer's best practises.

// your text
label = "my tag";

// size of the font
size = 4; // [3:8]

// font name
font = "Liberation Sans:style=Bold"; // [ "Liberation Sans:style=Bold", "Open Sans:style=Bold", "Dejavu Serif:style=Bold", "Liberation Serif:style=Bold", "Luxi Serif:style=Bold" ]

/* [Hidden] */

$fn=30;

width = size * 2.0;
hole = 2;
length = (len(label)+2) * size;
border = size * 0.4;
height = 1.2;
emboss = 0.2;

//echo(length);
//echo(width);

difference() {
    union() {
        translate([-length/2, -width/2, 0])
            cylinder(r=border, h=height, center=true);
        translate([length/2, -width/2, 0])
            cylinder(r=border, h=height, center=true);
        translate([-length/2, width/2, 0])
            cylinder(r=border, h=height, center=true);
        translate([length/2, width/2, 0])
            cylinder(r=border, h=height, center=true);
        cube([length, width+border*2, height], center=true);
        cube([length+border*2, width, height], center=true);
    }
    union() {
        translate([hole, 0, emboss])
            linear_extrude(height)
                resize([(length - 5*hole) * 1.0, 0], auto=true)
                    text(label, size, halign="center", valign="center", font=font);
        translate([-length/2+1.5*hole, 0, -0.1])
            cylinder(r=hole, h=height*2, center=true);
    }
}