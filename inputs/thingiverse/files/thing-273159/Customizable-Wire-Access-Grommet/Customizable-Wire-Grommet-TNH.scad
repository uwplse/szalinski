// Customizable Wire Access Grommet v1.3
// by TheNewHobbyist 2014 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:273159
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
//


  //////////////////////
 // Customizer Stuff //
//////////////////////


/* [Grommet Settings] */

//Select the diameter of the hole in table in mm
Grommet_Diameter = 40; // [20:90]

//Select the diameter if the access hole in mm
Hole_Diameter = 20; // [5:50]

/* [Text] */

//Rotate model to see text
Top_Text = "";

Font_Size = 8; // [5:20]

// Default is 8
Letter_Spacing = 1.3; // [1:Close, 1.3:Normal, 1.6:Far, 2:Very Far]

/* [Build Plate] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]
	
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


module solid_top(){
	translate([0,0,1.5]) cylinder(r1=(Grommet_Diameter/2)*1.2, r2=(Grommet_Diameter/2)*1.25,h=3, center=true);
	translate([0,0,5]) cylinder(r=((Grommet_Diameter/2)/1.14)-.1, h=4, center=true);	
}

module full_top(){
	union(){
		difference(){
			solid_top();
			translate([0,0,5.25]) cylinder(r=((Grommet_Diameter/2)/1.14)-3, h=5, center=true);	
			translate([Grommet_Diameter*.25,0,0]) cylinder(r=Hole_Diameter/2, h=40, center=true);	
			translate([Grommet_Diameter*.6,0,0]) cube([Grommet_Diameter*.75, Hole_Diameter, 40], center=true);
			rotate([180,0,0]) writecylinder(Top_Text,[0,0,0],Grommet_Diameter/1.5,0,space=Letter_Spacing,east=-90,face="top",center=true, h=Font_Size); 
		}	
	}
}

module solid_bottom(){
	translate([0,0,1.5]) cylinder(r=(Grommet_Diameter/2)*1.25, h=3, center=true);
	translate([0,0,10]) cylinder(r=(Grommet_Diameter/2), h=16, center=true);	
}

//module solid_bottom(){
//	translate([0,0,1.5]) cylinder(r=(Grommet_Diameter/2)*1.35, h=3, center=true);
//	translate([0,0,10]) cylinder(r=(Grommet_Diameter/2)*1.14, h=16, center=true);	
//}

module full_bottom(){
	union(){
		difference(){
			solid_bottom();
			cylinder(r=(Grommet_Diameter/2)/1.14, h=50, center=true);
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




