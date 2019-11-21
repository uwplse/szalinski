//**************************************
//******Created By: Ben Partisi*********
// Licence under Creative Commons 
// Give credit if you use it for other
// than personal reasons
// Sharing is caring
//*************************************


//this makes smoother spheres
$fn = 80; 
//This module makes the frame
module body(){
	translate([0,1,0]){
		rotate([90,0,0]){
			cube([90,62,6]);
		}
	}

	cube([90,100,6]);

	translate([0,106,0]){
		rotate([90,0,0]){
			cube([90,70,6]);
		}
	}
}

//This module creates the cut out where the brush sits
module cutOut(){
	translate([25,-2.5,40]){
		sphere(r = 15.5);
	}
	translate([10.5,-6,45]){
		cube([29,10,20]);
	}

	translate([6,-6,62]){
		rotate([0,45,0,]){
			cube([10,8,8]);
		}
	}
	translate([32,-6,61]){
		rotate([0,45,0,]){
			cube([8,8,10]);
		}
	}
    translate([65,-3,25]) {sphere(r=10);}
    
    translate([67,80,-2]) rotate([0,0,180]) {linear_extrude(height=15)text("T",size=52,font="arial:style=bold");}
}

// where the magic happens

difference(){
	body();
	cutOut();
    
}