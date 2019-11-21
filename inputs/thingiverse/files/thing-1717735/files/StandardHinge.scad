/* GLOBAL */
// What is the thickness of the leaves? (min=2)
leafGauge = 2;

// What is the length of the pin?
pinLength = 30;

// What is the width of the hinge from leaf edge to leaf edge when laid flat? (min=kDiameter+25)
openWidth = 40;

// What is the diameter of the pin? (min=3)
diameter = 3;

// What is the diameter of the knuckles? (min=either pinDiameter+3 or leafGuage)
kDiameter = 6;

// How many knuckles?
knuckleCount = 5; // [3:2:50]

// How many drill holes?
holeCount = 3; // [0:20]

module drillHole( holeRadius, chamferRadius, length )
{
    union () {
        cylinder(r=holeRadius, h=length+2, center=true, $fn=32);
        translate([0,0,length/2-chamferRadius])
            cylinder(r1=0, r2=1.5*chamferRadius, h=1.5*chamferRadius, $fn=32);
    }
}

module prism(l, w, h){
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}


/* HIDDEN */
$fn = 128;

module standardHinge( gauge, length, width, pinDiameter, knuckleDiameter, knuckles, drillHoles )
{
	truePinDiameter = max(pinDiameter,3);
	trueGauge = max(gauge,2);
    trueKnuckleDiameter = max(knuckleDiameter,pinDiameter+3,trueGauge);
	trueWidth = max(width/2,(trueKnuckleDiameter + 25)/2);
	trueKnuckles = max(knuckles, 2*floor(knuckles/2)+1, 3);

	knuckleRadius = trueKnuckleDiameter / 2;
	pinRadius = truePinDiameter / 2;
	pitch = length / trueKnuckles;
	leafWidth = trueWidth;
	pClear = 0.3; // clearance between the pin and the free knuckles
    kClear = 0.6; // clearance between adjacent free and fixed knuckles
	support = 0.3; // support width
    holeSpacingV = length / (2*drillHoles);
    holeRadius = 1.7;
    chamferRadius = 3.4;
    
    fillAngle = 30;
    fillDepth = knuckleRadius - trueGauge + cos(fillAngle)*knuckleRadius;
    fillLength = fillDepth/tan(fillAngle);
    
    union() {
		// Fixed side
		difference() {
			union() {
				// Knuckle
                translate([0,0,-length/2]) cylinder(r=knuckleRadius,h=length);
				// Leaf
				translate([-leafWidth/2,trueGauge/2-knuckleRadius,0]) cube([leafWidth,trueGauge,length],true);
                // Connect Leaf to Knuckle
                translate([-knuckleRadius,-knuckleRadius,-length/2])
                    cube([knuckleRadius,knuckleRadius,length]);
                if ( trueGauge < knuckleRadius ) 
                    translate([-fillLength-sin(fillAngle)*knuckleRadius,-knuckleRadius + trueGauge,-length/2])
                        rotate( [-90,-90,0]) difference() {
                            prism(length,fillLength,fillDepth);
                            union() {
                                for ( i = [1:2:trueKnuckles-2] ) {
                                    translate([pitch*i - kClear,0,-0.0001])
                                        cube([pitch + 2*kClear,fillLength,fillDepth]);
                            }
                        }
                }
			}

            union() {
				// Space for the free knuckles
				for ( i = [1:2:trueKnuckles-2] ) {
					translate([-knuckleRadius-kClear,-knuckleRadius-kClear,i*pitch - kClear - length/2])
						cube([2*(knuckleRadius+kClear),2*(knuckleRadius+kClear),pitch + 2*kClear]);
                }
                // Drill holes
                for ( i = [1:2:ceil(drillHoles/2)] ) {
                    translate([chamferRadius+1-leafWidth,trueGauge/2-knuckleRadius,(2*i-1)*holeSpacingV - length/2]) rotate([-90,0,0]) 
                        drillHole(holeRadius, chamferRadius, trueGauge);
                    translate([chamferRadius+1-leafWidth,trueGauge/2-knuckleRadius,length/2 - (2*i-1)*holeSpacingV]) rotate([-90,0,0])
                        drillHole(holeRadius, chamferRadius, trueGauge);
                    if ( i < drillHoles/2 ) {
                        j = i+1;
                        translate([-leafWidth/2,trueGauge/2-knuckleRadius,(2*j-1)*holeSpacingV-length/2]) rotate([-90,0,0])
                            drillHole(holeRadius, chamferRadius, trueGauge);
                        translate([-leafWidth/2,trueGauge/2-knuckleRadius,length/2-(2*j-1)*holeSpacingV]) rotate([-90,0,0])
                            drillHole(holeRadius, chamferRadius, trueGauge);
                    }
                }
			}
		}

