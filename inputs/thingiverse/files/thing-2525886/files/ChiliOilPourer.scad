plugHeight=17.5;

// *plugDia* is *the* variable you need to alter when u want to adapt
// this model to another bottle: its the inside diameter of the bottle
// neck where the plug should fit into.
//plugDia=17.4;           // minmal inside diameter of bottle neck measured
plugDia=18.5;           // minmal inside diameter of bottle neck measured

plugWallThickness=2.0;  // wall thickness of hollow plug

plugThreadOver=1.0;     // thread is larger than plugDia to get a tight fit
plugThreadDia=plugDia+plugThreadOver;  
plugThreadNr=5;         // number of threads on plug
plugThreadHeight=0.5;   // height of threads

topDia=27.0;
topHeight=3.0;

outletInnerDia=5.0;
outletOuterDia=7.0;
outletHeight=30.0;

$fn=60;

module makePlug() {

	difference() {
		union() {
			cylinder(h=plugHeight,d1=plugDia-plugThreadOver+0.1,d2=plugDia-plugThreadOver-0.1);
			for(a=[1:plugThreadNr]) {
				translate([0.0, 0.0, (plugHeight/(plugThreadNr))*a -plugThreadHeight/2.0])
					rotate_extrude(angle=360.0, convexity = 10)
						square( [plugThreadDia/2, plugThreadHeight]);
			}
		}
		translate([0.0, 0.0, -2.0]) 
			cylinder(h=plugHeight+4,d1=plugDia-plugWallThickness*2-plugThreadOver+0.1,d2=plugDia-plugWallThickness-plugThreadOver-0.1);
		
	}
}

module makeTop() { // flat cylinder with rounded edges

    translate([0, 0, topHeight/2])
	union() { 
		cylinder(h=topHeight,d=topDia, center=true);
        rotate_extrude(angle=360.0, convexity = 10)				
			translate([topDia/2, 0.0, 0.0])
					circle(d=topHeight);
	}
}

module makeOutlet() {

	difference() {
		difference() { // make pipe
			cylinder(h=outletHeight,d=outletOuterDia);
			translate([0,0,-2]) cylinder(h=outletHeight+4,d=outletInnerDia);
		}
		translate([outletOuterDia-0.8,0.0,outletHeight]) 
			rotate([0.0,45.0,0.0])
				cube(size=outletOuterDia*2, center=true);
	}
}

module makePlugAndTop() {
	
	difference() {
		union() { // plug + top
			makePlug();
			translate([0,0,plugHeight-0.1]) makeTop();
		}	// inner plug hole
			translate([0,0,-2])
				cylinder(h=plugHeight+topHeight+4.0,d=outletInnerDia);
	}
}

// main
color([0.0, 0.8, 0.8, 0.9])
union() {
	makePlugAndTop();
	translate([0,0,plugHeight+topHeight-0.2]) makeOutlet();
}

