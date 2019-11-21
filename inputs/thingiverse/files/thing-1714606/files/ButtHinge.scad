/* GLOBAL */
// What is the thickness of the leaves? (min=pin diameter+3)
leafGauge = 6;

// What is the length of the pin?
pinLength = 30;

// What is the width of the pin from leaf edge to leaf edge when laid flat? (min=leafGuage+20)
openWidth = 40;

// What is the diameter of the pin? (min=3)
diameter = 3;

// How many knuckles?
knuckleCount = 5; // [3:2:99]

// How many drill holes?
holeCount = 3; // [0:20]

module drillHole( holeRadius, chamferRadius, length )
{
    union () {
        cylinder(r=holeRadius, h=length+2, center=true, $fn=32);
        translate([0,0,length/2-chamferRadius])
            cylinder(r1=0, r2=2*chamferRadius, h=2*chamferRadius, $fn=32);
    }
}

/* HIDDEN */
$fn = 128;


module buttHinge( gauge, length, width, pinDiameter, knuckles, drillHoles )
{
	truePinDiameter = max(pinDiameter,3);
	trueGauge = max(gauge,pinDiameter+3);
	trueWidth = max(width/2,(trueGauge + 20)/2);
	trueKnuckles = max(knuckles, 2*floor(knuckles/2)+1, 3);

	knuckleRadius = trueGauge / 2;
	pinRadius = truePinDiameter / 2;
	pitch = length / trueKnuckles;
	leafWidth = trueWidth;
	pClear = 0.3; // clearance between the pin and the free knuckles
    kClear = 0.4; // clearance between adjacent free and fixed knuckles
	support = 0.3; // support width
    holeSpacingV = length / (2*drillHoles);
    holeRadius = 1.7;
    chamferRadius = 3.4;

	union() {
		// Fixed side
		difference() {
			union() {
				// Knuckle
                translate([0,0,-length/2]) cylinder(r=knuckleRadius,h=length);
				// Leaf
				translate([-leafWidth/2,0,0]) cube([leafWidth,gauge,length],true);
			}

            union() {
				// Space for the free knuckles
				for ( i = [1:2:trueKnuckles-2] )
					translate([-(trueGauge+2*kClear)/2,-(trueGauge+2*kClear)/2,i*pitch - kClear - length/2])
						cube([trueGauge+2*kClear,trueGauge+2*kClear,pitch + 2*kClear]);
                // Drill holes
                for ( i = [1:2:ceil(drillHoles/2)] ) {
                    translate([chamferRadius+1-leafWidth,0,(2*i-1)*holeSpacingV - length/2]) rotate([90,0,0]) 
                        drillHole(holeRadius, chamferRadius, trueGauge);
                    translate([chamferRadius+1-leafWidth,0,length/2 - (2*i-1)*holeSpacingV]) rotate([90,0,0])
                        drillHole(holeRadius, chamferRadius, trueGauge);
                    if ( i < drillHoles/2 ) {
                        j = i+1;
                        translate([-leafWidth/2,0,(2*j-1)*holeSpacingV-length/2]) rotate([90,0,0])
                            drillHole(holeRadius, chamferRadius, trueGauge);
                        translate([-leafWidth/2,0,length/2-(2*j-1)*holeSpacingV]) rotate([90,0,0])
                            drillHole(holeRadius, chamferRadius, trueGauge);
                    }
                }
			}
		}

		// Pin
		translate([0,0,-length/2]) cylinder(r=pinRadius,h=length);

		// Free side
		rotate(a=30,v=[0,0,1])
		difference() {
			union() {
				// Knuckle
                translate([0,0,-length/2]) cylinder(r=knuckleRadius,h=length);
				// Leaf
				translate([leafWidth/2,0,0]) cube([leafWidth,gauge,length],true);
			}
			union() {
				// Space for the fixed knuckles
				for ( i = [0:2:trueKnuckles-1] )
					translate([-(trueGauge+2*kClear)/2,-(trueGauge+2*kClear)/2,i*pitch - length/2])
						cube([trueGauge+2*kClear,trueGauge+2*kClear,pitch]);
                
				// Space for the pin
				translate([0,0,-length/2]) cylinder(r=pinRadius+pClear,h=length);
                
                // Clear the ends that are left behind because of round-off error
                translate([-(trueGauge+2*kClear)/2,-(trueGauge+2*kClear)/2,-(length/2+kClear)])
                   cube([trueGauge+2*kClear,trueGauge+2*kClear,pitch]);
                translate([-(trueGauge+2*kClear)/2,-(trueGauge+2*kClear)/2,length/2-pitch+kClear])
                    cube([trueGauge+2*kClear,trueGauge+2*kClear,pitch]); 
                
                // Drill holes
                for ( i = [1:2:ceil(drillHoles/2)] ) {
                    translate([leafWidth-chamferRadius-1,0,(2*i-1)*holeSpacingV - length/2]) rotate([90,0,0]) 
                        drillHole(holeRadius, chamferRadius, trueGauge);
                    translate([leafWidth-chamferRadius-1,0,length/2 - (2*i-1)*holeSpacingV]) rotate([90,0,0])
                        drillHole(holeRadius, chamferRadius, trueGauge);
                    if ( i < drillHoles/2 ) {
                        j = i+1;
                        translate([leafWidth/2,0,(2*j-1)*holeSpacingV-length/2]) rotate([90,0,0])
                            drillHole(holeRadius, chamferRadius, trueGauge);
                        translate([leafWidth/2,0,length/2-(2*j-1)*holeSpacingV]) rotate([90,0,0])
                            drillHole(holeRadius, chamferRadius, trueGauge);
                    }
                }
			}
		}

		// Support material
		difference() {
			// Support strips
			intersection() {
				cylinder(h=length,r=knuckleRadius,center=true);
				union() {
					cube([support,2*knuckleRadius,length],center=true);
					cube([2*knuckleRadius,support,length],center=true);
				}
			}

			// Subtract the pin
			cylinder(h=length,r=pinRadius + pClear,center=true);
		}
	}
}

buttHinge( gauge=leafGauge, length=pinLength, width=openWidth, pinDiameter=diameter, knuckles=knuckleCount, drillHoles=holeCount);