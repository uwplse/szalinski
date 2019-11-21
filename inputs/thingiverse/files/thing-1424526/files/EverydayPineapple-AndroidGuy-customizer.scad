
// Slightly Better Android Guy
// Customized by EverydayPineapple from vorpal's 
// design with a few improvements.
// 1. made the legs fit
// 2. made the leg holes go all the way through

//
// Customizable Android Guy Box with Text by Vorpal
//
// Based on Thingiverse thing:7734 "Android Guy Box with Base" by rhmorrison
// which itself was based on thing:5917 "Android Guy Box" by irdfang
// which was inspired by thing:1902 "Android Guy" by xtremd but reimplemented in openscad
//
// This project also uses thing:16193 "Write" by HarlanDMii
//
// My contributions are:
//
// 1. Made it all into a single openscad program that is customizable using makerbot customize.
//
// 2. Made it so the arms are moveable. The other versions have fixed arms because it's a 
//    square peg. I also made a socket and cut-ball arrangement so the parts just snap 
//    together without glue. Although you may need to heat up the body hole to get the arms in.
//
// 3. Made numerous small adjustments to the sizes of things to make them more closely match
//    the proportions of the real android logo. The prior versions were a little too tall.
//
// 4. Added the ability to emboss 2 lines of text on the body. This was originally done so I
//    could make trophy-like gifts for my son's NJ Governor School team who wrote some Android
//    apps for Erikson Telecom. I made a large sized version for the mentor of the group.
//
// 5. Made it so the script could either generate individual parts or generate the entire
//    project on a single platen which is printable with no supports. Also added two "preview"
//    modes that are not meant to be printed. One shows the entire thing assembled, the other
//    is an exploded view. Again, don't try to print those, you would need tons of supports.
//

use <write/Write.scad>

//
// The parameters below may be changed by the customizer
//
// BEGIN CUSTOMIZER

/* [Android Guy Parameters] */

//select part(s) to render
parts_to_render = 8; // [1:head, 2:body, 3:arm, 4:leg, 5:base, 6:preview_assembled, 7:preview_exploded, 8:all]

// Draft for preview, production for final
Render_Quality = 24;    // [24:Draft,60:Production,100:UltraPremium]

// mm
text_height=8; // [6:15]

text_font = "orbitron.dxf";//[write/Letters.dxf,write/orbitron.dxf,write/knewave.dxf,write.braille.dxf,write/Blackrose.dxf]

// top line of text
text1 = "@EvrydyPineapple";
//bottom line of text
text2 = "";
//move the text up by this much, mm
text_shift = 0; // [-20:20]

// approx. height when assembled, mm
Project_Size = 125; // [100:250]

// END CUSTOMIZER


//
// The parameters below are not meant to be changed by the customizer
//

arm_r = 9*1;
// how deep do the letters cut
emboss_depth = 3*1;
$fn = Render_Quality;
leg_h = 25*1;
scale_factor = 156*1;  // at project_size of this size the scaling factor is 1

module body() {
	difference(){	
		union(){
			cylinder(r=35,h=53);
			translate([0,0,-14]) cylinder(r=21,h=70);
			rotate_extrude(convexity = 15) translate([21,0,0]) circle(r=14);
		}

		// hollow it out
		translate([0,0,-7]) cylinder(r=31.5,h=78);
	
		// holes for arms
		translate([0,0,36]) {
			rotate(90, [0,1,0]) cylinder(r=5, h=80, center=true);
		}
	
		// holes for legs
		translate([14.7,0,-28]) cylinder(r=8.4,h=30);
		translate([-14.7,0,-28]) cylinder(r=8.4,h=30);
	
		writecylinder(text1,[0,0,0],radius=35,height=50,t=3,up=text_shift+1.2*text_height/2,h=text_height,font=text_font);
		writecylinder(text2,[0,0,0],radius=35,height=50,down=0-text_shift+1.2*text_height/2,t=3,h=text_height,font=text_font);
	}
}

