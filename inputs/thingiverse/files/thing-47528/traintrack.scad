//in mm. Minimum 40 for female-female
track_length=25;
track_option=2; // [1:male-male, 2:male-female, 3: female-female]

//track extrusion
module track(){
	translate([-20,0,0])
	rotate (a=[90,0,0]) linear_extrude(height =track_length, center = true) polygon(points = [ [0,0], [0,9], [1,12],[4,12],[5,9],[10,9],[11,12],[29,12],[30,9],[35,9],[36,12], [39,12],[40,9], [40,0]], path = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]]);
}

//peg male
module peg(){
	translate ([0,-12,0])
	union(){
		cylinder(12,5.9,5.9);
		translate ([-3,5,0]) cube(size=[6,8,12]);
	}
}

//peg cut female
module peg_cut(){
	translate ([0,-11.9,-1])
	union(){
		cylinder(14,6.6,6.6);
		translate ([-3,5,0]) cube(size=[7,8,14]);
	}
}

//male-male track
module mm_track (){
translate ([0,-track_length/2,0]) peg();
translate ([0,track_length/2,0]) rotate(a=[0,0,180]) peg();
track ();
}

//male-female track
module mf_track (){
	translate ([0,track_length/2,0]) rotate(a=[0,0,180]) peg();
	difference() {
		track();
		translate ([0,-track_length/2,0]) rotate(a=[0,0,180]) peg_cut();	
	}
}

//female-female track
module ff_track (){
	difference() {
		track();
		translate ([0,-track_length/2,0]) rotate(a=[0,0,180]) peg_cut();
		translate ([0,track_length/2,0])  peg_cut();	
	}
}
if (track_option==1) {
	mm_track();
}
if (track_option==2) {
	mf_track();
}
else
{
	ff_track();
}
