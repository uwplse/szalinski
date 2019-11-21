$fn=150;
//hexsize is measurement from flat sides plus tolerance

// Bitsize, 4 or 6.9 are common bit sizes
bitsize = 6.9;
// Clearance to add to bitsize
bitclearance = 0.35;
// Bit height
hexbitheight = 30;
// Wall thickness between hexcells
wallthickness = 2;
// additional wallthickness
containerWallthickness = 3;
// Boundry from center hex to outer
hexboundry = 2;
// hex grid
hexgrid = true;



/* [HIDDEN] */
//The Math
hexsize = bitsize+bitclearance;
hexcell = (hexsize/sin(60))/2;

scale = ((hexsize+wallthickness)/sin(60))/2;

outerhex = outerhexradius(scale,hexboundry)+containerWallthickness;

// radius math for threads

minorRadius = outerhex;
pitch = 3;
threadHeightToPitch = 0.5;
clearance = 0.1;
threadHeight = pitch*threadHeightToPitch;
pitchRadius = minorRadius+0.5*threadHeight;
majorRadius = minorRadius+threadHeight;
// 	How the thread library calculates the minorRadius
//	minorRadius = pitchRadius-(0.5*threadHeight);

// The Meat

body(grid=hexgrid, nubNum=8);


translate([minorRadius*3,0,0])
	lid(nubNum=8);

module body(grid=true, nubNum=18, nubSize=4, nubDepth=0.5){
 difference(){
  difference(){
   difference(){
	difference(){
	  union(){
		//union(){
		translate([0,0,hexbitheight-2.5])
			trapezoidThread(	
				length=6,				// axial length of the threaded rod
				pitch=3,				// axial distance from crest to crest
				pitchRadius=pitchRadius,			// radial distance from center to mid-profile
				threadHeightToPitch=0.5,	// ratio between the height of the profile and the pitch
									// std value for Acme or metric lead screw is 0.5
				profileRatio=0.5,			// ratio between the lengths of the raised part of the profile and the pitch
									// std value for Acme or metric lead screw is 0.5
				threadAngle=90,			// angle between the two faces of the thread
									// std value for Acme is 29 or for metric lead screw is 30
				RH=true,				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
				clearance=0.1,			// radial clearance, normalized to thread height
				backlash=0.1,			// axial clearance, normalized to pitch
				stepsPerTurn=64			// number of slices to create per turn
				);
				//cylinder(r=minorRadius, h=hexbitheight+10);
				//}
		difference(){
		  cylinder(r=minorRadius+threadHeight , h=hexbitheight);
		  nubs(radius=minorRadius+threadHeight , height=hexbitheight*0.80, size=nubSize, depth=nubDepth, num=nubNum);
		}
	  } //union
		translate([0,0,1.4+hexbitheight+3.4])cylinder(r=minorRadius*2, h=10);

	} //difference
	translate([0,0,2.5])
	if(grid){
		hexagongrid(height=hexbitheight/3, boundry=hexboundry, outerhexradius=scale, innerhexradius=hexcell);
		}
	else {
		//cylinder(h=hexbitheight/2.5, r=outerhex-wallthickness+1.3);
		cylinder(h=hexbitheight/2.5, r=outerhex);
		}
		
   } //difference
	translate([0,0,2.5+hexbitheight/3])
	 cylinder(r=outerhex-containerWallthickness,h=123);
  } // difference
  roundbevel(minorRadius+threadHeight-0.45);
 } // difference
} // body

module lid(nubNum=9, nubSize=4, nubDepth=1) {
 difference(){
 rotate([180,0,0])translate([0,0,-(10.5)])
  difference(){	
	difference(){
	  cylinder(r=majorRadius+containerWallthickness, h=10.5);
	  nubs(radius=majorRadius+containerWallthickness, height=10.5, size=nubSize, depth=nubDepth, num=nubNum);
	  echo("pitchRadius",pitchRadius);
	  echo("majorRadius", majorRadius);
	union(){
	}
		cylinder(r=minorRadius-clearance*threadHeight,h=0.5);
		trapezoidThreadNegativeSpace(
				length=6,				// axial length of the threaded rod
				pitch=3,				// axial distance from crest to crest
				pitchRadius=pitchRadius,			// radial distance from center to mid-profile
				threadHeightToPitch=0.5,	// ratio between the height of the profile and the pitch
									// std value for Acme or metric lead screw is 0.5
				profileRatio=0.5,			// ratio between the lengths of the raised part of the profile and the pitch
									// std value for Acme or metric lead screw is 0.5
				threadAngle=90,			// angle between the two faces of the thread
									// std value for Acme is 29 or for metric lead screw is 30
				RH=true,				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
				clearance=0.1,			// radial clearance, normalized to thread height
				backlash=0.1,			// axial clearance, normalized to pitch
				stepsPerTurn=100			// number of slices to create per turn

		);}

  }
 roundbevel(pitchRadius+1.5);
 }
}

