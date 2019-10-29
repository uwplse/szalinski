
// is the width of the spool hub
reelWidth = 38; // [35:100]

module core() {

	innerCylWidth = max(10, (reelWidth/4));

	//echo(innerCylWidth);
	union() {
		// x was 60
		translate([0,0,-0.05])cylinder(reelWidth+0.1,26,26);
	    // translate z was 60
		translate([0,0,min(reelWidth,reelWidth-(innerCylWidth+0))])
			cylinder(innerCylWidth+.05,30,30);
	}
}

module arch() {
     //   reelWidth was 25
	translate([0,0,reelWidth/3])union() {
		difference() {
			// z scale was 3.3
			scale([1,1,reelWidth/23])
				rotate([90,0,22.5])
					translate([0,0,-50])
						cylinder(100,9,9);
			translate([-50,-50,-50])
				cube([100,100,50]);
		}
		// cube z was 21
	    // translate z was -20
		rotate([0,0,22.5]) 
			translate([-9,-50,-((reelWidth/3)-5)])
				cube([18,100,(reelWidth/3.0)-4.9]);
	}
}
module eTrangle(height,length) {
	rotate([0,0,-30])
	difference() {
		cube([length,length,height]);
		translate([0,0,-0.5])rotate([0,0,60])cube([length*1.2,length*1.2,height+1]);
		translate([length,0,-0.5])rotate([0,0,30])cube([length*1.2,length*1.2,height+1]);
	}
}
module reel() {
	difference() {
		cylinder(reelWidth,37,37,$fn=8);
		core();
		arch();
		rotate([0,0,45]) arch();
		rotate([0,0,90]) arch();
		rotate([0,0,135]) arch();
	}
}
module drumCentre() {
	filamentHoleRotation =  reelWidth < 60 ? 22.5 : 0;
	difference() {
		
		rotate([0,0,22.5])reel();

		for (i=[0:7]) {
			//rotate([0,0,i*45])translate([-42,0,-0.1])eTrangle(5.2,15);
			// translate z was 71
			rotate([0,0,i*45])translate([-42,0,reelWidth-5])eTrangle(5.1,15);
		}
		// filament holes
		for (i=[0:3]) {
             // translate y was 65
			rotate([90,0,(i*45)+filamentHoleRotation]) translate([0,reelWidth*.85,-50]) 
				cylinder(100,2.5,2.5);
		}

	}
}
module arm() {
	translate([34.25,-7.5,0]) difference() {
		union() {
			translate([0,0,0])cube([65,15,5]);
			translate([7.45,7.5,0])rotate([0,0,180])eTrangle(5,14.5);
		}
		translate([5,-0.1,-0.1])cube([45,5.1,5.2]);
		translate([5,10.1,-0.1])cube([45,5.1,5.2]);
		translate([62.5,4,-0.1])rotate([0,0,210])eTrangle(5.2,10);
		translate([62.5,11,-0.1])rotate([0,0,150])eTrangle(5.2,10);
	}
}
module loadArm() {
	import_stl("spool2arm.stl",convexity=10);
}
module edge(withHoles) {
	union() {
		difference() {
			cylinder(5,99.6,99.6,$fn=50);
			translate([0,0,-0.1])cylinder(5.2,84.6,84.6,$fn=50);
			translate([-105,-102.45,-0.1])cube([210,110,10]);
			rotate([0,0,45])translate([-105,-7.55,-0.1])cube([210,110,10]);
			if (withHoles) {
				translate([90.5,18,-0.1]) cylinder(5.2,2.5,2.5);
				translate([87.5,30,-0.1]) cylinder(5.2,2.5,2.5);
				translate([82.5,42,-0.1]) cylinder(5.2,2.5,2.5);
				translate([76,52,-0.1]) cylinder(5.2,2.5,2.5);
			}
		}
		rotate([0,0,45])translate([86.85,-3.6,0])rotate([0,0,-30]) eTrangle(5,9.8);
		translate([96.65,3.6,0])rotate([0,0,150]) eTrangle(5,9.8);
	}
}
module spool() {
	translate([5,0,0])import_stl("spool2core.stl",convexity=10);
	for (i=[0:7]) {
		rotate([0,0,i*45])loadArm();
		rotate([0,0,i*45])translate([0,0,71])loadArm();
		rotate([0,0,i*45])edge((i%2)==0);
		rotate([0,0,i*45])translate([0,0,71])edge((i%2)==1);
	}
}
module explodedSpool() {
	translate([5,0,0])import_stl("spool2core.stl",convexity=10);
	for (i=[0:7]) {
		rotate([0,0,i*45])translate([10,0,0]) loadArm();
		rotate([0,0,i*45])translate([10,0,71])loadArm();
		rotate([0,0,i*45])translate([20,10,0]) edge((i%2)==0);
		rotate([0,0,i*45])translate([20,10,71])edge((i%2)==1);
	}
}

//%color([0.5,0.5,0.5,0.1]) translate([-50,-50,-1.01]) cube([100,100,1]);
module arms(allSix) {
	translate([-75,-6,0]) arm();
	translate([-57,6,0]) arm();
	translate([-57,-18,0]) arm();
	translate([-75,18,0]) arm();
	if (allSix)  {
		translate([-75,-30,0]) arm();
		translate([-57,30,0]) arm();
	}
}
module edges() {
	translate([2,-10,0])rotate([0,0,67.5])translate([-85,-33.5,0]) edge(true);
	translate([2,10,0])rotate([0,0,67.5])translate([-85,-33.5,0]) edge(false);
	translate([2,30,0])rotate([0,0,67.5])translate([-85,-33.5,0]) edge(true);
	translate([2,-30,0])rotate([0,0,67.5])translate([-85,-33.5,0]) edge(false);
}

//arms(false);
//edges();
//translate([0,-200,0])arms(true);
//translate([125,-200,0])arm();
//translate([250,-200,0])edges();
//translate([250,0,0])spool();
//explodedSpool();
//translate([125,-200,0])translate([5,0,0])import_stl("spool2core.stl",convexity=10);
drumCentre();