/// Extruder Upper Block for Deltaprintr

/* [Base] */
 Base_size = 20;                    // height of the complete extruder upper Block
 Spring_Standoff_Height = 2;        // height of springstandoff
/* [Holes and Pulley] */
 Filament_Hole = 3;                 // diameter of filamenthole
 Extruder_Mount_Hole_diameter = 4;  // diameter of extrudermountscrew 
 Pulley_Diameter = 12;              // diameter of Pulley 
 Pulley_Screw_Diameter = 2.9;       // diameter of pulleyscrewhole 
 Pulley_Height = 2.5;               // height of Pulley
 
/* [Thread] */
/// Screwlibary from syvwlch  http://www.thingiverse.com/syvwlch/about
 Pitch = 5;

/* [Screw] */
 Head_Height = 10;                   // screwhead height
 Head_Diameter= 20;                  // diameter of screwhead
 Head_Edges = 6;                     // screwheadedges
 Screw_Length = 30;                  // screwlength
 Screw_Scale  = 0.95;                // Scale the screw to better fit into thread

/* [Hidden] */
//Parameters for OpenScad
 h = Base_size;        
 d1 = Extruder_Mount_Hole_diameter;      
 d2 = Pulley_Screw_Diameter;    
 d3 = Pulley_Diameter;     
 d4 = Head_Diameter;       
 h1 = Pulley_Height;    
 h2 = Spring_Standoff_Height;      
 filhole = Filament_Hole;

 edges = Head_Edges;      
 screwlength = Screw_Length; 
 screwpitch = Pitch;   //Pitch of thread
 screwradius = Pitch +0.5; //Radius of outer pitch
 headheigth = Head_Height;
 screwscale = Screw_Scale; 

 ///////////////
 ///Render//////
 ///////////////
 block();
 screw();
 
 //modules
 module block(){
     translate ([0,0,19.7])
     rotate ([-90,0,0])
     difference() {
     base();
     holes();
     pulley();
     springthread();
 }}
 module base() {       //basesketch
     linear_extrude(height = h) 
     translate ([105,148,0])sketch();
     translate ([-23,4.13,0]) rotate ([90,0,0]) linear_extrude(h2) square([16,h],0);
 };
 module sketch() {  //basesketch
  polygon(points=
    [[-135.499, -144.368], [-128.324, -144.368], [-121.149, -144.368], [-113.974, -144.368], [-106.799, -144.368], [-103.888, -146.283], [-101.452, -148.725], [-99.560, -151.609], [-98.281, -154.851], [-97.545, -156.286], [-96.355, -157.289], [-94.874, -157.768], [-93.267, -157.632], [-90.873, -156.649], [-88.758, -155.208], [-86.983, -153.363], [-85.614, -151.168], [-85.347, -150.530], [-85.155, -149.868], [-85.039, -149.189], [-84.999, -148.499], [-84.999, -145.966], [-84.999, -143.433], [-84.999, -140.901], [-84.999, -138.368], [-85.785, -134.476], [-87.928, -131.297], [-91.107, -129.154], [-94.999, -128.368], [-105.124, -128.368], [-115.249, -128.368], [-125.374, -128.368], [-135.499, -128.368], [-138.612, -128.997], [-141.155, -130.712], [-142.869, -133.254], [-143.497, -136.368], [-142.869, -139.482], [-141.155, -142.024], [-138.612, -143.739]]
    , paths=
    [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 0, 0, 0]]
    );}
 module holes(){       //holes
     translate ([15.15,10.3,-1]) cylinder(h+2,d1/2,d1/2,$fn=10);
     translate ([10.6,-5.26,-1]) cylinder(h+2,d2/2,d2/2,$fn=10);
     rotate([90,0,0]) translate ([4.5,h/2,-25]) cylinder(30,filhole/2,filhole/2,$fn=10);
     }
 
 module pulley(){      //Pulley
     translate ([10.6,-5.26,h/2-h1]) cylinder(h1*2,d3/2,d3/2); 
     
 } 
 
 module springthread (){    //Springtrhe
    translate ([-9,10,h/2]) rotate([90,0,0,]) thread();
}



 module thread(){       //Thread
length=screwlength;
pitch=screwpitch;
pitchRadius=screwradius; 

translate([-pitchRadius,0,-length/2])
    
     trapezoidThread(
	length=length, 			// axial length of the threaded rod 
	pitch=pitch, 			// axial distance from crest to crest
	pitchRadius=pitchRadius, 	// radial distance from center to mid-profile
	threadHeightToPitch=0.2, 	// ratio between the height of the profile and the pitch 
						// std value for Acme or metric lead screw is 0.5
	profileRatio=0.5, 			// ratio between the lengths of the raised part of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	threadAngle=30,			// angle between the two faces of the thread 
						// std value for Acme is 29 or for metric lead screw is 30
	RH=true, 				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	clearance=0.1, 			// radial clearance, normalized to thread height
	backlash=0.1, 			// axial clearance, normalized to pitch
	stepsPerTurn=24 			// number of slices to create per turn
		);
    }
    
 posx = -50;
 posy = 10;
 posz = screwlength /2;
 
 module screwbody(){
    translate ([posx,posy,posz]) thread();
}
 module screwhead(){
    translate ([posx-screwradius,posy,posz*2+1]) linear_extrude(headheigth)circle (r= d4/2, $fn= edges);
}
 module screw(){
translate([-10,20,screwscale*(screwlength+headheigth+1.4)]) rotate([180,0,0]) scale(screwscale)
union(){
screwbody();
screwhead();}    
}



///////////////////////////
/////////thread libary/////
///////////////////////////

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

	rotate([0,0,180/stepsPerTurn])
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