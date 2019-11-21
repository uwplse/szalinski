/*----------------------------------------------------------------------------*/
/*  Standard Servo Motor Horn
*/
/*  Eric Lindholm                                                     
*/
/*  7 September 2016                                                                  */
/*  License: Creative Commons - Attribution - Non-Commercial                  */
/*----------------------------------------------------------------------------*/

// preview[view:south east, tilt:top diagonal]

// The size of the screw hole requested. Not the size of the servo shaft (mm).
HoleSize=2.1; // [1.0:0.1:6]
// How many arms (horns) there are.
ArmNumber=4; // [1:1:8]
// The distance from the first hole to the center of the shaft (mm).
MinimumRadius=6; // [6.0:0.1:75.0]
// The distance from the last hole to the center of the shaft (mm).
MaximumRadius=15; // [6.1:0.1:80.0]
// The number of holes PER ARM.
HolesPerArm=3; // [1:1:10]
// The total thickness of the horn (mm).
Thickness=4; // [2.0:0.1:8.0]

/* [Hidden] */
// This number controls the number of segments in a circle. I like using 36, but this can totally be changed if you like large STLs.
$fn=36;
// Degrees between arms
dgamma=360/ArmNumber;

difference() {
	// Positive shapes
	union() {
		// central cylinder
		cylinder(r=4.5,h=Thickness);
		// The arms
		if(ArmNumber==1) {
			armsolo();
		}
		if(ArmNumber!=1) {
			for(n=[0:ArmNumber]) {
				arm(dgamma*n);
			}
		}
	}
	// Negative shapes
	// For the shaft hole, the process can be speeded up immensely
	// by using a cylinder instead of the module I created for the star
	// But if you have a 3D printer that can handle the detail, go for it
	union() {
		// screwhole
		cylinder(r=1.5,h=Thickness*3,center=true);
		// shaft hole
		translate([0,0,Thickness/4])
			servoHole();
			//cylinder(r1=3.0,r2=3.1,h=Thickness+1);
	}
}

// The arm module
module arm(gamma) {
	// The offset for the rectangle
	centerArm=(4.5+MaximumRadius)/2;
	// The length of the rectangle
	armLength=(MaximumRadius-4.5)+HoleSize;
	//holeDelta=1;
	//if(HolesPerArm!=0)	
	// The distance between holes on the arm
	holeDelta=(HolesPerArm>1) ? (MaximumRadius-MinimumRadius)/(HolesPerArm-1) : 0;
	// The radius of the smoothed corner between arms
	cornerR=armLength/ArmNumber;
	// We rotate the arm by the specified angle
	rotate(gamma,[0,0,1]) {
		difference() {
			// Positive shapes
			union() {
				// Primary rectangle
				translate([0,centerArm-HoleSize/2,Thickness/2])
					cube([HoleSize*3,armLength+HoleSize,Thickness],center=true);
				// Rounded end of arm
				translate([0,MaximumRadius+HoleSize/2,Thickness/2])
					cylinder(r=HoleSize*1.5,h=Thickness,center=true);
				// Section we remove from to get the smoothed corner between arms
				translate([HoleSize*1.45,HoleSize*1.45*(1+1.2*cos(dgamma)),Thickness/2])
					linear_extrude(height=Thickness,convexity=10,twist=0,center=true)
						polygon(points=[[0,0],[0,cornerR/tan(dgamma/2)],[cornerR*sin(dgamma)/tan(dgamma/2),cornerR*cos(dgamma)/tan(dgamma/2)]]);
			}

			// Negative shapes
			union() {
				// Do all the holes from Min to Max
				for(p=[1:HolesPerArm]) {
					translate([0,MaximumRadius-(p-1)*holeDelta,Thickness/2])
						cylinder(r=HoleSize*0.525,h=Thickness+2,center=true);
				}
				// Rounding the gap
				translate([cornerR+HoleSize*1.5,cornerR/tan(dgamma/2)+HoleSize*1.5*(1+1.2*cos(dgamma)),Thickness/2])
					cylinder(r=cornerR,h=Thickness+2,center=true);
			}
		}
	}
}

module armsolo() {
	// The offset for the rectangle
	centerArm=(4.5+MaximumRadius)/2;
	// The length of the rectangle
	armLength=(MaximumRadius-4.5)+HoleSize;
	// The distance between holes on the arm
	holeDelta= (HolesPerArm>1) ? (MaximumRadius-MinimumRadius)/(HolesPerArm-1) : 0;
	difference() {
		// Positive shapes
		union() {
			// Primary rectangle
			translate([0,centerArm-HoleSize/2,Thickness/2])
				cube([HoleSize*3,armLength+HoleSize,Thickness],center=true);
			// Rounded end of arm
			translate([0,MaximumRadius+HoleSize/2,Thickness/2])				cylinder(r=HoleSize*1.5,h=Thickness,center=true);
		}

		// Negative shapes
		union() {
			// Do all the holes from Min to Max
			for(p=[1:HolesPerArm]) {
				translate([0,MaximumRadius-(p-1)*holeDelta,Thickness/2])
					cylinder(r=HoleSize*0.525,h=Thickness+2,center=true);
			}
		}
	}
}

// The servo shaft module
// On my printer this was too tight for the shaft. I think for a better calibrated 
//  printer, it would work great.
module servoHole() {
	// Beta is the angle for one slice
	beta=360/25;
	// The external radius is the outer edge of the star
	exR=3.0;
	// The depth of the shaft hole
	depth=Thickness;
	// Factor for how vertical the sides are
	inTilt=0.9;
	// Difference between inner and outer radius
	inR=0.20;
	// This 'shaft hole' is really a 25-pointed star that's narrower at the top.
	// The most reliable way I could think to do this was using a wedge polyhedron,
	//  copied 25 times.
	union() {
		for(r=[0:25]) {
			rotate(r*beta,[0,0,1]) 
				polyhedron(points=[
					[0,0,0],	//A
					[0,0,depth],	//B
					[exR*cos(beta/2),-1.01*exR*sin(beta/2),depth], //C
					[inTilt*exR*cos(beta/2),-1.01*inTilt*exR*sin(beta/2),0],	//D
					[inTilt*(exR-inR),0,0],	//E
					[exR-inR,0,depth],	//F
					[inTilt*exR*cos(beta/2),inTilt*exR*sin(beta/2),0],	//G
					[exR*cos(beta/2),exR*sin(beta/2),depth]]	//H
				,faces=[
					[0,3,2,1],	//ADCB
					[3,4,5,2],	//DEFC
					[4,6,7,5],	//EGHF
					[6,0,1,7],	//GABH
					[0,6,4,3],	//AGED
					[1,2,5,7]],	//BCFH
					convexity=10);	// Actually only has convexity of 4.
				/*
				difference() {
					translate([((exR*cos(beta/2)-.43)/2),0,])
						cube([exR*cos(beta/2)+1,2.2*exR*sin(beta/2),depth],center=true);
					linear_extrude(height=depth+1,convexity=10,twist=0,center=true)
						polygon(points=[[1.1*exR*cos(beta/2),1.1*exR*sin(beta/2)],[1.1*exR*cos(beta/2),-1.1*exR*sin(beta/2)],[exR-0.15,0]]);
				}
				*/
		}
	}
}