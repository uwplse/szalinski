/*
 * Highly Configurable Carabiner (One Link To Rule Them All)
 *
 * (c) by Alex Franke (CodeCreations), Jul 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * WARNING: Do not use printed carabiners for rock climbing, high elevation window cleaning, 
 *   cliff rescue, sailing, or anything else you need a real carabiner for. If you choose to 
 *   ignore this warning, at least make sure your will is up to date. 
 * 
 * INSTRUCTIONS: Print and use in an appropriate manner. 
 * 
 * TODO: 
 *   * Clasp types 
 * 
 * v1.00, Jul 5, 2012: Initial release. 
 *
 */


/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

// Profiles 
// 
//    Profiles define the shapes of different parts of the carabiner: The large end, 
// the small end, and the "legs" (the bars that connect the loops at the ends). 
// The four parts of a profile are the type, size, angle, and clip.
//   
//    type - The basic profile shape, either "round" or "square"
//    size - The size of the profile, width and height. 
//    angle - The amount the profile is rotated. 
//    clip - A rectangle that clips the profile, useful for making shapes like 
//           octogons or chamfered squares. 

// General properties
overallLength    = 55;                            // The total length of the carabiner
jointSwell       = 1;                             // The distance to "swell" the joints
flatten          = false;                         // Flattens the bottom to legs for printing 
$fn              = 25;                            // General curve quality 

// The large end 
largeProfile     = ["square", [5,5], 45, [4,4]];  // The profile for the large end 
largeDiameter    = 30;                            // The diameter of the large end 
largeOpening     = 24;                            // The width of the opening
largeRotation    = 0;                             // Angle to lift the end up from horizontal  

// The small end 
smallProfile     = ["circle", [2,5], 0, [4,4]];   // The profile for the small end 
smallDiameter    = 15;                            // The diameter of the small end 
smallOpening     = 5;                             // The width of the opening
smallRotation    = 0;                             // Angle to lift the end up from horizontal  

// "Legs" 
legProfile       = ["square", [4,4], 45, [4,4]];  // The profile for the legs
springAngle      = 10;                            // The angle to fan out the leg for springiness

// Clasp
claspLength      = 5;                             // The length of the clasp section; zero for none
claspGap         = 0.5;                           // The gap separating sides of the clasp when closed
claspOffset      = 4;                             // Distance of the clasp from the end of the leg

// Sleeve
sleeveDiameter   = 8.5;                           // Diameter of the sleeve; zero for none
sleevePadding    = 0.75;                          // Gap between sleeve and leg material
sleeveStopSize   = [2, 0.75, 1.5];                // Shape of bump that locks sleeve in place


/////////////////////////////////////////////////////////////////////////////
// Examples... 
/////////////////////////////////////////////////////////////////////////////

// These are some of the pictured examples. Unstar the example() line to render one. 

examples = [
	// Example 0
	[["square", [6,6], 45, [5,5]],["circle", [3,6], 0, [5,5]],["square", [5,5], 45, [5,5]],
		0,0,18,9,48,30,6.5,8,0.2,4,9,1,false,9.5,.75,[2, 0.75, 1.5]],

	// Example 1
	[["circle", [7,5], 0, [6.5,4.5]],["circle", [5,5], 0, [4.5,4.5]],["square", [5,5], 45, [4.5,4.5]],
		45,-15,15,12,48,2,14,4,0.8,16,0,0,false,0,.75,[2, 0.75, 1.5]],

	// Example 2
	[["circle", [4,4], 0, [15,15]],["circle", [4,4], 0, [15,15]],["square", [4,4], 45, [15,15]],
		0,0,12,12,15,50,50,5,0.2,4,25,2,false,10,0.75,[2, 0.75, 1.5]],

	// Example 3
	[["circle", [4,4], 0, [15,15]],["circle", [4,4], 0, [15,15]],["square", [4,4], 45, [15,15]],
		0,0,12,12,15,50,50,0,0,0,0,2,false,0,0.75,[2, 0.75, 1.5]]
];


/////////////////////////////////////////////////////////////////////////////
// The code... 
/////////////////////////////////////////////////////////////////////////////