module arm() {
	rotate([90,270,0]){ 
	union(){
		rotate(90, [0,1,0]) translate([-2,0,10]) difference() {
			union() {
				cylinder(r=4.5, h=10, center=true);
			 	translate([0,0,5]) cylinder(r1=4.5,r2=5.5, h=2, center=true);
			 	translate([0,0,8.5]) cylinder(r1=5.5,r2=3, h=5, center=true);
			}
		}
		cylinder(r=arm_r,h=28);
		sphere(r=arm_r);
		translate([0,0,28])sphere(r=arm_r);
		}
	}
}

module base() {
	union() { 
		rotate([180,0,0]) {
			difference(){ 
				union(){
					cylinder(r=35,h=70);
					translate([0,0,-14]) cylinder(r=21,h=70);
					rotate_extrude(convexity = 10)
					translate([21,0,0])
						circle(r=14);
				}
				translate([0,0,50])
				cube([100,100,100], center=true); 
				translate([14.7,0,-44])
					cylinder(r=9,h=45);
				translate([-14.7,0,-44])
					cylinder(r=9,h=45);
			}
		}
		cylinder(r1=50,r2=47,h=6);
	}
}

module head() {
	rotate([0,180,0]){ 
	union(){
		translate([0,0,-5]) cylinder(r=31.25, h=16);
		translate([0,0,-5]) 
		difference(){
			sphere(r=35);
			cylinder(r=35,h=35);
			translate([15,-25,-16]) sphere(r=5);
			translate([-15,-25,-16]) sphere(r=5);
		}
		translate([-20,0,-51]) rotate([0,15,0]) cylinder(r=3,h=20);
		translate([20,0,-51]) rotate([0,-15,0]) cylinder(r=3,h=20);
		translate([20,0,-51]) sphere(r=3,h=20);
		translate([-20,0,-51]) sphere(r=3,h=20);	
		}
	}
}


module leg() {
	union(){ 
		cylinder(r=8.9,h=leg_h);
		translate([0,0,leg_h]) cylinder(r=8.3,h=8);
		translate([0,0,leg_h]) rotate_extrude(convexity = 10) translate([5.5,0,0]) circle(r=4);
	}
}

color("LightGreen")
scale([Project_Size/scale_factor, Project_Size/scale_factor, Project_Size/scale_factor]) {

	if (parts_to_render == 1) {
		head();
	}
	if (parts_to_render == 2) {
		body();
	}
	if (parts_to_render == 3) {
		arm();
	}
	if (parts_to_render == 4) {
		leg();
	}
	if (parts_to_render == 5) {
		base();
	}

	if (parts_to_render == 6) {
		// approximate how it would look assembled
		union() {
			base();
			translate([14.5,0,28+leg_h/2]) rotate([0,180,0]) leg();
			translate([-14.5,0,28+leg_h/2]) rotate([0,180,0]) leg();
			translate([0,0,50]) body();
			translate([44,0,88]) rotate([90,0,-90]) arm();	
			translate([-44,0,84]) rotate([90,180,90]) arm();
			translate([0,0,105]) head();
		}
	}

	if (parts_to_render == 7) {
		// exploded parts view
		union() {
			base();
			translate([14.5,0,1.3*(28+leg_h/2)]) rotate([0,180,0]) leg();
			translate([(-14.5),0,1.3*(28+leg_h/2)]) rotate([0,180,0]) leg();
			translate([0,0,1.5*(50)]) body();
			translate([1.5*(44),0,1.3*88]) rotate([90,0,-90]) arm();	
			translate([1.5*(-44),0,1.3*84]) rotate([90,180,90]) arm();
			translate([0,0,1.4*105]) head();
		}
	}

	if (parts_to_render == 8) {
		// create a production plate layout with all parts
		translate([100,-30,11]) head();
		translate([0,70,14])    body();
		translate([50,0,arm_r])    arm();
		translate([50,80,arm_r]) arm();
		translate([80,50,0]) leg();
		translate([80,80,0]) leg();
		translate([-20,-20,0]) base();
	}

} // end scale