module roundbevel(size){
	rotate_extrude()
	  translate([size-1,0,0])
	   polygon(points=[[-1,-1],[10*cos(45),10*sin(45)],[10,0]]);
}

module nubs(height=1, num=3, depth, size, radius){
	r=size+radius-depth;
	for (i = [0 : 360/num : 360 ] ){
		translate([r*cos(i),r*sin(i), 0])
		  cylinder(r=size, h=height);
	}
}

/*
Author: Daniel <headbulb>
Small library to create a repeating honeycomb pattern around center hex grid
*/





module hexagon2d(initialangle=0, radius=1) {
polygon(points=[[radius*cos(initialangle),radius*sin(initialangle)],
				[radius*cos(initialangle+60),radius*sin(initialangle+60)],
				[radius*cos(initialangle+120),radius*sin(initialangle+120)],
				[radius*cos(initialangle+180),radius*sin(initialangle+180)],
				[radius*cos(initialangle+240),radius*sin(initialangle+240)],
				[radius*cos(initialangle+300),radius*sin(initialangle+300)]]);
}
// Number of cells = 1+summation(start=1, end=boundry, 6*n)
module hexagongrid(height=1, boundry=1, outerhexradius=1, innerhexradius=0.9, orientation=0, inneronly=true ) {
for (i = [-(boundry) : 1 :boundry ] ){
    for(j = [-(boundry) : 1 : boundry ]){
            z = -(i+j);
            if(z<boundry+1 && z>-(boundry+1)){
             //   echo("i:", i, "j:", j, "z:", z);
                x1 = outerhexradius*(i*cos(300+orientation)+j*cos(60+orientation)+z*cos(180+orientation));
                y1 = outerhexradius*(i*sin(300+orientation)+j*sin(60+orientation)+z*sin(180+orientation));
				if(inneronly==true){
					//color([abs(i)/5,abs(j)/5,abs(z)/5])
					translate([x1,y1,0])
					linear_extrude(height=height) 
					 hexagon2d(initialangle=orientation, radius=innerhexradius);
				}
				else {
						difference() {
							//color([abs(i)/5,abs(j)/5,abs(z)/5])
							translate([x1,y1,0])
							linear_extrude(height=height) 
							 hexagon2d(initialangle=orientation, radius=outerhexradius);
							translate([x1,y1,0])linear_extrude(height=height)
							 hexagon2d(initialangle=orientation, radius=innerhexradius);
					}
				
				}
            } //if Z
    }// for j
}// for i
}


// Find the radius of the outerhex. Basically find an edge hex center then two vectors from that point. 
// One vector to the corner, second vector a little outside that. A 120-30-30 or 30-60-90 triangle
function adj(s) = s/2;
function hyp(s) = adj(s)/cos(30);
function x2(s, boundry) = s*((boundry)*cos(0)-(boundry)*cos(240))+s*cos(60)+hyp(s)*cos(330);
function y2(s, boundry) = s*((boundry)*sin(0)-(boundry)*sin(240))+s*sin(60)+hyp(s)*sin(330);
function outerhexradius(s, boundry) = sqrt((x2(s, boundry)*x2(s, boundry)+y2(s, boundry)*y2(s, boundry)));
//outerhex=sqrt((x2*x2+y2*y2));

/*
Below Library: http://www.thingiverse.com/thing:8793
*/


module threadPiece(Xa, Ya, Za, Xb, Yb, Zb, radiusa, radiusb, tipRatioa, tipRatiob, threadAngleTop, threadAngleBottom)
{	
	angleZ=atan2(Ya, Xa);
	twistZ=atan2(Yb, Xb)-atan2(Ya, Xa);

