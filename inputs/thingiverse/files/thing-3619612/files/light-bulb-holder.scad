$fn=64;

//x,y,D,L1,L2,latches
bulbs=[[10,10,10,20,30,32],[-10,10,5,10,20,8],[-3,3,5,10,20,8],[-10,-10,10,20,30,32],[8,-8,15,25,30,32]];

box=[50,30,20];

padL = 2;
padWall = 2;
wall = 1;
latchGap = 1;
r = 1;
bulbBase = [1,0,2*r];
latchClearance=2;

not=0.001+0.001;

////////////////////////////////


difference(){
	box(box);
	for(b=bulbs){
		tr([b.x,b.y,+not],[180,0,0]) cylinderHolderNegative(bulbBase,b[2],b[4]-bulbBase.z-latchGap-latchClearance,padWall,r,latchClearance);
	}
}

for(b=bulbs){
	tr([b.x,b.y,0],[180,0,0]) cylinderHolder(bulbBase,b[2],b[3],padL,padWall,wall,b[5],latchGap,r);
}

//cylinderHolder(base,cylinderD,latchL,padL,padWall,wall,latches,latchGap,r);

//#cylinderHolderNegative();

///////////////////////////////
module cylinderHolder(
	base=[5,0,2],
	cylinderD=15,
	latchL=10,
	padL=2,
	padWall = 2,
	wall = 1,
	latches = 32,
	latchGap = 2,
	r = 1
){
	cylinderRounded(d=[cylinderD,cylinderD+base.x],h=base.z,r=[r,0,0,0]);

	difference(){
		u(){
			t([0,0,base.z]) cylinderRounded(d=[cylinderD,cylinderD+wall],h=latchL-padL,r=[0,0,-(padWall-wall)/4,0]);
			t([0,0,base.z+latchL-padL]) cylinderRounded(d=[cylinderD+wall-padWall,cylinderD+wall],h=padL,r=[(padWall-wall)/4,0,padWall/4,padWall/4]);
		}
		
		for(i=[0:360/latches:360]){
			rt([0,0,i],[0,-(cylinderD+base.x),base.z]) triangle3D(latchGap,cylinderD+base.x,latchL);
		}
	}
}
module cylinderHolderNegative(
	base=[5,0,2],
	cylinderD=15,
	latchL=10,
	padWall = 2,
	r = 1,
	gap = 2
){
	cylinderRounded(d=[0,cylinderD],h=base.z+latchL+gap,r=[0,-r,0,0]);
	t([0,0,base.z]) cylinderRounded(d=[0,cylinderD+padWall],h=latchL+gap,r=[0,0,0,r]);
}

///////////////////////////////

module cylinderRounded(d=[20,40],h=30,r=[1,-10,4,1]){
	rotate_extrude(convexity = 10)
	{
		//square
		difference(){
			translate([d[0]/2,0,0]) square([(d[1]-d[0])/2,h]);
			if(r[0]>0) translate([d[0]/2,0,0]) square([r[0],r[0]]);
			if(r[1]>0) translate([d[1]/2-r[1],0,0]) square([r[1],r[1]]);
			if(r[2]>0) translate([d[0]/2,h-r[2],0]) square([r[2],r[2]]);
			if(r[3]>0) translate([d[1]/2-r[3],h-r[3],0]) square([r[3],r[3]]);
		}
		
		//corners
		
		if(r[0]>0){
			intersection(){
				translate([d[0]/2+r[0], r[0], 0]) circle(r = r[0]);
				translate([d[0]/2,0,0]) square([r[0],r[0]]);
			}
		} else {
			difference(){
				translate([d[0]/2+r[0], 0, 0]) square([-r[0],-r[0]]);
				translate([d[0]/2+r[0], -r[0], 0]) circle(r = -r[0]);
			}
		}
		
		if(r[1]>0){
			intersection(){
				translate([d[1]/2-r[1], r[1], 0]) circle(r = r[1]);
				translate([d[1]/2-r[1],0,0]) square([r[1],r[1]]);
			}
		} else {
			difference(){
				translate([d[1]/2, 0, 0]) square([-r[1],-r[1]]);
				translate([d[1]/2-r[1], -r[1], 0]) circle(r = -r[1]);
			}
		}
		
		if(r[2]>0){
			intersection(){
				translate([d[0]/2+r[2], h-r[2], 0]) circle(r = r[2]);
				translate([d[0]/2,h-r[2],0]) square([r[2],r[2]]);
			}
		} else {
			difference(){
				translate([d[0]/2+r[2], h+r[2], 0]) square([-r[2],-r[2]]);
				translate([d[0]/2+r[2], h+r[2], 0]) circle(r = -r[2]);
			}
		}

		if(r[3]>0){
			intersection(){
				translate([d[1]/2-r[3], h-r[3], 0]) circle(r = r[3]);
				translate([d[1]/2-r[3],h-r[3],0]) square([r[3],r[3]]);
			}
		} else {
			difference(){
				translate([d[1]/2, h+r[3], 0]) square([-r[3],-r[3]]);
				translate([d[1]/2-r[3], h+r[3], 0]) circle(r = -r[3]);
			}
		}		
	}
}

