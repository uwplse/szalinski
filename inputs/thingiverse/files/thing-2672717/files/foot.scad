/* ----------------------------------------
	Setting
---------------------------------------- */

// what shape does the table-foot have?
foot_shape = "square"; // [square, cylinder]

// diameter of the table-foot
diameter_foot = 30.5; // [10:100]

// what height should be added to your table foot?
foot_height = 80; // [10:100]

// how much 
roundness = 20; // [0:40]

// how deep can the table foot be inserted? standard is just the foot height defined obove
foot_inset_height = foot_height;

/* ----------------------------------------
	Code
---------------------------------------- */

translate([0,0,roundness/2]) {
	difference () {
		
		// cylinder
		translate([
			(diameter_foot/100*180)/2,
			(diameter_foot/100*180)/2,
			0
		]) {
			minkowski() {
				cylinder(
					d = diameter_foot*2-(roundness),
					h = foot_height+foot_inset_height-roundness,
					$fn = 200
				);
				sphere(d=roundness, $fn=64);
			}
		}
		
		// foot inset
		translate([
			(diameter_foot/100*180)/2-diameter_foot/2,
			(diameter_foot/100*180)/2-diameter_foot/2,
			foot_height-roundness/2
		]) {
			if (foot_shape == "square") {
				cube([diameter_foot, diameter_foot, foot_inset_height/100*120]);
			}
			else {
				translate([diameter_foot/2,diameter_foot/2,0])
				cylinder(d=diameter_foot, h=foot_inset_height/100*120);
			}
		}
		
	}
}