	polyPoints=[
		[Xa+ radiusa*cos(+angleZ),		Ya+ radiusa*sin(+angleZ),		Za ],
		[Xa+ radiusa*cos(+angleZ),		Ya+ radiusa*sin(+angleZ),		Za + radiusa*tipRatioa ],
		[Xa ,						Ya ,						Za+ radiusa*(tipRatioa+sin(threadAngleTop)) ],
		[Xa ,						Ya ,						Za ],
		[Xa ,						Ya ,						Za+ radiusa*sin(threadAngleBottom) ],
	
		[Xb+ radiusb*cos(angleZ+twistZ),	Yb+ radiusb*sin(angleZ+twistZ),	Zb ],
		[Xb+ radiusb*cos(angleZ+twistZ),	Yb+ radiusb*sin(angleZ+twistZ),	Zb+ radiusb*tipRatiob ],
		[Xb ,						Yb ,						Zb+ radiusb*(tipRatiob+sin(threadAngleTop)) ],
		[Xb ,						Yb ,						Zb ],
		[Xb ,						Yb ,						Zb+ radiusb*sin(threadAngleBottom)] ];
	
	polyTriangles=[
		[ 0, 1, 6 ], [ 0, 6, 5 ], 					// tip of profile
		[ 1, 7, 6 ], [ 1, 2, 7 ], 					// upper side of profile
		[ 0, 5, 4 ], [ 4, 5, 9 ], 					// lower side of profile
		[ 4, 9, 3 ], [ 9, 8, 3 ], [ 3, 8, 2 ], [ 8, 7, 2 ], 	// back of profile
		[ 0, 4, 3 ], [ 0, 3, 2 ], [ 0, 2, 1 ], 			// a side of profile
		[ 5, 8, 9 ], [ 5, 7, 8 ], [ 5, 6, 7 ]  			// b side of profile
		 ];
	
	polyhedron( polyPoints, polyTriangles );
}

module shaftPiece(Xa, Ya, Za, Xb, Yb, Zb, radiusa, radiusb, tipRatioa, tipRatiob, threadAngleTop, threadAngleBottom)
{	
	angleZ=atan2(Ya, Xa);
	twistZ=atan2(Yb, Xb)-atan2(Ya, Xa);

	threadAngleTop=15;
	threadAngleBottom=-15;

	shaftRatio=0.5;

	polyPoints1=[
		[Xa,						Ya,						Za + radiusa*sin(threadAngleBottom) ],
		[Xa,						Ya,						Za + radiusa*(tipRatioa+sin(threadAngleTop)) ],
		[Xa*shaftRatio,				Ya*shaftRatio ,				Za + radiusa*(tipRatioa+sin(threadAngleTop)) ],
		[Xa*shaftRatio ,				Ya*shaftRatio ,				Za ],
		[Xa*shaftRatio ,				Ya*shaftRatio ,				Za + radiusa*sin(threadAngleBottom) ],
	
		[Xb,						Yb,						Zb + radiusb*sin(threadAngleBottom) ],
		[Xb,						Yb,						Zb + radiusb*(tipRatiob+sin(threadAngleTop)) ],
		[Xb*shaftRatio ,				Yb*shaftRatio ,				Zb + radiusb*(tipRatiob+sin(threadAngleTop)) ],
		[Xb*shaftRatio ,				Yb*shaftRatio ,				Zb ],
		[Xb*shaftRatio ,				Yb*shaftRatio ,				Zb + radiusb*sin(threadAngleBottom) ] ];
	
	polyTriangles1=[
		[ 0, 1, 6 ], [ 0, 6, 5 ], 					// tip of profile
		[ 1, 7, 6 ], [ 1, 2, 7 ], 					// upper side of profile
		[ 0, 5, 4 ], [ 4, 5, 9 ], 					// lower side of profile
		[ 3, 4, 9 ], [ 9, 8, 3 ], [ 2, 3, 8 ], [ 8, 7, 2 ], 	// back of profile
		[ 0, 4, 3 ], [ 0, 3, 2 ], [ 0, 2, 1 ], 			// a side of profile
		[ 5, 8, 9 ], [ 5, 7, 8 ], [ 5, 6, 7 ]  			// b side of profile
		 ];
	

	// this is the back of the raised part of the profile
	polyhedron( polyPoints1, polyTriangles1 );
}

