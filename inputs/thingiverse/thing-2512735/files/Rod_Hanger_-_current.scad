$fn=80;

rodRadius = 15; // include padding
hangerWidth = 25;  // width of the hanger
hangerArmThickness = 15; // thickness of the arm
hangerArmLength = 20; // distance from wall
wallMountExtension = 90; // extension above and below the main arms for screw holes

// rod hole
difference(){
	cylinder (hangerWidth,rodRadius+10, rodRadius+10, false);
	cylinder (hangerWidth*3,rodRadius, rodRadius, true);
}

// straight mount
translate([-hangerArmThickness/2,rodRadius,0])
	cube([hangerArmThickness, hangerArmLength, hangerWidth], false);
	
// support	
rotate([0,0,-45])
	translate([-hangerArmThickness/2,rodRadius,0])
		cube([hangerArmThickness, sqrt(pow(hangerArmLength,2) + pow(hangerArmLength,2)) + hangerArmThickness, hangerWidth], false);	
		
		
// wall mount
difference(){
translate([(hangerArmLength + hangerArmThickness + (wallMountExtension / 2) + 10) - (hangerArmThickness/2),hangerArmLength + rodRadius,0])
rotate([0,0,90])
cube([hangerArmThickness, hangerArmLength + hangerArmThickness + wallMountExtension, hangerWidth], false);

// screw holes
translate([(hangerArmLength + hangerArmThickness + (wallMountExtension / 2) + 10) - (hangerArmThickness/2) - 12,hangerArmLength + hangerArmThickness + 5,hangerWidth/2])
rotate([90,0,0])
cylinder (hangerArmThickness * 2,2.5, 2.5, true);

translate([-hangerArmThickness - 15,hangerArmLength + hangerArmThickness + 5,hangerWidth/2])
rotate([90,0,0])
cylinder (hangerArmThickness * 2,2.75, 2.75, true);
}