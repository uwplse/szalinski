// Bowl Width
bowlWidth = 300; // [50:500]
// Bowl Height
bowlHeight= 600; // [50:500]
// Bowl Thickness
bowlThickness = 100; // [50:500]

footWidth = bowlWidth/2;
footHeight = bowlHeight/2;
footThickness = bowlThickness/2;

//module createBowl() {
	difference() {
		resize(newsize=[bowlWidth, bowlHeight, bowlThickness]) sphere(r=10);
		translate([0,0,5]) resize(newsize=[bowlWidth, bowlHeight, bowlThickness]) sphere(r=10); 
	}
//}	

//module createFoot() {
	difference() {
		translate([-footWidth/2, -footHeight/2, -3/2*footThickness]) cube([footWidth, footHeight, footThickness]);
		resize(newsize=[bowlWidth, bowlHeight, bowlThickness]) sphere(r=10);
	}
//}


//createBowl();
//createFoot();