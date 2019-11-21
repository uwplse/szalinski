// Bee Feeder V2
// 		http://www.thingiverse.com/thing:2008534
// I'd prefer creative commons, but due to libraries, licence is GPL
//
// Uses:
//   My original (blender) version
//      http://www.thingiverse.com/thing:269229
//   Canning Jar Lid by Alex English - ProtoParadigm
//		http://www.thingiverse.com/thing:19105
//   Thread Library by syvwlch 
//      http://www.thingiverse.com/thing:8793

/* [main] */

// you can either create a lid, or poke holes in a regular jar lid
create_part=0; // [0:Bee Feeder,1:drip lid]

// resolution 1=regular(aka 1x)
resfactor=1.0;

// What size canning jar to use
jar_threads=0; // [0:Regular,1:Wide mouth]

/* [bee feeder] */

// How tall the entrance to the hive is (mm) (default is 3/4 inch)
hive_entrance_height=19.05;

// How thick the side of the hive is (mm) (default is 3/4 inch)
hive_wall_thickness=19.05;

// distance from hive to jar (rim) - must be far enough to allow jar to tilt
// default value is about right for
from_jar_to_hive=22;

// what shape to make bee tunnles
tunnelShape=0; // [0:Round,1:Hex]

// size for bee tunnels (mm) (standard is 3/8 inch)
bee_size=9.5;

// thickness for the threads wall (mm)
threads_wall_thickness=2;

// how deep the threaded area should be (mm)
threads_deapth=15;

// how high the hook protrudes into the hive (mm) (default = 1/4in)
hook_height=6.35;

// how wide the base of the hooks are (mm) (default = 1/4in)
hook_width=6.35; // 1/4 inch

// how thick the ceiling and floor of the bee tunnel are (mm)
tunnel_floor_thick=1;

// how thick the support gussts are (mm) (can be 0 to turn off)
gusset_thick=1.5;

// require this much spacing between bee tunnels (mm)
min_tunnel_spacing=0.1;

// how many sides the threaded area has (even numbers work better)
threaded_area_sides=102;

/* [drip lid] */

// how thick the jar lid is (mm)
jar_lid_thickness=0.5;

// how big should the drip holes be (mm)
drip_hole_dia=0.55;

// drip holes per square inch
drip_hole_density=2.25;

/* [hidden] */

function myFnFunc(r)=max(3*r,12)*resfactor;


// --------------------- Thread library
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

// --------------------- Jar library

regularMouthR = 71 / 2; // Regular Mouth Jar Cap Inner Radius
wideMouthR = 87 / 2; // Wide Mouth Jar Cap Inner Radius
jarThreadsWallThick = threads_wall_thickness;
jarThreadsDeapth = threads_deapth;
ring_height = jarThreadsDeapth + jarThreadsWallThick;
thread_height = 1.7;
thread_quality = 10+resfactor*40; //~10 for draft, 45, 60,72, or 90 for higher qualities, higher numbers dramatically increase render time, and increase the poly count, wich will increase file sizes and slicing times, but will make smoother curves
mouthR=jar_threads==0?regularMouthR:wideMouthR;
ringR=mouthR-1.325;
jarInnerR=mouthR-7;
jarLidFacets=threaded_area_sides;

module jarRing(mouthR){
	difference(){
		cylinder(r=(mouthR+jarThreadsWallThick), jarThreadsDeapth, $fn=jarLidFacets);
		trapezoidThreadNegativeSpace(length=jarThreadsDeapth + jarThreadsWallThick, pitch=6.35, pitchRadius=(mouthR-1.524), threadHeightToPitch=(1.524/6.35), profileRatio=1.66, threadAngle=30, RH=true, countersunk=0, clearance=0.1, backlash=0.1, stepsPerTurn=thread_quality); //threads and hole
	}
}

module jarLid(mouthR){
	translate([0,0,ring_height]) rotate([180, 0, 0]) difference(){
		union(){
			jarRing(mouthR); //Outer ring with threads
			translate([0,0,jarThreadsDeapth]) cylinder(r=(mouthR+jarThreadsWallThick), jarThreadsWallThick, $fa=30); //top surface
			translate([0,0,jarThreadsDeapth]) rotate_extrude(convexity = 10, $fn = 100) translate([mouthR-7, 0, 0]) circle(r = 2, $fn = 100); //torus on underside of lid for tighter seal
		}
		translate([0, 0, ring_height]) rotate_extrude(convexity=10, $fa=1) translate([mouthR+jarThreadsWallThick, 0, 0]) rotate([0,0,40]) scale([jarThreadsWallThick, jarThreadsWallThick*2]) square(1, true); //chamfer on top edge
	}
}