module trapezoidThread(
	length=45,				// axial length of the threaded rod
	pitch=10,				// axial distance from crest to crest
	pitchRadius=10,			// radial distance from center to mid-profile
	threadHeightToPitch=0.5,	// ratio between the height of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	profileRatio=0.5,			// ratio between the lengths of the raised part of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	threadAngle=30,			// angle between the two faces of the thread
						// std value for Acme is 29 or for metric lead screw is 30
	RH=true,				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	clearance=0.1,			// radial clearance, normalized to thread height
	backlash=0.1,			// axial clearance, normalized to pitch
	stepsPerTurn=24			// number of slices to create per turn
		)
{

	numberTurns=length/pitch;
		
	steps=stepsPerTurn*numberTurns;

	trapezoidRatio=				2*profileRatio*(1-backlash);

	function	threadAngleTop(i)=	threadAngle/2;
	function	threadAngleBottom(i)=	-threadAngle/2;

	function 	threadHeight(i)=		pitch*threadHeightToPitch;

	function	pitchRadius(i)=		pitchRadius;
	function	minorRadius(i)=		pitchRadius(i)-0.5*threadHeight(i);
	
	function 	X(i)=				minorRadius(i)*cos(i*360*numberTurns);
	function 	Y(i)=				minorRadius(i)*sin(i*360*numberTurns);
	function 	Z(i)=				pitch*numberTurns*i;

	function	tip(i)=			trapezoidRatio*(1-0.5*sin(threadAngleTop(i))+0.5*sin(threadAngleBottom(i)));

	// this is the threaded rod

	if (RH==true)
	translate([0,0,-threadHeight(0)*sin(threadAngleBottom(0))])
	for (i=[0:steps-1])
	{
		threadPiece(
			Xa=				X(i/steps),
			Ya=				Y(i/steps),
			Za=				Z(i/steps),
			Xb=				X((i+1)/steps),
			Yb=				Y((i+1)/steps), 
			Zb=				Z((i+1)/steps), 
			radiusa=			threadHeight(i/steps), 
			radiusb=			threadHeight((i+1)/steps),
			tipRatioa=			tip(i/steps),
			tipRatiob=			tip((i+1)/steps),
			threadAngleTop=		threadAngleTop(i), 
			threadAngleBottom=	threadAngleBottom(i)
			);

		shaftPiece(
			Xa=				X(i/steps),
			Ya=				Y(i/steps),
			Za=				Z(i/steps),
			Xb=				X((i+1)/steps),
			Yb=				Y((i+1)/steps), 
			Zb=				Z((i+1)/steps), 
			radiusa=			threadHeight(i/steps), 
			radiusb=			threadHeight((i+1)/steps),
			tipRatioa=			tip(i/steps),
			tipRatiob=			tip((i+1)/steps),
			threadAngleTop=		threadAngleTop(i), 
			threadAngleBottom=	threadAngleBottom(i)
			);
	}

	if (RH==false)
	translate([0,0,-threadHeight(0)*sin(threadAngleBottom(0))])
	mirror([0,1,0])
	for (i=[0:steps-1])
	{
		threadPiece(
			Xa=				X(i/steps),
			Ya=				Y(i/steps),
			Za=				Z(i/steps),
			Xb=				X((i+1)/steps),
			Yb=				Y((i+1)/steps), 
			Zb=				Z((i+1)/steps), 
			radiusa=			threadHeight(i/steps), 
			radiusb=			threadHeight((i+1)/steps),
			tipRatioa=			tip(i/steps),
			tipRatiob=			tip((i+1)/steps),
			threadAngleTop=		threadAngleTop(i), 
			threadAngleBottom=	threadAngleBottom(i)
			);

		shaftPiece(
			Xa=				X(i/steps),
			Ya=				Y(i/steps),
			Za=				Z(i/steps),
			Xb=				X((i+1)/steps),
			Yb=				Y((i+1)/steps), 
			Zb=				Z((i+1)/steps), 
			radiusa=			threadHeight(i/steps), 
			radiusb=			threadHeight((i+1)/steps),
			tipRatioa=			tip(i/steps),
			tipRatiob=			tip((i+1)/steps),
			threadAngleTop=		threadAngleTop(i), 
			threadAngleBottom=	threadAngleBottom(i)
			);
	}

//	rotate([0,0,180/stepsPerTurn])
	cylinder(
		h=length+threadHeight(1)*(tip(1)+sin( threadAngleTop(1) )-1*sin( threadAngleBottom(1) ) ),
		r1=minorRadius(0)-clearance*threadHeight(0),
		r2=minorRadius(0)-clearance*threadHeight(0),
		$fn=stepsPerTurn
			);
}

