/////////////////////////////////////////////////////////////////
// Parametric Test Print Model
// Version: V1.03
// Author: thorgal (2019-05-11)
// Program: OpenSCAD Version 2019.01 RC4
// Licensed: Creative Commons - Attribution - Non-Commercial - Share Alike (by-nc-sa)
// Source: https://www.thingiverse.com/thing:3610548
//
// Usefull for slopes, outer dimensions, moire and other issues
//
// You can make the model solid or hollow to save filament
// or resin. You can insert as many sloped blocks as you like.
// Just keep the list in square brackets separated with commas
// If you will use just one angle of 0 degrees (angles = [0]),
// than the result will be plain box.
// Negative angles and angle sizes above 90 degrees are 
// recalculated to fit between 0 and 90 degrees.
// Type angle 90degrees to make a bridge instead of slope.
// Manual text adjustment is required and model have to be
// checked visualy prior to exporting as my programming skill
// in OpenSCAD is not good enough to check all the dependences.
// Sorry for inconvenience.
//
// You are using this model at your own risk. Whenever you are
// experimenting with print quality, do not keep the printer
// unattended. Keep in mind that model created with this
// parametric tool may not be printable.
//
// Enjoy
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
// Parameters
/////////////////////////////////////////////////////////////////

// Mass of sloped blocks
shells = 1; // [1:Solid,2:Shell]

// Display labels
labels = 3; // [0:None,1:Plains,2:Numbers,3:All]

// Width (X axis size of the whole model, will be divided by number of blocks)
cube_x = 60; // [5:1:100]

// Depth (Y axis size of the whole model and each sloped block)
cube_y = 33; // [5:1:100]

// Height (Z axis size of the whole model, block and base together )
cube_z = 10; // [5:1:100]

// Base wall thickness for XY, XZ and YZ plane
base_th = 2.0; //[0.1:0.1:5.0]

// Gap between sloped blocks (if more than one block required)
block_gap = 1.0; // [0.0:0.1:5.0]

// List of slopes and number of block (0 is vertical, 90 means bridge; separate numbers with comma; at the begining and end have to be a square bracket, atleast one value have to be specified, [0] makes a box)
angles = [0,15,30,45,60,75,90]; //

// Block shell thickness
shell_th = 1.5; //[0.1:0.1:5.0]

// Font size (change it according to size of the model so all texts will be visible)
font_size = 3; //[1.5:0.5:10.0]

// Level of detail for the STL mesh (mostly for texts)
detail = 8; // [8:Draft, 16:Coarse, 32:Medium, 64:High, 128:Ultra]

/* [Hidden] */
block_count = len(angles); // Number of blocks
block_width = (cube_x - (block_gap*(block_count-1)))/block_count; //Width of each block
switch_angle = atan((cube_y-base_th)/(cube_z-base_th)); // Maximal angle that can be made from front to bottom making front sharp edge. Above this angle the slope is made from bottom to front making flat surface in front of the block.
a = 0.1*1; // Add for substraction. Required for OpenSCAD to do the substraction correctly.
font = "Roboto"; // Font used for dimensions and descriptions
font_extr = base_th/3; // Font extrusion depth
font_spacing = 1; // Space between lines of text
spacing = 1*1; // Font spacing
$fn = detail; // Number of faces per circle

/////////////////////////////////////////////////////////////////
// Main 3D model
/////////////////////////////////////////////////////////////////

draw ();

module draw () {
    difference () {
        union () {
            if (shells == 1) draw_solids ();
            if (shells == 2) draw_shells ();
            draw_corner ();
        }
        if (labels == 1) draw_labels ();
        if (labels == 2) draw_numbers ();
        if (labels == 3) draw_labels_and_numbers ();
    }
}

/////////////////////////////////////////////////////////////////
// This will create solid blocks with slopes
/////////////////////////////////////////////////////////////////
module draw_solids (){
    for (i = [0:1:block_count-1]) { // draw slopes according to the list
        angle = (360+angles[i]) % 90; // make the angle positive and less or equal to right angle
        if (angles[i]!=0 && angle==0) { // if there was right angle => draw a bridge instead of slope
            difference () {
                translate([(i*(block_width+block_gap)),base_th,base_th]) cube([block_width,cube_y-base_th,cube_z-base_th], center = false);
                translate([(i*(block_width+block_gap))-a,base_th-a,base_th-a]) cube([block_width+(2*a),cube_y-base_th-base_th+a,cube_z-(base_th*2)+a], center = false);
            }
        }
        else { // if angle is less than horizontal draw a slope
            if (angle <= switch_angle) { // draw a slope from front
                intersection () { // draw a block_width slope from front
                    translate([(i*(block_width+block_gap)),base_th,base_th]) cube([block_width,cube_y-base_th,cube_z-base_th], center = false);
                    translate([(i*(block_width+block_gap)),cube_y,cube_z]) rotate([180-angle,0,0]) cube([block_width,cube_y+cube_z,cube_y+cube_z], center = false);
                }
            }
            else { // otherwise draw a slope from back
                intersection () { // draw a block_width slope from bottom
                    translate([(i*(block_width+block_gap)),base_th,base_th]) cube([block_width,cube_y-base_th,cube_z-base_th], center = false);
                    translate([(i*(block_width+block_gap)),base_th,base_th]) rotate([90-angle,0,0]) cube([block_width,cube_y+cube_z,cube_y+cube_z], center = false);
                }
            }
        }
    }
}