module triangle3D(angle=10,h=10,z=10){
	linear_extrude(z) triangle(angle,h);
}

module triangle(angle=10,h=10){	
	r=angle/2;
	base=h*tan(r);
	sidex=2.1*base*cos(r);
	sidey=h/cos(r)+base;
	
	intersection(){
		translate([-base,0,0]) rotate([0,0,-r]) square([sidex,sidey]);
		translate([base,0,0]) rotate([0,0,r]) translate([-sidex,0,0]) square([sidex,sidey]);
		translate([-1.1*base,0,0]) square([2.2*base,1.1*h]);
	}
}

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0]){rotate(a) children();}
module tr(v=[0,0,0],a=[0,0,0]){t(v) r(a) children();}
module rt(a=[0,0,0],v=[0,0,0]){r(a) t(v) children();}
module u(){union() children();}

module box(size=[50,50,50]){

	wall = 1;
	bodyHeight = size.z+wall;
	bodyWidth = size.x;

	rounding = bodyWidth/2;
	threadPitch = 5;
	threadTurns = 1;
	capHeight = size.y-threadPitch*(threadTurns+0.5);


	fullCap = 1;
	circularity = 50;
	threadPrecision = circularity;

	roundingSide = 0;
	roundingBottom = 3;
	capRounding=[roundingBottom,0.5];

	translate([0,0,-capHeight-threadPitch*(threadTurns+0.5)]) cap();
	translate([bodyWidth+wall,0,0]) body();


	module cap() {
		difference (){
			union () {
				difference(){
					translate ([0,0,capHeight-threadPitch]) trapezoidThread(length=(threadTurns+1.0)*threadPitch, pitch=threadPitch, pitchRadius = bodyWidth/2-threadPitch/4-wall, stepsPerTurn=threadPrecision);
					
					translate([-bodyWidth/2,-bodyWidth/2,capHeight+(threadTurns+0.5)*threadPitch]) cube([bodyWidth,bodyWidth,threadPitch]);
					translate([-bodyWidth/2,-bodyWidth/2,0]) cube([bodyWidth,bodyWidth,capHeight]);
					
				}
				//#cylinder(r=bodyWidth/2,h=capHeight);
				knob(d=bodyWidth,h=capHeight);
			}
			
	//		translate([0,0,-.01]) notches(r1=bodyWidth/2-threadPitch/2, r2=bodyWidth/2, h=capHeight+0.02);
	//		torus(r=bodyWidth/2);
			
			if(!fullCap) translate([0,0,wall]) cylinder(r=bodyWidth/2-2*wall-threadPitch/2,h=capHeight+(threadTurns+1)*threadPitch);
		}    
	}

	module body() {
		h1 = threadPitch*(threadTurns+.5); // thread height
		h2 = bodyHeight-(h1-wall); // height of straight body
		