module trapezoidThreadNegativeSpace(
	length=45,				// axial length of the threaded rod
	pitch=10,				// axial distance from crest to crest
	pitchRadius=10,			// radial distance from center to mid-profile
	threadHeightToPitch=0.5,	// ratio between the height of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	profileRatio=0.5,			// ratio between the lengths of the raised part of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	threadAngle=30,			// angle between the two faces of the thread
						// std value for Acme is 29 or for metric lead screw is 30
	RH=true,				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	countersunk=0,			// depth of 45 degree chamfered entries, normalized to pitch
	clearance=0.1,			// radial clearance, normalized to thread height
	backlash=0.1,			// axial clearance, normalized to pitch
	stepsPerTurn=24			// number of slices to create per turn
		)
{

	translate([0,0,-countersunk*pitch])	
	cylinder(
		h=2*countersunk*pitch, 
		r2=pitchRadius+clearance*pitch+0.25*pitch,
		r1=pitchRadius+clearance*pitch+0.25*pitch+2*countersunk*pitch,
		$fn=24
			);

	translate([0,0,countersunk*pitch])	
	translate([0,0,-pitch])
	trapezoidThread(
		length=length+0.5*pitch, 				// axial length of the threaded rod 
		pitch=pitch, 					// axial distance from crest to crest
		pitchRadius=pitchRadius+clearance*pitch, 	// radial distance from center to mid-profile
		threadHeightToPitch=threadHeightToPitch, 	// ratio between the height of the profile and the pitch 
									// std value for Acme or metric lead screw is 0.5
		profileRatio=profileRatio, 			// ratio between the lengths of the raised part of the profile and the pitch
									// std value for Acme or metric lead screw is 0.5
		threadAngle=threadAngle,			// angle between the two faces of the thread
									// std value for Acme is 29 or for metric lead screw is 30
		RH=true, 						// true/false the thread winds clockwise looking along shaft
									// i.e.follows  Right Hand Rule
		clearance=0, 					// radial clearance, normalized to thread height
		backlash=-backlash, 				// axial clearance, normalized to pitch
		stepsPerTurn=stepsPerTurn 			// number of slices to create per turn
			);	

	translate([0,0,length-countersunk*pitch])
	cylinder(
		h=2*countersunk*pitch, 
		r1=pitchRadius+clearance*pitch+0.25*pitch,
		r2=pitchRadius+clearance*pitch+0.25*pitch+2*countersunk*pitch,$fn=24,
		$fn=24
			);
}

module trapezoidNut(
	length=45,				// axial length of the threaded rod
	radius=25,				// outer radius of the nut
	pitch=10,				// axial distance from crest to crest
	pitchRadius=10,			// radial distance from center to mid-profile
	threadHeightToPitch=0.5,	// ratio between the height of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	profileRatio=0.5,			// ratio between the lengths of the raised part of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	threadAngle=30,			// angle between the two faces of the thread
						// std value for Acme is 29 or for metric lead screw is 30
	RH=true,				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	countersunk=0,			// depth of 45 degree chamfered entries, normalized to pitch
	clearance=0.1,			// radial clearance, normalized to thread height
	backlash=0.1,			// axial clearance, normalized to pitch
	stepsPerTurn=24			// number of slices to create per turn
		)
{
	difference() 
	{
		cylinder(
			h=length,
			r1=radius, 
			r2=radius,
			$fn=6
				);
		
		trapezoidThreadNegativeSpace(
			length=length, 					// axial length of the threaded rod 
			pitch=pitch, 					// axial distance from crest to crest
			pitchRadius=pitchRadius, 			// radial distance from center to mid-profile
			threadHeightToPitch=threadHeightToPitch, 	// ratio between the height of the profile and the pitch 
										// std value for Acme or metric lead screw is 0.5
			profileRatio=profileRatio, 			// ratio between the lengths of the raised part of the profile and the pitch
										// std value for Acme or metric lead screw is 0.5
			threadAngle=threadAngle,			// angle between the two faces of the thread
										// std value for Acme is 29 or for metric lead screw is 30
			RH=true, 						// true/false the thread winds clockwise looking along shaft
										// i.e.follows  Right Hand Rule
			countersunk=countersunk,			// depth of 45 degree countersunk entries, normalized to pitch
			clearance=clearance, 				// radial clearance, normalized to thread height
			backlash=backlash, 				// axial clearance, normalized to pitch
			stepsPerTurn=stepsPerTurn 			// number of slices to create per turn
				);	
	}
}