// some basic math... 
r1 = largeDiameter/2; 
r2 = smallDiameter/2; 
d = overallLength - r1 - r2 ; 	// distance between two circle centers

// Render the carabiner
link( largeProfile, smallProfile, legProfile, largeRotation, smallRotation,
	r1, r2, d, largeOpening, smallOpening, claspLength, 
	claspGap, claspOffset, springAngle, jointSwell, flatten,
	sleeveDiameter, sleevePadding, sleeveStopSize );

// Alternatively, render an example
*example( examples[0] ); 


/////////////////////////////////////////////////////////////////////////////
// Other stuff -- dont change it unless you really know what you're doing. 
/////////////////////////////////////////////////////////////////////////////

// Debug the clasp designs 
*debugClasp(); 

// Render one of the examples 
module example( number ) {

	echo(number);

	link( number[0],number[1],number[2],number[3],number[4],number[5],number[6],number[7],
		number[8],number[9],number[10],number[11],number[12],number[13],number[14],number[15],
		number[16],number[17],number[18],number[19] );
}

// Render the three clasp configurations 
module debugClasp() {

	//module clasp(length, width, height, radius, gap, clipBottom, clipTop, clipLength) {
	clasp(5, 6, 7, 1.5, .5, false, false, 35);
	translate([15,0,0]) 
		clasp(5, 6, 7, 1.5, .5, true, false, 35);
	translate([-15,0,0]) 
		clasp(5, 6, 7, 1.5, .5, false, true, 35);
}

