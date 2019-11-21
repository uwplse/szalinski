// ************* Credits part *************

// Programmed by Fryns - December 2014

// Optimized for Customizer

// Uses Write.scad by HarlanDMii, published on Thingiverse 18-Jan-2012 (thing:16193)	 

// ************* Declaration part *************

/* [Phone] */
PhoneX=61.2;	
PhoneZ=9.2;	

/* [Design] */
Slack=1.0;
Height=40;
BaseHeight=12;
BackAngle=10; // 0-15
InnerAngle=2; // 0-3
WallThickness=2;
OutsideBand=4;

/* [Charger] */
ChargerX=10.6; 
ChargerZ=5.8; 
CSlack=0.2; // slack in hole for charger
CScrewDiameter=3.85;
CScrewCountersinkDiameter=8;
CScrewCountersinkDepth=10;
CScrewHoleLeft="Yes"; // [Yes,No]
CScrewHoleRight="No"; // [Yes,No]

/* [Mounting] */
holediameter=3;
countersink=3;
HoleDepthModifier=0;

/* [Text] */
TextYModifier=1;
font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose]
font_size=7;
text_depth=0.6;
text="Fryns";

/* [Hidden] */
Manifoldfix=0.01;
base_depth=sin(BackAngle)*(Height/2+BaseHeight);
Resolution=50;
CScrewHole=CScrewDiameter-0.1;

// ************* Executable part *************
use <write/Write.scad>

// to align with print bed
translate([0,-BaseHeight,0])
rotate([90,0,0])

{
// Text on front
	translate([0,BaseHeight/2+TextYModifier,(PhoneZ+2*WallThickness+text_depth)/2])
		color("red")		write(text,t=text_depth,h=font_size,center=true,font=font);

// Ensures holes for mounting
	difference(){
		Assembly();
		rotate([-BackAngle,0,0])
			translate([-PhoneX/4,BaseHeight+Height/2,-PhoneZ/2+HoleDepthModifier])
				color("red") hole();
		rotate([-BackAngle,0,0])
			translate([PhoneX/4,BaseHeight+Height/2,-PhoneZ/2+HoleDepthModifier])
				color("red") hole();
	}
}
module Assembly(){ // makes holder
	Angleback();
	translate([0,BaseHeight,0])
		Chargertop();
	Chargerbottom();
}	

module hole(){ // makes mounting holes
	translate([0,0,base_depth/2])
		rotate([0,0,360/16])
			cylinder(h = base_depth*2, r = holediameter/(2*cos(360/16)), $fn=8, center = true);
	translate([0,0,base_depth-countersink])
		cylinder(h = countersink, r1 = holediameter/2, r2 = (holediameter+2*countersink)/2, $fn=Resolution, center = false);
}

module Angleback(){ // makes back of holder in an angle
	translate([0,0,-(PhoneZ+2*WallThickness)/2])
	intersection(){
		translate([0,0,-(PhoneZ+2*WallThickness)/2])
			Outside(Height=Height+BaseHeight);
		rotate([-BackAngle,0,0])
			translate([-(PhoneX+WallThickness*2)/2,0,0])
				cube(size = [PhoneX+WallThickness*2,(Height+BaseHeight)*2,PhoneZ+2*WallThickness], center = false);
	}
}

module Chargerbottom(){ // makes bottom of holder
	difference(){
		Outside(Height=BaseHeight);
		cube(size = [ChargerX+CSlack,BaseHeight*2+Manifoldfix,ChargerZ+CSlack], center = true);

		if (CScrewHoleRight=="Yes") {
			translate([PhoneX/2+WallThickness-(PhoneX/2+WallThickness)/2,BaseHeight/2,0])
				rotate([0,90,0])
					rotate([0,0,360/16])
						cylinder(h=PhoneX/2+WallThickness+Manifoldfix,r=0.5*CScrewHole/cos(360/16), $fn=8, center=true); // screw hole right
	
			translate([PhoneX/2+WallThickness-CScrewCountersinkDepth/2,BaseHeight/2,0])
				rotate([0,90,0])
					rotate([0,0,360/16])
						cylinder(h=CScrewCountersinkDepth+Manifoldfix,r=0.5*CScrewCountersinkDiameter/cos(360/16), $fn=8, center=true); // Countersink screw hole right
		}
		if (CScrewHoleLeft=="Yes") {
			translate([-PhoneX/2-WallThickness+(PhoneX/2+WallThickness)/2,BaseHeight/2,0])
				rotate([0,90,0])
					rotate([0,0,360/16])
						cylinder(h=PhoneX/2+WallThickness+Manifoldfix,r=0.5*CScrewHole/cos(360/16), $fn=8, center=true); // screw hole left

			translate([-PhoneX/2-WallThickness+CScrewCountersinkDepth/2,BaseHeight/2,0])
				rotate([0,90,0])
					rotate([0,0,360/16])
						cylinder(h=CScrewCountersinkDepth+Manifoldfix,r=0.5*CScrewCountersinkDiameter/cos(360/16), $fn=8, center=true); // Countersink screw hole left
		}
	}
}

module Chargertop(){
	difference(){
		Outside(Height=Height);
		Inside();
		Front();
	}
}

module Front(){
	translate([0,Height/2+Manifoldfix,WallThickness+Manifoldfix])
		cube(size = [PhoneX-OutsideBand*2,Height+2*Manifoldfix,PhoneZ], center = true);
}


module Outside(Height){
	translate([0,Height/2,0])
		cube(size = [PhoneX+WallThickness*2,Height,PhoneZ+2*WallThickness], center = true);
}


module Inside(){
	translate([0,Height/2,0])
		cube(size = [PhoneX+Slack,Height,PhoneZ+Slack], center = true);
	translate([-(PhoneX+Slack)/2,0,-(PhoneZ+Slack)/2])
			rotate([-InnerAngle,0,0])
				cube(size = [PhoneX+Slack,Height,PhoneZ+Slack], center = false); // Angled inside
}

