// Customizable Wire Access Grommet v1.3
// by TheNewHobbyist 2014 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:273159
// remixed by GreenEllipsis 2018
//
// "Customizable Wire Access Grommet" is licensed under a 
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//
// Description: 
// Updated version of my previous design (thing:7902). These should press fit securely
// together.
//
// Usage: 
// Use the sliders to select your desired diameter (in mm) for the grommet
// itself and the access hole cut into it.
//
// Enter text if desired for lid.
//
// Change Log:
// v1.0 CREATED
// v1.1 ADDED write.scad generated text on lid of grommet
// v1.2 UPDATED views for Customizer App
// v1.3 UPDATED diameter of table hole (thanks for the heads up daverees)
// v1.4 UPDATED by Green Ellipsis to add locking prongs and customizable hole depth. Made model more parametric in general.
// v1.41 BUG FIXES by Green Ellipsis



  //////////////////////
 // Customizer Stuff //
//////////////////////


/* [Grommet Settings] */

//Select the diameter of the hole in table in mm
Grommet_Diameter = 40; // [20:90]

//Select the diameter if the access hole in mm
Hole_Diameter = 20; // [5:50]

//Select the depth of the grommet in mm
Hole_Depth = 13; //[4:250]

/* [Text] */

//Rotate model to see text
Top_Text = ""; //  

// Default is 8
Font_Size = 8; // [5:20]

Letter_Spacing = 1.3; // [1:Close, 1.3:Normal, 1.6:Far, 2:Very Far]

/* [Build Plate] */

//For display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//When Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//When Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

/* [Locking Tabs] */

// Include tabs in top and slots in bottom.
locking_top = 0; //[0:No,1:Yes]

//* Include tabs in the bottom to lock to underside of hole.
locking_bottom = 0; //[0:No,1:Yes]
	
/* [Hidden] */

$fn=120;

// preview[view:south, tilt:top]

  /////////////////////////////////
 // No talking in the libraries //
/////////////////////////////////

 use <utils/build_plate.scad>
 use <write/Write.scad>
 

  ////////////////////
 // Moduletown USA //
////////////////////

shell_thickness = 3;
top_inner_radius = ((Grommet_Diameter/2)/1.14)-shell_thickness;
top_outer_radius = ((Grommet_Diameter/2)/1.14)-.1;
top_depth = 4;
tab_stem_radius = shell_thickness/4;
tab_stem_height = tab_stem_radius*4;
tab_radius = tab_stem_radius*3/2;

module tab_cutout() {
    // cut a recess for the tab 
    translate([-shell_thickness*1.1/2,0,-tab_stem_height/2+tab_radius]) cube([shell_thickness*1.1, tab_stem_radius*3, tab_stem_height-tab_radius], center=true);
}

// The tab will have its tab stem outer edge flush with the x-axis, will be centered on the y-axis and have the bottom of the tab at z=0. The stem will extend below z=0.
module tab() {
    // tab stem 
    translate([-tab_stem_radius,0,-tab_stem_height+tab_radius]) {
        cylinder(r=tab_stem_radius, h=tab_stem_height, center=false);
        // the tab itself
        translate([tab_radius-tab_stem_radius,0,tab_stem_height]) rotate([90,0,0])
            cylinder(r=tab_radius, h=tab_stem_radius*2, center=true);
    }
}
    

module solid_top(){
	translate([0,0,1.5]) cylinder(r1=(Grommet_Diameter/2)*1.2, r2=(Grommet_Diameter/2)*1.25,h=shell_thickness, center=true);
    if (locking_top == 0) {
        translate([0,0,5]) cylinder(r=top_outer_radius, h=top_depth, center=true);
    } else {
        difference() {
            translate([0,0,5]) cylinder(r=top_outer_radius, h=top_depth, center=true);
            translate([-(top_outer_radius),0,shell_thickness+top_depth]) rotate([0,0,180]) tab_cutout();
            translate([0,-(top_outer_radius),shell_thickness+top_depth]) rotate([0,0,-90]) tab_cutout();
            translate([0,(top_outer_radius),shell_thickness+top_depth]) rotate([0,0,+90]) tab_cutout();
        }
        // create tabs
        translate([-(top_outer_radius),0,shell_thickness+top_depth])  rotate([0,0,+180]) tab();
        translate([0,-(top_outer_radius),shell_thickness+top_depth]) rotate([0,0,-90]) tab();
        translate([0,(top_outer_radius),shell_thickness+top_depth]) rotate([0,0,+90]) tab();
    }
}

module full_top(){
    union(){
		difference(){
			solid_top();
			translate([0,0,5.25]) cylinder(r=top_inner_radius, h=5, center=true);	
			translate([Grommet_Diameter*.25,0,0]) cylinder(r=Hole_Diameter/2, h=40, center=true);	
			translate([Grommet_Diameter*.6,0,0]) cube([Grommet_Diameter*.75, Hole_Diameter, 40], center=true);
			rotate([180,0,0]) writecylinder(Top_Text,[0,0,0],Grommet_Diameter/1.5,0,space=Letter_Spacing,east=-90,face="top",center=true, h=Font_Size); 
		}	
	}
}

module solid_bottom(){
	cylinder(r=(Grommet_Diameter/2)*1.25, h=shell_thickness, center=false);
    if (locking_bottom == 0) {
        cylinder(r=(Grommet_Diameter/2), h=shell_thickness+Hole_Depth, center=false);
    } else {
        difference() {
        	cylinder(r=(Grommet_Diameter/2), h=shell_thickness+Hole_Depth, center=false);
            // tab cutouts
            translate([(Grommet_Diameter/2),0,shell_thickness+Hole_Depth]) rotate([0,0,0]) tab_cutout();
            translate([-(Grommet_Diameter/2),0,shell_thickness+Hole_Depth]) rotate([0,0,180]) tab_cutout();
            translate([0,-(Grommet_Diameter/2),shell_thickness+Hole_Depth]) rotate([0,0,-90]) tab_cutout();
            translate([0,(Grommet_Diameter/2),shell_thickness+Hole_Depth]) rotate([0,0,+90]) tab_cutout();
        }
        // create tabs
        translate([(Grommet_Diameter/2),0,shell_thickness+Hole_Depth])  rotate([0,0,0]) tab();
        translate([-(Grommet_Diameter/2),0,shell_thickness+Hole_Depth])  rotate([0,0,+180]) tab();
        translate([0,-(Grommet_Diameter/2),shell_thickness+Hole_Depth]) rotate([0,0,-90]) tab();
        translate([0,(Grommet_Diameter/2),shell_thickness+Hole_Depth]) rotate([0,0,+90]) tab();
    }
	
}

module full_bottom(){
	union(){
		difference(){
			solid_bottom();
			// center hole
            cylinder(r=(Grommet_Diameter/2)/1.14, h=250, center=false);
			// tab slot
            if (locking_top == 1) {
                translate([0,0,top_depth]) cylinder(r=(Grommet_Diameter/2)/1.14+tab_radius, h=tab_radius*2, center=false);
            }
		}
	}
}


  //////////////////////////
 // Put it all together! //
//////////////////////////

if (preview_tab == "Text"){
translate([-Grommet_Diameter*.8,0,0]) full_top();
translate([Grommet_Diameter*.8,0,0]) full_bottom();	
}

else if (preview_tab == "Build plate"){
translate([-Grommet_Diameter*.8,0,0]) full_top();
translate([Grommet_Diameter*.8,0,0]) full_bottom();
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
}

else{
	translate([-Grommet_Diameter*.8,0,0]) full_top();
	translate([Grommet_Diameter*.8,0,0]) full_bottom();
	build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
}




