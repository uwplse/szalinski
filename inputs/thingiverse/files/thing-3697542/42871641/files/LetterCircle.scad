/* [Config] */

//Letter to engrave or extrude
letter = "M";
// Diameter of the circle
diameter = 35; //[10:50]
//height of the cirle
height=1; //[0.5:0.5:10]
//You want to engrave or extrude?
raised_or_engraved = 1; //[1:Raised, 0:Engraved]
// Depth or hieght of the engraving
depth_or_height = 0.4;

/* [Expert] */


//Scale modifier. Change this to adjust the scale modifier. Might be needed with a different font. Larger is smaller letter
scale_modifier = 20;
//Font
font = "Calibri:style=Bold";

/* [Hidden] */
$fn=99;
_letter = str(letter);

module CircleLetter() {
    if (raised_or_engraved==1) {
        union() {
            cylinder(d=diameter, h=height);
            linear_extrude(height+depth_or_height) scale(diameter/scale_modifier, diameter/scale_modifier, 1) text(_letter, valign="center", halign="center", font=font);
        }
    } else {
        difference() {
            cylinder(d=diameter, h=height);
            translate([0, 0, height-depth_or_height]) linear_extrude(depth_or_height+0.1) scale(diameter/scale_modifier, diameter/scale_modifier, 1) text(_letter, valign="center", halign="center", font=font);
        }
    }
}

CircleLetter();