module jarLidlessLid(mouthR,addChamfer=false){
	// a jar lid that accepts a canning lid
	translate([0,0,jarThreadsDeapth]) rotate([180, 0, 0]) difference() {
		union() {
			jarRing(mouthR); //Outer ring with threads
			translate([0,0,jarThreadsDeapth]) difference(){
				cylinder(r=(mouthR+jarThreadsWallThick),h=jarThreadsWallThick,$fn=jarLidFacets); //top surface
				cylinder(r=jarInnerR,h=jarThreadsWallThick, $fn=myFnFunc(jarInnerR)); //top surface
			}
		}
		if(addChamfer){
			translate([0, 0, ring_height]) rotate_extrude(convexity=10, $fa=1) translate([mouthR+jarThreadsWallThick, 0, 0]) rotate([0,0,40]) scale([jarThreadsWallThick, jarThreadsWallThick*2]) square(1, true); //chamfer on top edge
		}
	}
}

// ----------------- my stuff

scoche=0.02;

module circleArray(r){
	step=25.4/drip_hole_density;
	numHoles=floor((r*2)/step);
	offs=((r*2)-(numHoles*step))/2; // offset for centering
	union(){
		for(x=[-r+offs:step:r]){
			for(y=[-r+offs:step:r]){
				mag=sqrt(x*x+y*y);
				if(mag<(r-drip_hole_dia/2)){ // only draw holes within the circle
					translate([x,y,0]) circle(r=drip_hole_dia/2,$fn=myFnFunc(drip_hole_dia/2));
				}
			}
		}
	}
	// alignment tool
	/*translate([0,0,1]) difference(){
		square([r*3,r*3],center=true);
		circle(r=r);
	}*/
}

module cylinderArray(r,h){
	linear_extrude(h) circleArray(r);
}

module jarLidWithHoles(ringR,thickness){
	// a flat surface with holes
	linear_extrude(thickness) difference(){
		circle(r=ringR,$fn=myFnFunc(ringR));
		circleArray(jarInnerR);
	}
	// the raised seal
	rotate_extrude(convexity = 10, $fn=myFnFunc(ringR*2)) translate([jarInnerR, 0, 0]) difference() {
		circle(r = 2, $fn = 32); //torus on underside of lid for tighter seal
		translate([-2,-4]) square([4,4]);
	}
}

module shaker(mouthR){
	difference(){
		jarLid(mouthR);
		translate([0,0,-scoche]) cylinderArray(jarInnerR,jarThreadsWallThick+scoche*2);
	}
}

module chamfer(xyz){
	// creates a chamfer angle, extruded along y axis
	// params are similar to cube()
	x=xyz[0];
	y=xyz[1];
	z=xyz[2];
	hyp=sqrt(x*x+z*z);
	ang=atan(z/x);
	translate([0,y,0]) rotate([90,0,0]) linear_extrude(y) difference(){
		square([x,z]);
		translate([0,z,1]) rotate([0,0,-ang]) square([hyp,hyp]);
	}
}

module gusset(h1,h2,l,thick){
	// create a webbing gusset
	t=0.02;
	rotate([90,0,0]) translate([0,0,-thick/2]) linear_extrude(thick) hull(){
		translate([0,h1-t]) square(t);
		translate([0,0]) square(t);
		translate([l-t,h2-t]) square(t);
		translate([l-t,0]) square(t);
	}
}

