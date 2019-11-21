// Created by mrpeter
// https://www.thingiverse.com/thing:2838486
// Creative Commons - Attribution - Non-Commercial - Share Alike License

// Coins : diameter / thickness in mm
// UK £1 - 22.5 / 3.15
// 1 Euro coin 23.25 / 2.33
// Canadian Dollar 26.5 / 1.95
// Canadian quarter 23.88 / 1.58
// US Dollar 26.5 / 2
// US Quarter 24.26 / 1.75
// Australian $1 - 25 / 3
// Australian $2 - 20.5 / 2.8

/* [Coin] */
// (Diameter of the coin) :
coin_diameter = 22.5;
// (Coin thickness) :
coin_thickness = 3.15;
// (Style) :
coin_head_style = "Sweeping Curve"; // [Dual Cutouts,Sweeping Curve]
// (Use this to adjust how much of the head is cut away by the sweeping curve) :
sweeping_curve_x_offset = 10; // [0:20]

// (Only available with 'Dual Cutouts' style) :
coin_cutout = "yes"; // [yes,no]
// (The thickness of plastic left around the edge of the keyring hole)
coin_cutout_border_thickness = 3;

/* [Cutout indents either side] */
// (X offset of the cutout from the center of the coin) :
cutout_x_offset = 2; // [0:10]
// (Y offset of the cutout from the center of the coin) :
cutout_y_offset = 4; // [0:10]
// (Diameter of cutout. Default should be ok most of the time) :
cutout_diameter = 15; // [0:40]

/* [Handle] */
// (Length) :
handle_length = 36; // [15:100]
// (The handle width ending at the head)
handle_width1 = 6; // [10:30]
// (The handle width ending at the keyring cutout) :
handle_width2 = 14; // [10:30]

/* [Keyring Hole] */
// (Distance between two elongated hole centerpoints. Zero will give you just a circular hole.) :
keyring_hole_width = 10;  // [0:20]
// Two holes in the handle, these are joined together. They can be moved apart to make a slat or a teardrop type of hole
handle_cutout_hole_diameter1 = 8; // [1:20]
handle_cutout_hole_diameter2 = 2; // [1:20]

/* [Handle Text] */
// (Show the text?):
show_text = "no"; // [yes,no]
// (Text) :
text = "£1";
// (Font):
font = "Helvetica Neue:style=Bold";
// (Font Size):
font_size = 6 ; // [4:12]
// (X Offset) :
text_x = 13; // [4:100]
// (Y Offset) :
text_y = -3; // [-10:10]
// (Typically use the layer height so it doesn't stick out too much.) :
text_height = 0.4; // [0.1:0.1:2]

/* [Smoothing] */
// (Smoothness of curves) :
smoothness = 200; // [25:25:200]

// ---- End of customisation parameters

if( show_text == "yes" ) {
    color([1,0,0]) translate([text_x,text_y,coin_thickness]) linear_extrude(height = text_height) { text(text,font=font, size=font_size); }
}
// Calculations
$fn = smoothness;

cutout_pos1_x = (cutout_diameter/2)+cutout_x_offset;
cutout_pos1_y = (cutout_diameter/2)+cutout_y_offset;
cutout_thickness = coin_thickness+2;

color([1,0.6,0]) difference() {
    union() {
        difference() {
            // Main coin part
            cylinder(h=coin_thickness,d=coin_diameter);
            if ( coin_head_style == "Sweeping Curve" ) {
                translate([sweeping_curve_x_offset, 0, -1]) scale([.4, 1, 1]) cylinder(h = coin_thickness+2, d = coin_diameter*2);
            }
        }
        // The handle
        hull() {
        translate([0,0,0]) cylinder(h=coin_thickness,d=handle_width1);

        // Cylinder at end of handle (keyring end)
        translate([handle_length,0,0]) cylinder(h=coin_thickness,d=handle_width2);
        }
    }

    union() {
        if( coin_head_style == "Dual Cutouts" ) {
            // Lower cutout
            translate([cutout_pos1_x,-cutout_pos1_y,-1]) cylinder(h=cutout_thickness,d=cutout_diameter);
            // Upper cutout
            translate([cutout_pos1_x,cutout_pos1_y,-1]) cylinder(h=cutout_thickness,d=cutout_diameter);
        }
        hull() {
            // RHS Hole
            translate([handle_length,0,-1]) cylinder(h=cutout_thickness,d=handle_cutout_hole_diameter1);
            // Left Hole
            translate([handle_length-keyring_hole_width,0,-1]) cylinder(h=cutout_thickness,d=handle_cutout_hole_diameter2);
        }

        // Optional cutout for the trolley coin part
        // Get the main circle and cut out two 'ears' from that
        // Then that will be subtracted from the main part
        
        if( coin_cutout == "yes") {
            if( coin_head_style == "Dual Cutouts" ) {            
                union() {
                    difference() {
                    // Optional cutout for coin part
                    translate([0,0,-1]) cylinder(h=coin_thickness+2,d=coin_diameter-(coin_cutout_border_thickness*2));
                    // Lower cutout
                    translate([cutout_pos1_x,-cutout_pos1_y,-1]) cylinder(h=cutout_thickness,d=cutout_diameter+coin_cutout_border_thickness*2);
                    // Upper cutout
                    translate([cutout_pos1_x,cutout_pos1_y,-1]) cylinder(h=cutout_thickness,d=cutout_diameter+(coin_cutout_border_thickness*2));
                }
            }
            }
        }
    }
}