		rt([180,0,0],[0,0,-bodyHeight]){
			// straight body
	//		translate([-bodyWidth/2,-bodyWidth/2,h1]) difference(){
	//			cubeRounded([bodyWidth,bodyWidth,h2-wall], r=rounding);
	//			translate ([wall,wall,-2*wall]) cubeRounded([bodyWidth-2*wall,bodyWidth-2*wall,h2], r=rounding-wall);
	//		}
			t([0,0,h1-wall]) difference(){
				cylinderRounded( d=[0,bodyWidth],h=h2,r=[0,0,0,roundingBottom]);
				t([0,0,-wall]) cylinderRounded( d=[0,bodyWidth-2*wall],h=h2,r=[0,0,0,max(0,roundingBottom-wall)]);
				//translate ([wall,wall,-2*wall]) cubeRounded([bodyWidth-2*wall,bodyWidth-2*wall,h2], r=rounding-wall);
			}
			
			// slope body
			difference(){
				difference(){
					// outer body
					rt([0,0,45],[0,0,-bodyWidth/2+h1]) cylinder (r1=0,r2=bodyWidth/2*sqrt(2),h=bodyWidth/2, $fn=4);
					// inner cut
					difference(){
						rt([0,0,45],[0,0,-bodyWidth/2+h1+wall*sqrt(2)]) cylinder (r1=0,r2=bodyWidth/2*sqrt(2),h=bodyWidth/2, $fn=4);
						difference(){
							translate([-bodyWidth,-bodyWidth,0]) cube([bodyWidth*2,bodyWidth*2,h2]);
							translate([-bodyWidth/2+wall,-bodyWidth/2+wall,0]) cubeRounded([bodyWidth-2*wall,bodyWidth-2*wall,h2], r=rounding-wall);
						}
					}
				}
				//center hole
				translate ([0,0,-bodyWidth+0.001]) cylinder (r=bodyWidth/2,h=h1+bodyWidth+0.001);
				// rounding edges
				difference(){
					translate([-bodyWidth,-bodyWidth,0]) cube([bodyWidth*2,bodyWidth*2,h2]);
					translate([-bodyWidth/2,-bodyWidth/2,0]) cubeRounded([bodyWidth,bodyWidth,h2], r=rounding);
				}
				// cutting top
				translate([-bodyWidth/2,-bodyWidth/2,-bodyWidth]) cube([bodyWidth,bodyWidth,bodyWidth]);
			}

			// thread
			difference(){	
				translate ([0,0,0]) cylinder (r=bodyWidth/2,h=h1);
				body_thread(2*h1);
			}
		}
	}


	module knob(d=10,h=10) {

		notchesDepth = wall;

		//bottom rounding of knob
		rounding1 = capRounding[0];
		//top rounding of knob
		rounding2 = capRounding[1];
		//outer diameter of the nut
		nut = 0;
		// M3 = 6.15, M5 = 8.8;

		nutDepth = 3.75;
		bolt = 0;
		
		noth = 0.01; // hack for preview only
		tol = 0.15;

		module notches(r1=1, r2=2, h=1){
			r3 = (r2-r1)*1.5 + r1; //actual outer radius
			r4 = r3-r1; //notch radius
			if(r4>0.001) {
				pi = 3.1415926535897932384626433832795;
				number = floor(pi*r3/r4*.8);
				angle = 360/number;
				for(i = [0 : angle : 360]) {           
						rotate([0,0,i]) translate ([r3,0,0]) cylinder (r=r4,h=h,center=false);
				}
			}
		}

		module nut(d=3, h=1){
			cylinder(d=d,h=h,$fn=6);
		}

		module cylinderRounded(d=10,h=10,r1=4,r2=1){
			r_1 = (r1<=0)?0.0001:r1;
			r_2 = (r2<=0)?0.0001:r2;
			
			hull(){
				translate([0,0,r_1]) mirror([0,0,1]) torusQuart(r1=d/2-r_1,r2=r_1);
				translate([0,0,h-r_2]) torusQuart(r1=d/2-r_2,r2=r_2);
			}
		}

		module torusQuart(r1=10,r2=1){
			rotate_extrude(convexity = 10)
			intersection(){
				translate([r1, 0, 0]) circle(r = r2);
				translate([r1, 0, 0]) square([2*r2,2*r2]);
			}
		}

		intersection(){
			difference (){
				cylinder(r=d/2,h=h);		
				translate([0,0,-noth]) notches(r1=d/2-notchesDepth, r2=d/2, h=h+2*noth);
				translate([0,0,h-nutDepth+noth]) nut(d=nut+tol,h=nutDepth); //smaller tolerance so it fits firmly
			}    
			cylinderRounded(h=h,d=d,r1=rounding1,r2=rounding2);
		}
	}

	module body_thread(h = 1) {
		translate ([0,0,0]) trapezoidThreadNegativeSpace(length=h, pitch=threadPitch, pitchRadius = bodyWidth/2-threadPitch/4-wall, stepsPerTurn=threadPrecision);
	}

}

