// Text Font Test by Robert Halter
// Just to Test the OpenSCAD text function in Thingiverse Customizer in Combination with Google Fonts.
//
// http://www.thingiverse.com/thing:2157178
//
// Licensed: Creative Commons - Attribution - Non-Commercial - Share Alike (by-nc-sa)
// see: http://en.wikipedia.org/wiki/Creative_Commons
//
// License for Font Courgette, Amatic SC (on Google Fonts)
// Open Font License : http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL_web
//
// author: Robert Halter - CH - 06.03.2017
//
// with:   OpenSCAD Version 2015.03
//
// History
// 21.03.2017
// - font_name options extended Font work with fontname:style, i.e. Corben:bold
// - function isBold() added.
// - function getFontNameWithStyle() added.
// - doEcho added, for debugging.
// 09.03.2017
// - text_color
// - build_plate_color
// - parameter descriptions with default values
// - Modules
// - show_build_plate yes, no
// 06.03.2017
// - optimizing some parameter values / defaults
// - build plate translate
// - font_name_manual
// - parameter writing_direction
// - build plate Robox x210 y150
// - preview
// - some predefined Fonts
// - Initial Version

use <utils/build_plate.scad>

/* [Customize] */

// your customizable text to generate.
text_to_generate = "Courgette 123";

// font size - dezimal - height above the baseline. - Default is '30'.
font_size = 30;

// font name - use predefined Names or 'Manual' - default is 'Courgette'
font_name = "Courgette"; // [Gloria Hallelujah, Pacifico, Courgette, Permanent Marker, Domine:Domine bold, Ultra, Bevan, Corben:Corben bold, Coustard:Coustard bold, Manual]

// use it if font name is 'Manual' - manual entered g o o g l e font name - can also include a style parameter - example is 'Amatic SC:bold'
font_name_manual = "Amatic SC:bold";

// factor to increase/decrease the character spacing. '1.0' is normal spacing. - default is '0.7'
character_spacing = 0.7; // [0.5, 0.6, 0.7, 0.8, 0.9, 1.0]

// direction of the text flow. - default is 'left-to-right'
writing_direction = "ltr"; // [ltr:left-to-right, ttb:top-to-bottom]

// thickness of letters [mm] - z direction - default is '35'
thickness_of_letters = 35; // [35, 30, 25, 20, 15, 10, 5, 1]

/* [View] */

// view text in selected color - default is 'Red'
text_color = "Red"; // [White, Silver, Gray, Black, Red, Maroon, Yellow, Olive, Lime, Green, Aqua, Teal, Blue, Navy, Fuchsia, Purple]

// to measure of text extent switch to 'yes' - default is 'no'
show_build_plate = "no"; // [yes, no]

// view build plate in Measure-Mode or in selected color - default is 'Measure'
build_plate_color = "Measure"; // [Measure, White, Silver, Gray, Black, Red, Maroon, Yellow, Olive, Lime, Green, Aqua, Teal, Blue, Navy, Fuchsia, Purple]

// the build plate x dimension - default is '210'
build_plate_manual_x = 210; // [100, 150, 200, 210, 246, 400]

// the build plate y dimension - default is '150'
build_plate_manual_y = 150; // [100, 150, 152, 200, 400]

/* [Hidden] */

// Show some Log Information for Debugging to Console [boolean]
doEcho = false; // [false,true]
if(doEcho) echo("WARNING: doEcho ist true!");

if(doEcho) echo(str("font_name: ", font_name));

// Font Names with Bold Style
function isBold() =
    "Domine" == font_name ?
        true
	: "Corben" == font_name ?
        true
	: "Coustard" == font_name ?
        true
	: false;
	
if(doEcho) echo(str("isBold(): ", isBold()));

function getFontNameWithStyle() =
    isBold() ?
	    str(font_name, ":bold")
	: font_name;
if(doEcho) echo(str("getFontNameWithStyle(): ", getFontNameWithStyle()));

xTranslate = build_plate_manual_x / 2;
yTranslate = build_plate_manual_y / 2;

// for display only, doesn't contribute to final object
build_plate_selector = 3; // [0:Replicator 2, 1: Replicator, 2:Thingomatic, 3:Manual]

function is_vertical() = writing_direction == "ttb" ? true : false;
function is_manual_entered_font_name() = font_name == "Manual" ? true : false;

// preview[view:south, tilt:top]

// Model - Start

if ("yes" == show_build_plate) {
    if ("Measure" == build_plate_color) {
        myBuildPlate();
    } else {
        color(build_plate_color) {
            myBuildPlate();
        }
    }
}
color(text_color) {
    myText();
}

// Model - End


// Modules - Start

module myBuildPlate() {
    translate([xTranslate,yTranslate,0]) {
        build_plate(build_plate_selector, build_plate_manual_x, build_plate_manual_y);
    }
}

module myText() {
    linear_extrude(height = thickness_of_letters) {
        text(text_to_generate,
            size = font_size,
            font = is_manual_entered_font_name() ? font_name_manual : getFontNameWithStyle(),
            halign = is_vertical() ? "center" : "left",
            valign = "baseline",
            spacing = character_spacing,
            direction = writing_direction,
            language = "en",
            script = "latin",
            $fn = 50);
    }
}

// Modules - End