/////////////////////////////////////////////////////////////////
// This will create shells with slopes
/////////////////////////////////////////////////////////////////
module draw_shells (){
    for (i = [0:1:block_count-1]) { // draw slopes according to the list
        angle = (360+angles[i]) % 90; // make the angle positive and less or equal to right angle
        if (angles[i]!=0 && angle==0) { // if there was right angle => draw a bridge instead of slope
            difference () {
                translate([(i*(block_width+block_gap)),base_th,base_th]) cube([block_width,cube_y-base_th,cube_z-base_th], center = false);
                translate([(i*(block_width+block_gap))-a,base_th-a,base_th-a]) cube([block_width+(2*a),cube_y-base_th-base_th+a,cube_z-(base_th*2)+a], center = false);
            }
        }
        else { // if angle is less than horizontal draw a slope
            if (angle <= switch_angle) { // draw a slope from front
                difference () {
                    intersection () { // draw a block_width slope from front
                        translate([(i*(block_width+block_gap)),base_th,base_th]) cube([block_width,cube_y-base_th,cube_z-base_th], center = false);
                        translate([(i*(block_width+block_gap)),cube_y,cube_z]) rotate([180-angle,0,0]) cube([block_width,cube_y+cube_z,cube_y+cube_z], center = false);
                    }
                    intersection () { // substract infill
                        translate([(i*(block_width+block_gap))+shell_th,base_th-a,base_th-a]) cube([block_width-(2*shell_th),cube_y-base_th+(2*a),cube_z-base_th+(2*a)], center = false);
                        translate([(i*(block_width+block_gap))+shell_th,cube_y-(cos(angle)*shell_th)+(sin(angle)*a),cube_z+(sin(angle)*shell_th)+(cos(angle)*a)]) rotate([180-angle,0,0]) cube([block_width-(2*shell_th),cube_y+cube_z,cube_y+cube_z], center = false);
                    }
                }
            }
            else { // otherwise draw a slope from back
                difference () {
                    intersection () { // draw a block_width slope from bottom
                        translate([(i*(block_width+block_gap)),base_th,base_th]) cube([block_width,cube_y-base_th,cube_z-base_th], center = false);
                        translate([(i*(block_width+block_gap)),base_th,base_th]) rotate([90-angle,0,0]) cube([block_width,cube_y+cube_z,cube_y+cube_z], center = false);
                    }
                    intersection () { // substract infill
                        translate([(i*(block_width+block_gap))+shell_th,base_th-a,base_th-a]) cube([block_width-(2*shell_th),cube_y-base_th-shell_th+a,cube_z-base_th+(2*a)], center = false);
                        translate([(i*(block_width+block_gap))+shell_th,base_th-(cos(angle)*shell_th)-(sin(angle)*a),base_th+(sin(angle)*shell_th)-(cos(angle)*a)]) rotate([90-angle,0,0]) cube([block_width-(2*shell_th),cube_y+cube_z,cube_y+cube_z], center = false);
                    }
                }
            }
        }
    }
}

/////////////////////////////////////////////////////////////////
// Three main plains reinforced to measure outer dimensions
/////////////////////////////////////////////////////////////////
module draw_corner (){
    difference() {
            cube([cube_x,cube_y,cube_z], center = false);
            translate([base_th,base_th,base_th]) cube([cube_x-base_th+a,cube_y-base_th+a,cube_z-base_th+a], center = false);
        }
}

