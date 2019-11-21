// Petal Vase Creator
// by g.wygonik Feb 2013
// Creative Commons - Attribution Share Alike

Number_of_Petals = 4; // [3:8]

// in mm (not including neck)
Vase_Height = 50; // [25:100]

Neck_Style = "bump"; // [none,angled,bump,fluted]



// non-user setting variables
petals = Number_of_Petals + 0.0;
factors = [1,1,1,82.5,90.5,95,97.5,100.5,103,105];
maxSize = ((factors[petals])/petals)-1.85;
overallHeight = Vase_Height+0.0;
topHeight = 3 + 0.0;
neckHeight = 5 + 0.0;
height = overallHeight - topHeight;


// main loop

for (i = [0:petals-1]) {
	rotate([0,0,i*(360/petals)]) makePetal();
}


// makes a "petal" comprised of an outer shape with an inner shape removed,
// a top layer for final stability and straight-edged opening, and 
// some style of neck (including none) for ornamentation

module makePetal() {
	union() {

		difference() {
				outer();
				inner();
		}
		top();

		if (Neck_Style != "none") {
			neck();
		}
	}
}

// the outer shape is two cylinders with a bounding hull
module outer() {
			hull() {
			   translate([30,0,0]) cylinder(r=maxSize, h=height, $fn=36);
			   translate([5+petals-4,0,0]) cylinder(r=3, h=height, $fn=36);
			}
}

// inner is also two cylinders with a bounding hull, however one of the cylinders
// gets smaller at the top so as to not leave the top having open overhang. This
// gives more space at the bottom of the vase than the top.
module inner() {
			hull() {
			   translate([30,0,4]) cylinder(r1=maxSize-3, r2=13-petals, h=height, $fn=36);
			   translate([6+petals+12,0,4]) cylinder(r1=1, r2=0.1, h=height, $fn=36);
			}
}

// the top repeats the outer hull, but removes a consistent single hole for opening
module top() {
	difference() {
		translate([0,0,height]) hull() {
			   translate([30,0,0]) cylinder(r=maxSize, h=topHeight, $fn=36);
			   translate([5+petals-4,0,0]) cylinder(r=3, h=topHeight, $fn=36);
			}

		translate([30,0,4]) cylinder(r=13-petals, h=height+5, $fn=36);
	}
}

// creates the various "neck" types based on user selection. These are mostly
// variations of cylinders and extruded circles as toruses (torii?)
module neck() {

	if (Neck_Style == "angled") {
		translate([30,0,overallHeight]) 
		difference() {
			cylinder(r1=16-petals, r2=15-petals ,h=neckHeight, $fn=36);
			translate([0,0,-1]) cylinder(r=13-petals,h=neckHeight+2, $fn=36);
		}
	
		translate([30,0,overallHeight]) 
		difference() {
			rotate_extrude(convexity = 10, $fn=36) translate([15.5-petals, 0, 0]) circle(r = 1, $fn=36);
			translate([-15,-15,-5]) cube([30,30,5]);
		}
	
		translate([30,0,overallHeight]) 
		difference() {
			rotate_extrude(convexity = 10, $fn=36) translate([14-petals, neckHeight, 0]) circle(r = 1, $fn=36);
			translate([-15,-15,neckHeight-5]) cube([30,30,5]);
		}
	} else if (Neck_Style == "bump") {
		translate([30,0,overallHeight])
		difference() {
			rotate_extrude(convexity = 10, $fn=36) translate([14-petals, 0, 0]) circle(r = 3, $fn=36);
			translate([-15,-15,-5]) cube([30,30,5]);
			translate([0,0,-5]) cylinder(r=13-petals, h=height+15, $fn=36);
		}
		
	} else if (Neck_Style == "fluted") {
		translate([30,0,overallHeight]) 
		difference() {
			cylinder(r=16-petals ,h=10, $fn=36);
			rotate_extrude(convexity = 10) translate([20-petals, 2, 0]) scale([1,1.25,1]) circle(r = 6, $fn=36);
			translate([0,0,-1]) cylinder(r=13-petals,h=12, $fn=36);
		}


	}
}