// Render the carabiner 
module link(largeProfile, smallProfile, legProfile, largeRotation, smallRotation,
		r1, r2, dist, gap1, gap2, claspLength, claspGap, claspLockOffset, springAngle, 
		jointSwell, flatten, sleeveDiameter, sleevePadding, sleeveStopSize ) {

	// The tangent to the two circles defines the point at which the gaps are at their widest. 
	tangentAngle = asin( (r1-r2)/dist ); 
	echo( "Tangent Angle: ", tangentAngle ); 


	// ********* Large Circle *********
	// The large circle is easy because it never opens up more than 180 degrees. 

	// Calculate the desired gap (g1) for the large circle.  
	maxGap1 = ( r1*cos(tangentAngle) - profileRadius(largeProfile) - jointSwell) * 2;
	g1= min( maxGap1, gap1);
	echo( "Circle 1 Max/Final Gap: ", maxGap1, g1 );

	// Calculate the point (p1, [x1,y1]) at which the circle should be cut to produce the required gap 
	y1 = g1/2 + profileRadius(largeProfile) + jointSwell;
	x1 = sqrt( pow(r1,2) - pow(y1,2));
	p1 = [x1,y1];
	echo( "Circle 1 Cut Point: ", p1 );


	// ********* Small Circle *********
	// For the smaller circle, the max gap is also at the tangent, but because the smaller circle is 
    // opened up more, the gap is calculated differently. 
	
	// Calculate the desired gap (g2) for the small circle.  
	maxGap2 = ( (r2 - profileRadius(smallProfile) - jointSwell)/cos(tangentAngle) ) * 2;
	g2=min( maxGap2, gap2);
	echo( "Circle 2 Max/Final Gap: ", maxGap2, g2 );

	// Calculate the point (p2, [x2,y2]) at which the clasp leg should end when the carabiner is closed
 	// or with zero spring angle.  
	x2 = g2/2 > (r2 - profileRadius(smallProfile) - jointSwell) 
		? dist + r2*sin(acos( (r2-profileRadius(smallProfile)-jointSwell)/(g2/2) ) )
		: dist - sqrt(pow(r2,2)- pow((g2/2+profileRadius(smallProfile)+jointSwell), 2));
	y2 = dist-x2 == 0
		? r2
		: sqrt( pow(r2,2) - pow(dist-x2,2)); 
	p2 = [x2,y2];
	echo( "Circle 2 Cut Point: ", p2 );

	// Calculate the point at which the circle should be cut with the spring angle applied. 
	x2s = (x2-dist)*cos(-springAngle) - y2*sin(-springAngle) + dist; 
	y2s = (x2-dist)*sin(-springAngle) + y2*cos(-springAngle); 
	p2s = [x2s,y2s];


	// ********* Solid Leg ********* 
	// This leg connects p1 to p2 and is always solid. 

	l = sqrt( pow(x2-x1,2) + pow(y2-y1,2) ); 
	angle = asin( (y1-y2)/l );


	hasSleeve = sleeveDiameter/2 > profileRadius(legProfile)+sleevePadding; 


	// ********* Build the Part ********* 
	difference() {
		union() {

			difference() {
				union() {
					end( r1, largeProfile, largeRotation, atan(y1/x1), 0, jointSwell ); 

					translate([dist,0,0])
					rotate([0,0,-springAngle/2]) 
					translate([-dist,0,0])
						end( r2, smallProfile, -smallRotation, atan(y2/(dist-x2)) + springAngle/2, 
							dist, jointSwell );	 
				}
			}

			// Clasp leg
			// This leg is in two parts. The fragment starts at p1 and extends toward p2, and the 
			// second fragment starts at p2s and extends out along the tangent of the small circle. 
			translate(p1) 
			rotate(-angle) 
			translate([l/2,0,0]) 
				leg(legProfile, l, claspLength, claspGap, claspLockOffset, true, false, sleeveStopSize ); 

			translate(p2s) 
			rotate(-angle-springAngle) 
			translate([-l/2,0,0]) {
				if ( hasSleeve ) 
					leg(legProfile, l, claspLength, claspGap, claspLockOffset, false, true, sleeveStopSize ); 
				else 
					leg(legProfile, l, claspLength, claspGap, claspLockOffset, false, true ); 
			}
	
			// Solid leg
			translate([p1[0],-p1[1]]) 
			rotate(angle) 
			translate([l/2,0,0]) 
				leg(legProfile, l, 0, 0, 0, true, true ); 

		}

		// Reslice to remove end cap material if necessary. 
		//translate([x1,y1,0]) 
		//rotate([0,0,270-angle]) 
		//rotate([-90,0,0]) 
		//translate([claspGap,0,claspLength/2+claspLockOffset]) 		
		//	clasp( claspLength, largeProfile[3][1]+2, largeProfile[3][0]+3, (min(largeProfile[3][0], 
		//		largeProfile[3][1])/2)*.75, claspGap);

		if ( flatten ) {
			translate([r1+x1,0,-maxThickness/2-min(legProfile[1][1], legProfile[3][1])/2 ])
				cube([dist+r1+r2, (r1+maxWidth)*2, maxThickness], center=true);
		}
	}


	if ( hasSleeve ) {

		translate([0,0, claspLength/2 - profileRadius(legProfile)]) 
		difference() {
			cylinder(r=sleeveDiameter/2, h=claspLength, center=true);

			rotate([0,90,0]) 
			scale( (profileRadius(legProfile)+sleevePadding)/profileRadius(legProfile) ) 
				leg(legProfile, claspLength*2, 0, 0, 0, true, true );
		}
	}
}

function profileRadius( profile ) = min( profile[1][0], profile[3][0] )/2;

// Render the leg 
module leg(profile, length, claspLength, claspGap, claspLockOffset, includeMale, 
	includeFemale, sleeveStopSize = [0,0]) {

	rotate([0,0,180])
	render()
	difference() {

		union() {

			// leg 
			rotate([0,90,0]) 
				linear_extrude(height=length, center=true)
					drawProfile( profile ); 

			// End caps 
			for ( j=[-1,1] )
				translate([j*length/2,0,0]) 
					rotate_extrude_intersecting(profile[3], 90)
						drawProfile( profile, true ); 

			// Sleeve stop 
			if ( sleeveStopSize[0] * sleeveStopSize[1] != 0 ) {
				translate([length/2-claspLength-claspLockOffset- sleeveStopSize[0]/2,
						profileRadius(profile),0]) {
					scale(sleeveStopSize) 
						sphere(r=0.5, center=true); 
				}
			}
		}

		translate([length/2-claspLength/2-claspLockOffset,profileRadius(profile)/4,0]) 		
		rotate([-90,0,90]) 
			clasp( claspLength, profile[3][1]+2, profile[3][0]+3, min(profile[3][1], profile[1][1])*0.35, 
				claspGap, includeMale, includeFemale, length);

	}
}