/////////////////////////////////////////////////////////////////
// Draw only centered cartesian plains description
/////////////////////////////////////////////////////////////////
module draw_labels (){
    // YZ plane
    translate([font_extr,cube_y/2,cube_z/2]) rotate([90,0,-90]) linear_extrude(height=font_extr+a) text(text = "YZ", font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
    // XY plane
    translate([cube_x/2,cube_y/2,font_extr]) rotate([0,180,180]) linear_extrude(height=font_extr+a) text(text = "XY", font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
    // XZ plane
    translate([cube_x/2,font_extr,cube_z/2]) rotate([90,0,0]) linear_extrude(height=font_extr+a) text(text = "XZ", font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
}

/////////////////////////////////////////////////////////////////
// Draw just centered dimensions and slopes
/////////////////////////////////////////////////////////////////
module draw_numbers (){
    echo ("numbers", labels);
    // XY plane
    if (shells == 1 && block_count == 1) { // if possible ommit line with thickness
        translate([cube_x/2,cube_y/2,font_extr]) rotate([0,180,180]) linear_extrude(height=font_extr+a) text(text = str(cube_x,"x",cube_y,"x",cube_z,"mm"), font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
    }
    else { // otherwise print all dimensions
        translate([cube_x/2,cube_y/2-((font_size+font_spacing)/2),font_extr]) rotate([0,180,180]) linear_extrude(height=font_extr+a) text(text = str(cube_x,"x",cube_y,"x",cube_z,"mm"), font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
        translate([cube_x/2,cube_y/2+((font_size+font_spacing)/2),font_extr]) rotate([0,180,180]) linear_extrude(height=font_extr+a) text(text = str(base_th,"/",shell_th,"/",block_gap,"mm"), font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
    }
    // XZ plane
    for (i = [0:1:block_count-1]) { // draw slope size according to the list
        angle = (360+angles[i]) % 90;
        if (angles[i]!=0 && angle==0) { // if bridge make it 90 degrees
            angle = 90;
            translate([cube_x-((block_count-i-1)*(block_width+block_gap))-(block_width/2),font_extr,cube_z/2]) rotate([90,0,0]) linear_extrude(height=font_extr+a) text(text = str(angle), font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
        }
        else { // otherwise print the corrected angle number
            translate([cube_x-((block_count-i-1)*(block_width+block_gap))-(block_width/2),font_extr,cube_z/2]) rotate([90,0,0]) linear_extrude(height=font_extr+a) text(text = str(angle), font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
        }
    }
}

/////////////////////////////////////////////////////////////////
// Draw cartesian plains description, dimensions and slopes
/////////////////////////////////////////////////////////////////
module draw_labels_and_numbers(){
    // YZ plane
    translate([font_extr,cube_y/2,cube_z/2]) rotate([90,0,-90]) linear_extrude(height=font_extr+a) text(text = "YZ", font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
    // XY plane
    if (shells == 1 && block_count == 1) { // if possible ommit line with thickness
        translate([cube_x/2,cube_y/2-((font_size+font_spacing)/2),font_extr]) rotate([0,180,180]) linear_extrude(height=font_extr+a) text(text = "XY", font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
        translate([cube_x/2,cube_y/2+((font_size+font_spacing)/2),font_extr]) rotate([0,180,180]) linear_extrude(height=font_extr+a) text(text = str(cube_x,"x",cube_y,"x",cube_z,"mm"), font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
    }
    else { // otherwise print all dimensions
        translate([cube_x/2,cube_y/2-(font_size+font_spacing),font_extr]) rotate([0,180,180]) linear_extrude(height=font_extr+a) text(text = "XY", font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
        translate([cube_x/2,cube_y/2,font_extr]) rotate([0,180,180]) linear_extrude(height=font_extr+a) text(text = str(cube_x,"x",cube_y,"x",cube_z,"mm"), font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
        translate([cube_x/2,cube_y/2+(font_size+font_spacing),font_extr]) rotate([0,180,180]) linear_extrude(height=font_extr+a) text(text = str(base_th,"/",shell_th,"/",block_gap,"mm"), font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
    }
    // XZ plane
    if (block_count == 1) { // if possible ommit the line with slopes
        angle = (360+angles[0]) % 90;
        if (angles[0]!=0 && angle==0) { // if bridge make it 90 degrees
            angle = 90;
        }
        if (angle == 0) { // if the angle is O draw just XZ label
            translate([cube_x/2,font_extr,cube_z/2]) rotate([90,0,0]) linear_extrude(height=font_extr+a) text(text = "XZ", font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
        }
        else { // otherwise draw XZ label with one slope
            translate([cube_x/2,font_extr,(cube_z/2)+((font_size+font_spacing)/2)]) rotate([90,0,0]) linear_extrude(height=font_extr+a) text(text = "XZ", font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
            translate([cube_x/2,font_extr,(cube_z/2)-((font_size+font_spacing)/2)]) rotate([90,0,0]) linear_extrude(height=font_extr+a) text(text = str(angle), font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
        }
    }
    else { // otherwise print XZ label with list of slopes
        translate([cube_x/2,font_extr,(cube_z/2)+((font_size+font_spacing)/2)]) rotate([90,0,0]) linear_extrude(height=font_extr+a) text(text = "XZ", font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
        for (i = [0:1:block_count-1]) { // draw slope size according to the list
            angle = (360+angles[i]) % 90;
            if (angles[i]!=0 && angle==0) { // if bridge make it 90 degrees
                angle = 90;
                translate([cube_x-((block_count-i-1)*(block_width+block_gap))-(block_width/2),font_extr,(cube_z/2)-((font_size+font_spacing)/2)]) rotate([90,0,0]) linear_extrude(height=font_extr+a) text(text = str(angle), font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
            }
            else { // otherwise print the corrected angle number
                translate([cube_x-((block_count-i-1)*(block_width+block_gap))-(block_width/2),font_extr,(cube_z/2)-((font_size+font_spacing)/2)]) rotate([90,0,0]) linear_extrude(height=font_extr+a) text(text = str(angle), font = font, size = font_size, spacing = spacing, valign = "center", halign= "center");
            }
        }
     }
}
/////////////////////////////////////////////////////////////////
// End of the script
/////////////////////////////////////////////////////////////////