module cubeRounded(dim=[10,10,10], r=1){
	difference(){
		cube(dim);
		translate([-0.001,-0.001,-0.001]) cube([r+0.001,r+0.001,dim[2]+0.002]);
		translate([dim[0]+0.001-r,-0.001,-0.001]) cube([r+0.001,r+0.001,dim[2]+0.002]);
		translate([-0.001,dim[1]+0.001-r,-0.001]) cube([r+0.001,r+0.001,dim[2]+0.002]);
		translate([dim[0]+0.001-r,dim[1]+0.001-r,-0.001]) cube([r+0.001,r+0.001,dim[2]+0.002]);
	}
	translate([r,r,0]) cylinder(r=r, h=dim[2]);
	translate([dim[0]-r,r,0]) cylinder(r=r, h=dim[2]);
	translate([r,dim[1]-r,0]) cylinder(r=r, h=dim[2]);
	translate([dim[0]-r,dim[1]-r,0]) cylinder(r=r, h=dim[2]);
}


/*
* Thread library: http://www.thingiverse.com/thing:8793 by syvwlch
* Copied in to have one code file
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

	//threadAngleTop=15;
	//threadAngleBottom=-15;

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

	rotate([0,0,180/stepsPerTurn])
	cylinder(
		h=length+threadHeight(1)*(tip(1)+sin( threadAngleTop(1) )-1*sin( threadAngleBottom(1) ) ),
		r1=minorRadius(0)-clearance*threadHeight(0),
		r2=minorRadius(0)-clearance*threadHeight(0)
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
		r1=pitchRadius+clearance*pitch+0.25*pitch+2*countersunk*pitch
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
		r2=pitchRadius+clearance*pitch+0.25*pitch+2*countersunk*pitch
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
			r2=radius
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


module cylinderRounded(d=[20,40],h=30,r=[1,-10,4,1]){
	rotate_extrude(convexity = 10)
	{
		//square
		difference(){
			translate([d[0]/2,0,0]) square([(d[1]-d[0])/2,h]);
			if(r[0]>0) translate([d[0]/2,0,0]) square([r[0],r[0]]);
			if(r[1]>0) translate([d[1]/2-r[1],0,0]) square([r[1],r[1]]);
			if(r[2]>0) translate([d[0]/2,h-r[2],0]) square([r[2],r[2]]);
			if(r[3]>0) translate([d[1]/2-r[3],h-r[3],0]) square([r[3],r[3]]);
		}
		
		//corners
		
		if(r[0]>0){
			intersection(){
				translate([d[0]/2+r[0], r[0], 0]) circle(r = r[0]);
				translate([d[0]/2,0,0]) square([r[0],r[0]]);
			}
		} else {
			difference(){
				translate([d[0]/2+r[0], 0, 0]) square([-r[0],-r[0]]);
				translate([d[0]/2+r[0], -r[0], 0]) circle(r = -r[0]);
			}
		}
		
		if(r[1]>0){
			intersection(){
				translate([d[1]/2-r[1], r[1], 0]) circle(r = r[1]);
				translate([d[1]/2-r[1],0,0]) square([r[1],r[1]]);
			}
		} else {
			difference(){
				translate([d[1]/2, 0, 0]) square([-r[1],-r[1]]);
				translate([d[1]/2-r[1], -r[1], 0]) circle(r = -r[1]);
			}
		}
		
		if(r[2]>0){
			intersection(){
				translate([d[0]/2+r[2], h-r[2], 0]) circle(r = r[2]);
				translate([d[0]/2,h-r[2],0]) square([r[2],r[2]]);
			}
		} else {
			difference(){
				translate([d[0]/2+r[2], h+r[2], 0]) square([-r[2],-r[2]]);
				translate([d[0]/2+r[2], h+r[2], 0]) circle(r = -r[2]);
			}
		}

		if(r[3]>0){
			intersection(){
				translate([d[1]/2-r[3], h-r[3], 0]) circle(r = r[3]);
				translate([d[1]/2-r[3],h-r[3],0]) square([r[3],r[3]]);
			}
		} else {
			difference(){
				translate([d[1]/2, h+r[3], 0]) square([-r[3],-r[3]]);
				translate([d[1]/2-r[3], h+r[3], 0]) circle(r = -r[3]);
			}
		}		
	}
}