// Render the clasp
module clasp(length, width, height, radius, gap, includeMale, includeFemale, totalLength) {

	union() {
		difference() { 
			union() {
				translate([gap/2,0,0]) 
					cylinder(h=length, r=radius, center=true);
				cube([gap,width,length], center=true);
				translate([-height/4,0,!includeMale ? 0 : length/2 - gap/2]) 
					cube([height/2,width, !includeMale ? length : gap], center=true);
				translate([height/4,0,-length/2 + gap/2]) 
					cube([height/2,width,gap], center=true);
			}
			if ( includeFemale )
				translate([gap/2,0,gap]) 
					cylinder(h=length, r=radius-gap, center=true);
			translate([(radius+1)/2 + gap/2,0,gap]) 
				cube([radius+1,width+1,length], center=true) ;
		}

		if ( !includeFemale ) {
			translate([height/4,0,0]) 
					cube([height/2,width,length], center=true);
			translate([0,0,totalLength/2+ length/2 - .05]) 
					cube([height,width,totalLength], center=true);
		}
		if ( !includeMale ) {
			translate([0,0,-totalLength/2- length/2 +.05]) 
					cube([height,width,totalLength], center=true);
		}
	}
}

// Render the end
module end( radius, profile, rotation, sliceAngle, distance, jointSwell ) {

	flip = distance > 0 ? 1 : 0; 
	shift = distance > 0 ? 1 : -1; 

	thickness = min(profile[1][1], profile[3][1]); // radial thickness 
	height = min(profile[1][0], profile[3][0]); 	// height whole circle 

	outerRadius = radius + thickness/2 + 1; 
	breakpoint = sliceAngle > 0 
		? [ radius*cos(sliceAngle), radius*sin(sliceAngle) ]
		: [ -shift*radius*cos(sliceAngle), radius*sin(sliceAngle) ];
	outerPoint = sliceAngle > 0 
		? [ outerRadius*cos(sliceAngle), outerRadius*sin(sliceAngle) ]
		: [ -shift*outerRadius*cos(sliceAngle), outerRadius*sin(sliceAngle) ];

	translate([distance-(shift*breakpoint[0]),0,0]) 
	rotate([0,rotation,0]) 
	rotate([0,180*flip,0]) 
	translate([-breakpoint[0],0,0]) 
	union() {
		difference() {
	
			// circle
			rotate_extrude(convexity = 10)
				translate([radius,0,0]) 
					drawProfile( profile ); 

			// cut it open 
			linear_extrude(height=thickness+1, center=true, convexity=10) 
				polygon( points=[[0,0],outerPoint, [outerPoint[0]+radius*2+thickness,outerPoint[1]], 
					[outerPoint[0]+radius*2+thickness,-outerPoint[1]], [outerPoint[0],-outerPoint[1]]] );
		}

		// Cap the ends
		for( i=[-1,1] ) 
			translate([breakpoint[0],i*breakpoint[1],0]) 
				rotate_extrude_intersecting(profile[3], 0)
					translate([jointSwell,0,0]) 
						drawProfile( profile, true ); 
	}
}

// Rotate_extrude apparenly causes a CGAL exception when an object overlaps itself as 
// a result of rotation. This reassumbles the object, slicing half of it off in the process,
// and appears to resolve the problem. 
module rotate_extrude_intersecting(size, rotation) {
	union() 
	for(i=[0:$children-1]) {
		rotate_extrude() 
		intersection() {
			rotate([0,0,rotation])
			child(i);
			translate([0,-size[1]/2]) 
				square(size,center=false);
    		}
	}
}

// Draw a profile 
module drawProfile( profile ) {
	if ( profile[0] == "square" )
		intersection() {
			rotate([0,0,profile[2]]) 
				square(profile[1], center=true);
			square(profile[3], center=true);
		}
	if ( profile[0] == "circle" )
		intersection() {
			rotate([0,0,profile[2]]) 
				scale([1,profile[1][1]/profile[1][0],1])
					circle(profile[1][0]/2, center=true);
			square(profile[3], center=true);
		}
}