		// Pin
		translate([0,0,-length/2]) cylinder(r=pinRadius,h=length);

		// Free side
		rotate(a=0,v=[0,0,1])
		difference() {
			union() {
				// Knuckle
                translate([0,0,-length/2]) cylinder(r=knuckleRadius,h=length);
				// Leaf
				translate([leafWidth/2,trueGauge/2-knuckleRadius,0]) cube([leafWidth,gauge,length],true);
                // Connect leaf to knuckle
                translate([0,-knuckleRadius,-length/2]) cube([knuckleRadius,knuckleRadius,length]);
                if ( trueGauge < knuckleRadius ) {
                    translate([fillLength+sin(fillAngle)*knuckleRadius,-knuckleRadius+trueGauge,length/2])
                        rotate( [-90,90,0]) difference() {
                            prism(length,fillLength,fillDepth);
                            union() {
                                for ( i = [0:2:trueKnuckles-1] ) {
                                    translate([pitch*i,0,-0.0001])
                                        cube([pitch,fillLength,fillDepth]);
                                }
                            }
                        }
                }

			}

			union() {
				// Space for the fixed knuckles
				for ( i = [0:2:trueKnuckles-1] ) {
					translate([-knuckleRadius-kClear,-knuckleRadius-kClear,i*pitch - length/2])
						cube([2*(kClear+knuckleRadius),2*(kClear+knuckleRadius),pitch]);
                }
                
				// Space for the pin
				translate([0,0,-length/2]) cylinder(r=pinRadius+pClear,h=length);
                
                // Clear the ends that are left behind because of round-off error
                translate([0,0,length-pitch])
                    cube([2*(knuckleRadius+kClear),2*(knuckleRadius+kClear),length],true);
                translate([0,0,-length+pitch])
                    cube([2*(knuckleRadius+kClear),2*(knuckleRadius+kClear),length],true);
                
                // Drill holes
                for ( i = [1:2:ceil(drillHoles/2)] ) {
                    translate([leafWidth-chamferRadius-1,trueGauge/2-knuckleRadius,(2*i-1)*holeSpacingV - length/2]) rotate([-90,0,0]) 
                        drillHole(holeRadius, chamferRadius, trueGauge);
                    translate([leafWidth-chamferRadius-1,trueGauge/2-knuckleRadius,length/2 - (2*i-1)*holeSpacingV]) rotate([-90,0,0])
                        drillHole(holeRadius, chamferRadius, trueGauge);
                    if ( i < drillHoles/2 ) {
                        j = i+1;
                        translate([leafWidth/2,trueGauge/2-knuckleRadius,(2*j-1)*holeSpacingV-length/2]) rotate([-90,0,0])
                            drillHole(holeRadius, chamferRadius, trueGauge);
                        translate([leafWidth/2,trueGauge/2-knuckleRadius,length/2-(2*j-1)*holeSpacingV]) rotate([-90,0,0])
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

standardHinge( gauge=leafGauge, length=pinLength, width=openWidth, pinDiameter=diameter, knuckleDiameter=kDiameter, knuckles=knuckleCount, drillHoles=holeCount);