module beeFeeder(mouthR){
	rad_adj=mouthR+jarThreadsWallThick;
	hive_wall_thickness_adj=hive_wall_thickness+1; // make it a little wider to account for irregularities
	hive_entrance_height_adj=hive_entrance_height-0.5;
	pivot_r=hive_wall_thickness_adj+hook_width;
	jr_offs=tunnel_floor_thick*2+bee_size;
	numHoles=floor((jarInnerR*2)/(bee_size+min_tunnel_spacing));
	offs=((jarInnerR*2)-(numHoles*bee_size))/numHoles; // offset for each hole
	step=bee_size+offs;
	difference(){
		union(){
			// bee entrance thick for under hive entrance
			translate([-hook_width-hive_wall_thickness_adj,0,hive_entrance_height_adj/2]) rotate([0,90,0]) linear_extrude(hive_wall_thickness_adj+hook_width*2) difference(){
				square([hive_entrance_height_adj,rad_adj*2],center=true);
				for(y=[-jarInnerR+step/2:step:jarInnerR]){
					translate([hive_entrance_height_adj/2-bee_size/2-tunnel_floor_thick,y]) rotate([0,0,30]) circle(r=bee_size/2,$fn=(tunnelShape==0?myFnFunc(bee_size/2):6));
				}
			}
			// bee entrance long tunnel to the jar
			translate([0,0,tunnel_floor_thick+bee_size/2]) rotate([0,90,0]) linear_extrude(rad_adj+from_jar_to_hive) difference(){
				square([tunnel_floor_thick*2+bee_size,rad_adj*2],center=true);
				for(y=[-jarInnerR+step/2:step:jarInnerR]){
					translate([tunnel_floor_thick+bee_size/2-bee_size/2-tunnel_floor_thick,y]) rotate([0,0,30]) circle(r=bee_size/2,$fn=(tunnelShape==0?myFnFunc(bee_size/2):6));
				}
			}
			// gussets from jar to hook for added strength
			if(gusset_thick>0){
				translate([0, rad_adj-gusset_thick/2,tunnel_floor_thick*2+bee_size]) gusset(h2=jarThreadsDeapth,h1=hook_height+hive_entrance_height_adj-tunnel_floor_thick*2-bee_size,l=rad_adj+from_jar_to_hive,thick=gusset_thick);
				translate([0,-rad_adj+gusset_thick/2,tunnel_floor_thick*2+bee_size]) gusset(h2=jarThreadsDeapth,h1=hook_height+hive_entrance_height_adj-tunnel_floor_thick*2-bee_size,l=rad_adj+from_jar_to_hive,thick=gusset_thick);
			}
			// half-round for the end
			translate([from_jar_to_hive+rad_adj,0,0]) linear_extrude(hive_entrance_height_adj) difference(){
				circle(r=rad_adj,$fn=jarLidFacets);
				translate([-rad_adj*2,-rad_adj]) square([rad_adj*2,rad_adj*2]);
			}
			// add a hook
			translate([-hive_wall_thickness_adj,-rad_adj,hive_entrance_height_adj]) mirror([1,0,0]) chamfer([hook_width,rad_adj*2,hook_height]);
			translate([0,-rad_adj,hive_entrance_height_adj]) chamfer([hook_width,rad_adj*2,hook_height]);
		}
		
		// recess for jar ring
		translate([from_jar_to_hive+rad_adj,0,jr_offs]) cylinder(r=rad_adj,h=hive_entrance_height_adj,$fn=jarLidFacets);
		// inside of feeder area
		translate([from_jar_to_hive+rad_adj,0,tunnel_floor_thick]) cylinder(r=jarInnerR,h=hive_entrance_height_adj,$fn=myFnFunc(jarInnerR));
		// roundover so it can hook in
		translate([-scoche,rad_adj*2,pivot_r-scoche]) rotate([90,0,0]) linear_extrude(rad_adj*4) difference() {
			translate([-pivot_r,-pivot_r]) square([pivot_r,pivot_r]);
			circle(r=pivot_r,$fn=myFnFunc(pivot_r));
		}
	}
	// the threads, etc
	translate([from_jar_to_hive+mouthR+jarThreadsWallThick,0,hive_entrance_height_adj-jr_offs]) difference(){
		jarLidlessLid(mouthR);
		translate([0,0,-0.5]) cylinder(r=jarInnerR,h=jarThreadsWallThick+1,$fn=myFnFunc(jarInnerR));
	}
	// measurement tools
	//translate([0,-0.5,0]) cube([from_jar_to_hive,1,50]);
}

echo(mouthR,jarInnerR,ringR);
if(create_part==0){ // bee feeder
	beeFeeder(mouthR);
}else{ // lid 
	jarLidWithHoles(ringR,jar_lid_thickness);
}