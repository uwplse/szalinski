
/* [General Dimensions] */
//Wall thickness
thickness=5;
//Radius of the rounded corner (corner of the amp)
roundedCorner_radius=10;
//Length of the top of the holter (must be long enough to reach a screw hole).
topBar_length=40;
//Distance between the end of the upper tab and the start of the screw hole. 
screwHole_border2borderDistance=5;

/* [Jack Dimensions] */
//diameter of the Jack head hole
jackHead_diameter=16;
//Height of the holder
jackHead_length=40;
//Diameter of the cable hole. Will be also used for the slot
jackCable_diameter=9;

/* [Scew hole Dimensions] */
//Diameter of the shaft hole
screwShaft_diameter=4.2;
//Diameter for the head hole
screwHead_diameter=9;


/* [Hidden] */
$fn=36;
marginForOverlap = 0.1;
defaultHoleLength=100;

topBar_with=jackHead_diameter+thickness*2;

topBar_dim= [topBar_length, topBar_with, thickness];

screwHole_border2borderDistance=5;
screwSlot_length=topBar_length-roundedCorner_radius-screwHole_border2borderDistance-screwHead_diameter;

elongatedScrewLength=screwSlot_length+screwHead_diameter;


screw_distance=topBar_length-(elongatedScrewLength/2)-screwHole_border2borderDistance;
screw_position=[screw_distance, topBar_with/2, thickness/2];

marginForOverlap=0.1;



topBar();
holder();
difference(){
		translate([0,0,-roundedCorner_radius])cube([roundedCorner_radius,topBar_with,roundedCorner_radius]);
	translate([roundedCorner_radius,topBar_with+marginForOverlap,-roundedCorner_radius])rotate([90,0,0])cylinder(r=roundedCorner_radius, h=topBar_with+marginForOverlap*2);
}
module topBar(){
	difference(){
	cube(topBar_dim);
	translate(screw_position) elongatedScrewHole(screwShaft_diameter, screwHead_diameter,screwSlot_length);
	}
}

module holder(){
	holder_length=jackHead_diameter+thickness*2;
	holder_height=jackHead_length+thickness;
	box_length =holder_length/2;
	
	translate([-box_length,0,-(holder_height-thickness)]){
		difference(){
			union(){
				cube([box_length,topBar_with,holder_height]);
				translate([0,topBar_with/2,0]){
						cylinder(d=topBar_with, h=holder_height);
				}
			}
			translate([0,topBar_with/2,0]){
				translate([0,0,thickness+marginForOverlap])cylinder(d=jackHead_diameter, h=holder_height-thickness);
				translate([0,0,-thickness/2])cylinder(d=jackCable_diameter, h=thickness*2);
			}
			slot_position=[-holder_length/2,topBar_with/2-jackCable_diameter/2,-marginForOverlap];
			translate(slot_position)cube([holder_length/2,jackCable_diameter,holder_height+marginForOverlap*2]);
		}
	}
}

module screwHole(shaftDiam, headDiam, shaftLength=defaultHoleLength, headLength=defaultHoleLength){
		translate([0,0,-shaftLength+marginForOverlap])cylinder(d=shaftDiam, h=shaftLength);
		cylinder(d=headDiam, h=headLength);
}

module elongatedScrewHole(shaftDiam, headDiam, elongation, shaftLength=defaultHoleLength, headLength=defaultHoleLength ){
	translate([-elongation/2,0,0])screwHole(shaftDiam, headDiam, shaftLength, headLength);
	translate([0,0,headLength/2])cube([elongation,headDiam,headLength], center=true);
		translate([0,0,-shaftLength/2+marginForOverlap])cube([elongation,shaftDiam,shaftLength], center=true);
	translate([elongation/2,0,0])screwHole(shaftDiam, headDiam, shaftLength, headLength);
}