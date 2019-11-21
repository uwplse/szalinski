//peg length: 6 mm
//peg diameter: 10 mm
//roll length: 130 mm
//roll diameter: 42 mm

// width of the outer part of roll
roll_width = 15; // [8:20]

//width of the outer rings (stupid values relative to other parameters)
ring_width = 5; // [1:8]

//Ring thickness, try to get this as thin as possible
ring_height = 1; //[.5:3]

//How tall the roll actually is
actual_roll_length = 132; // [100:160]

//how much space between the inner beam and the exoskeleton
inner_clearance = 2; //[1:8]

//How many rings to create
rings = 20;	// [5:40]

//How many pillars per layer
pillars = 3; // [3:5]

//how high to make each cap
cap_height = 5; // [5:40]

//diameter of the peg
peg_width = 4;	// [2:10]	

//length of the peg
peg_length = 3;	// [2:4]

//thickness of pillars, make this thicker for strength
pillar_thickness = 1; // [1:5]

cap_a = (peg_length * 5);			//How much give between the beam

quality = 150;		//resolution of polygon stuff

roll_length = actual_roll_length - (cap_height * 2) - 1;	//How tall the skelleton roll is

//Create just one ring. A argument of how high on the Y axis to place this is passed
module ring(y_height) {
	translate([0,0,y_height])
	difference() {
		linear_extrude(height = ring_height, center = true) {circle(roll_width, $fn=quality);}
		linear_extrude(height = ring_height, center = true) {circle(roll_width - ring_width, $fn=quality);}
	}
}

module rings() {
	increments = (roll_length / (rings - 1));
	translate([0,0,ring_height]) {for (a =[0:increments:roll_length]) ring(a - ring_height);}
}

module pillars(y_height) {
	height = (roll_length / (rings - 1));
	pillars_adjusted = 360 / pillars;
	translate([0,0,y_height - .5]) {
		for (a =[0:pillars_adjusted:360]) rotate([0,0,a]) {translate([0,roll_width-5,0]) {cube([pillar_thickness,5,height]);}}
	}
}

module pillars_run() {
	increments = ((roll_length / (rings - 1)) * 2);
	translate([0,0,ring_height]) {for (a =[0:increments:roll_length]) pillars(a - ring_height);}
}

module pillars_run2() {
	offset = (roll_length / (rings - 1));
	pillars_adjusted = 360 / pillars;
	pillars_offset = (360 / pillars) + (pillars_adjusted / 2);
	translate([0,0,offset]){
		rotate([0,0,pillars_offset]) {pillars_run();}
	}
}

difference() {
	union() {
		rings();
		linear_extrude(height = roll_length - cap_a) {circle(roll_width - ring_width - inner_clearance, $fn=quality);}
		pillars_run();
		pillars_run2();
	}
	union() {
		translate([0,0,roll_length]) {
			linear_extrude(height = roll_length) {circle(roll_width + 10);}
		}
	}
}

translate([0,0,roll_length - 1]) {
	linear_extrude(height = cap_height) {circle(roll_width, $fn=quality);}
	linear_extrude(height = cap_height + peg_length) {circle(peg_width, $fn=quality);}
}

translate([0,0,- cap_height]) {
	linear_extrude(height = cap_height) {circle(roll_width, $fn=quality);}
	translate([0,0,-peg_length]){
		linear_extrude(height = peg_length) {circle(peg_width, $fn=quality);}
	}
}