/* [Global] */
Quality=45;
WallSize = 2;

/* [Big Tube] */
BigTubeDia = 40;
BigTubeLen = 15;
BigTubePitch = 4;

/* [Small Tube] */
LilTubeDia = 25;
LilTubeLen = 15;
LilTubePitch = 2;

/* [Rubber Ring] */
RubberThickness = 4;

/* [Hidden] */
RubberRay = BigTubeDia/2-RubberThickness;

$fn = Quality;

// ISO Metric Thread Implementation
// Trevor Moseley
// 20/04/2014

// For thread dimensions see
//   http://en.wikipedia.org/wiki/File:ISO_and_UTS_Thread_Dimensions.svg
// ISO Metric Thread Implementation
// Trevor Moseley
// 20/04/2014

// For thread dimensions see
//   http://en.wikipedia.org/wiki/File:ISO_and_UTS_Thread_Dimensions.svg

//$fn=60;
WrenchSizes=0;	// =0= Rolson sizes, =1=Fairbury sizes

//--demo functions--------------------------------------------------------------

//hex_bolt(10,16);						// make an M10 x 16 ISO bolt
//hex_nut(10);							// make an M10 ISO nut
//hex_bolt(8,16);						// make an M8 x 16 ISO bolt
//hex_nut(8);							// make an M8 ISO nut
//hex_bolt(6,12);						// make an M6 x 12 ISO bolt
//hex_nut(6);							// make an M6 ISO nut
//thread_out(8,16);					// make an M8 x 16 ISO thread
//thread_out_centre(8,16);				// make a centre for an M8 x 16 ISO thread
//thread_out_pitch(8,16,1.0);			// make an M8 x 16 thread with 1 mm pitch
//thread_out_centre_pitch(8,16,0.5);	// make the centre for an M8 x 16 thread with 1 mm pitch
//thread_in(8,10);						// make an M8 x 10 ISO thread
//thread_in_ring(8,10,2);				// make a ring to enclose an M8 x 10 ISO thread with thickness 2 mm
//thread_in_pitch(8,10,1.0);			// make an M8 x 10 thread with 1mm pitch

//--pitch-----------------------------------------------------------------------
// function for ISO coarse thread pitch (these are specified by ISO)
function get_coarse_pitch(dia) = lookup(dia, [
[1,0.25],[1.2,0.25],[1.4,0.3],[1.6,0.35],[1.8,0.35],[2,0.4],[2.5,0.45],[3,0.5],[3.5,0.6],[4,0.7],[5,0.8],[6,1],[7,1],[8,1.25],[10,1.5],[12,1.75],[14,2],[16,2],[18,2.5],[20,2.5],[22,2.5],[24,3],[27,3],[30,3.5],[33,3.5],[36,4],[39,4],[42,4.5],[45,4.5],[48,5],[52,5],[56,5.5],[60,5.5],[64,6],[78,5]]);

//--nut dims--------------------------------------------------------------------
// these are NOT specified by ISO
// support is provided for Rolson or Fairbury sizes, see WrenchSizes above

// function for Rolson hex nut diameter from thread size
function rolson_hex_nut_dia(dia) = lookup(dia, [
[3,6.4],[4,8.1],[5,9.2],[6,11.5],[8,16.0],[10,19.6],[12,22.1],[16,27.7],[20,34.6],[24,41.6],[30,53.1],[36,63.5]]);
// function for Rolson hex nut height from thread size
function rolson_hex_nut_hi(dia) = lookup(dia, [
[3,2.4],[4,3.2],[5,4],[6,3],[8,5],[10,5],[12,10],[16,13],[20,16],[24,19],[30,24],[36,29]]);

// function for Fairbury hex nut diameter from thread size
function fairbury_hex_nut_dia(dia) = lookup(dia, [
[3,6.0],[4,7.7],[5,8.8],[6,11.0],[8,14.4],[10,17.8],[12,20.0],[16,26.8],[20,33.0],[24,40.0],[30,50.9],[36,60.8]]);
// function for Fairbury hex nut height from thread size
function fairbury_hex_nut_hi(dia) = lookup(dia, [
[3,2.2],[4,3.0],[5,4.5],[6,5.0],[8,6.5],[10,8.1],[12,10.4],[16,14.2],[20,17],[24,20.3],[30,24.4],[36,29.5]]);

//--bolt dims-------------------------------------------------------------------
// these are NOT specified by ISO
// support is provided for Rolson or Fairbury sizes, see WrenchSizes above

// function for Rolson hex bolt head diameter from thread size
function rolson_hex_bolt_dia(dia) = lookup(dia, [
[3,6.4],[4,8.1],[5,9.2],[6,11.5],[8,14.0],[10,16],[12,22.1],[16,27.7],[20,34.6],[24,41.6],[30,53.1],[36,63.5]]);
// function for Rolson hex bolt head height from thread size
function rolson_hex_bolt_hi(dia) = lookup(dia, [
[3,2.4],[4,3.2],[5,4],[6,3.5],[8,4.5],[10,5],[12,10],[16,13],[20,16],[24,19],[30,24],[36,29]]);

// function for Fairbury hex bolt head diameter from thread size
function fairbury_hex_bolt_dia(dia) = lookup(dia, [
[3,6.4],[4,8.1],[5,8.8],[6,11.1],[8,14.4],[10,17.8],[12,20.1],[16,26.8],[20,33.0],[24,39.6],[30,50.9],[36,60.8]]);
// function for Fairbury hex bolt head height from thread size
function fairbury_hex_bolt_hi(dia) = lookup(dia, [
[3,2.4],[4,3.2],[5,3.4],[6,3.9],[8,5.1],[10,6.2],[12,7.3],[16,9.7],[20,12.2],[24,14.6],[30,17.9],[36,21.7]]);

//--top level modules-----------------------------------------------------------

module hex_bolt(dia,hi)
// make an ISO bolt
//  dia=diameter, 6=M6 etc.
//  hi=length of threaded part of bolt
{
	if (WrenchSizes==0)	rolson_hex_bolt(dia,hi);
	else					fairbury_hex_bolt(dia,hi);
}

module hex_nut(dia,hi)
// make an ISO nut
//  dia=diameter, 6=M6 etc.
{
	if (WrenchSizes==0)	rolson_hex_nut(dia);
	else					fairbury_hex_nut(dia);
}

module thread_out(dia,hi,thr=$fn)
// make an outside ISO thread (as used on a bolt)
//  dia=diameter, 6=M6 etc
//  hi=height, 10=make a 10mm long thread
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	p = get_coarse_pitch(dia);
	thread_out_pitch(dia,hi,p,thr);
}

module thread_in(dia,hi,thr=$fn)
// make an inside thread (as used on a nut)
//  dia = diameter, 6=M6 etc
//  hi = height, 10=make a 10mm long thread
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	p = get_coarse_pitch(dia);
	thread_in_pitch(dia,hi,p,thr);
}

module thread_out_pitch(dia,hi,p,thr=$fn)
// make an outside thread (as used on a bolt) with supplied pitch
//  dia=diameter, 6=M6 etc
//  hi=height, 10=make a 10mm long thread
//  p=pitch
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	h=(cos(30)*p)/8;
	Rmin=(dia/2)-(5*h);	// as wiki Dmin
	s=360/thr;				// length of segment in degrees
	t1=(hi-p)/p;			// number of full turns
	r=t1%1.0;				// length remaining (not full turn)
	t=t1-r;					// integer number of full turns
	n=r/(p/thr);			// number of segments for remainder
	// do full turns
	for(tn=[0:t-1])
		translate([0,0,tn*p])	th_out_turn(dia,p,thr);
	// do remainder
	for(sg=[0:n])
		th_out_pt(Rmin+0.1,p,s,sg+(t*thr),thr,h,p/thr);
}

module thread_in_pitch(dia,hi,p,thr=$fn)
// make an inside thread (as used on a nut)
//  dia = diameter, 6=M6 etc
//  hi = height, 10=make a 10mm long thread
//  p=pitch
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	h=(cos(30)*p)/8;
	Rmin=(dia/2)-(5*h);	// as wiki Dmin
	s=360/thr;				// length of segment in degrees
	t1=(hi-p)/p;			// number of full turns
	r=t1%1.0;				// length remaining (not full turn)
	t=t1-r;					// integer number of turns
	n=r/(p/thr);			// number of segments for remainder
	for(tn=[0:t-1])
		translate([0,0,tn*p])	th_in_turn(dia,p,thr);
	for(sg=[0:n])
		th_in_pt(Rmin+0.1,p,s,sg+(t*thr),thr,h,p/thr);
}

module thread_out_centre(dia,hi)
{
	p = get_coarse_pitch(dia);
	thread_out_centre_pitch(dia,hi,p);
}

module thread_out_centre_pitch(dia,hi,p)
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	cylinder(r = Rmin, h = hi);
}

module thread_in_ring(dia,hi,thk)
{
	difference()
	{
		cylinder(r = (dia/2)+0.5,h = hi);
		translate([0,0,-1]) cylinder(r = (dia/2)+0.1, h = hi+thk);
	}
}

//--low level modules-----------------------------------------------------------

module rolson_hex_bolt(dia,hi)
// make an ISO bolt with Rolson wrench sizes
//  dia=diameter, 6=M6 etc.
//  hi=length of threaded part of bolt
{
	hhi = rolson_hex_bolt_hi(dia);
	cylinder(r = rolson_hex_bolt_dia(dia)/2,h = hhi, $fn=6);
	translate([0,0,hhi-0.1])	thread_out(dia,hi+0.1);
	translate([0,0,hhi-0.1])	thread_out_centre(dia,hi+0.1);
}

module fairbury_hex_bolt(dia,hi)
// make an ISO bolt with Fairbury wrench sizes
//  dia=diameter, 6=M6 etc.
//  hi=length of threaded part of bolt
{
	hhi = fairbury_hex_bolt_hi(dia);
	cylinder(r = fairbury_hex_bolt_dia(dia)/2,h = hhi, $fn=6);
	translate([0,0,hhi-0.1])	thread_out(dia,hi+0.1);
	translate([0,0,hhi-0.1])	thread_out_centre(dia,hi+0.1);
}

module rolson_hex_nut(dia)
// make an ISO nut with Rolson wrench sizes
//  dia=diameter, 6=M6 etc.
{
	hi = rolson_hex_nut_hi(dia);
	difference()
	{
		cylinder(r = rolson_hex_nut_dia(dia)/2,h = hi, $fn=6);
		translate([0,0,-0.1])	cylinder(r = dia/2, h =hi + 0.2);
	}
	translate([0,0,0.1])	thread_in(dia,hi-0.2);
}

module fairbury_hex_nut(dia)
// make an ISO nut with Fairbury wrench sizes
//  dia=diameter, 6=M6 etc.
{
	hi = fairbury_hex_nut_hi(dia);
	difference()
	{
		cylinder(r = fairbury_hex_nut_dia(dia)/2,h = hi, $fn=6);
		translate([0,0,-0.1])	cylinder(r = dia/2, h =hi + 0.2);
	}
	translate([0,0,0.1])	thread_in(dia,hi-0.2);
}

module th_out_turn(dia,p,thr=$fn)
// make a single turn of an outside thread
//  dia=diameter, 6=M6 etc
//  p=pitch
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	for(sg=[0:thr-1])
		th_out_pt(Rmin+0.1,p,s,sg,thr,h,p/thr);
}

module th_out_pt(rt,p,s,sg,thr,h,sh)
// make a part of an outside thread (single segment)
//  rt = radius of thread (nearest centre)
//  p = pitch
//  s = segment length (degrees)
//  sg = segment number
//  thr = segments in circumference
//  h = ISO h of thread / 8
//  sh = segment height (z)
{
	as = (sg % thr) * s;			// angle to start of seg
	ae = as + s  - (s/100);		// angle to end of seg (with overlap)
	z = sh*sg;
	//pp = p/2;
	//   1,4
	//   |\
	//   | \  2,5
 	//   | / 
	//   |/
	//   0,3
	//  view from front (x & z) extruded in y by sg
	//  
	//echo(str("as=",as,", ae=",ae," z=",z));
	polyhedron(
		points = [
			[cos(as)*rt,sin(as)*rt,z],								// 0
			[cos(as)*rt,sin(as)*rt,z+(3/4*p)],						// 1
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z+(3/8*p)],		// 2
			[cos(ae)*rt,sin(ae)*rt,z+sh],							// 3
			[cos(ae)*rt,sin(ae)*rt,z+(3/4*p)+sh],					// 4
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+sh+(3/8*p)]],	// 5
		faces = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}

module th_in_turn(dia,p,thr=$fn)
// make an single turn of an inside thread
//  dia = diameter, 6=M6 etc
//  p=pitch
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	for(sg=[0:thr-1])
		th_in_pt(Rmin+0.1,p,s,sg,thr,h,p/thr);
}

module th_in_pt(rt,p,s,sg,thr,h,sh)
// make a part of an inside thread (single segment)
//  rt = radius of thread (nearest centre)
//  p = pitch
//  s = segment length (degrees)
//  sg = segment number
//  thr = segments in circumference
//  h = ISO h of thread / 8
//  sh = segment height (z)
{
	as = ((sg % thr) * s - 180);	// angle to start of seg
	ae = as + s -(s/100);		// angle to end of seg (with overlap)
	z = sh*sg;
	pp = p/2;
	//         2,5
	//          /|
	//     1,4 / | 
 	//         \ |
	//          \|
	//         0,3
	//  view from front (x & z) extruded in y by sg
	//  
	polyhedron(
		points = [
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z],				//0
			[cos(as)*rt,sin(as)*rt,z+(3/8*p)],						//1
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z+(3/4*p)],		//2
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+sh],			//3
			[cos(ae)*rt,sin(ae)*rt,z+(3/8*p)+sh],					//4
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+(3/4*p)+sh]],	//5
		faces = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}

WrenchSizes=0;	// =0= Rolson sizes, =1=Fairbury sizes

//--demo functions--------------------------------------------------------------

//hex_bolt(10,16);						// make an M10 x 16 ISO bolt
//hex_nut(10);							// make an M10 ISO nut
//hex_bolt(8,16);						// make an M8 x 16 ISO bolt
//hex_nut(8);							// make an M8 ISO nut
//hex_bolt(6,12);						// make an M6 x 12 ISO bolt
//hex_nut(6);							// make an M6 ISO nut
//thread_out(8,16);					// make an M8 x 16 ISO thread
//thread_out_centre(8,16);				// make a centre for an M8 x 16 ISO thread
//thread_out_pitch(8,16,1.0);			// make an M8 x 16 thread with 1 mm pitch
//thread_out_centre_pitch(8,16,0.5);	// make the centre for an M8 x 16 thread with 1 mm pitch
//thread_in(8,10);						// make an M8 x 10 ISO thread
//thread_in_ring(8,10,2);				// make a ring to enclose an M8 x 10 ISO thread with thickness 2 mm
//thread_in_pitch(8,10,1.0);			// make an M8 x 10 thread with 1mm pitch

//--pitch-----------------------------------------------------------------------
// function for ISO coarse thread pitch (these are specified by ISO)
function get_coarse_pitch(dia) = lookup(dia, [
[1,0.25],[1.2,0.25],[1.4,0.3],[1.6,0.35],[1.8,0.35],[2,0.4],[2.5,0.45],[3,0.5],[3.5,0.6],[4,0.7],[5,0.8],[6,1],[7,1],[8,1.25],[10,1.5],[12,1.75],[14,2],[16,2],[18,2.5],[20,2.5],[22,2.5],[24,3],[27,3],[30,3.5],[33,3.5],[36,4],[39,4],[42,4.5],[45,4.5],[48,5],[52,5],[56,5.5],[60,5.5],[64,6],[78,5]]);

//--nut dims--------------------------------------------------------------------
// these are NOT specified by ISO
// support is provided for Rolson or Fairbury sizes, see WrenchSizes above

// function for Rolson hex nut diameter from thread size
function rolson_hex_nut_dia(dia) = lookup(dia, [
[3,6.4],[4,8.1],[5,9.2],[6,11.5],[8,16.0],[10,19.6],[12,22.1],[16,27.7],[20,34.6],[24,41.6],[30,53.1],[36,63.5]]);
// function for Rolson hex nut height from thread size
function rolson_hex_nut_hi(dia) = lookup(dia, [
[3,2.4],[4,3.2],[5,4],[6,3],[8,5],[10,5],[12,10],[16,13],[20,16],[24,19],[30,24],[36,29]]);

// function for Fairbury hex nut diameter from thread size
function fairbury_hex_nut_dia(dia) = lookup(dia, [
[3,6.0],[4,7.7],[5,8.8],[6,11.0],[8,14.4],[10,17.8],[12,20.0],[16,26.8],[20,33.0],[24,40.0],[30,50.9],[36,60.8]]);
// function for Fairbury hex nut height from thread size
function fairbury_hex_nut_hi(dia) = lookup(dia, [
[3,2.2],[4,3.0],[5,4.5],[6,5.0],[8,6.5],[10,8.1],[12,10.4],[16,14.2],[20,17],[24,20.3],[30,24.4],[36,29.5]]);

//--bolt dims-------------------------------------------------------------------
// these are NOT specified by ISO
// support is provided for Rolson or Fairbury sizes, see WrenchSizes above

// function for Rolson hex bolt head diameter from thread size
function rolson_hex_bolt_dia(dia) = lookup(dia, [
[3,6.4],[4,8.1],[5,9.2],[6,11.5],[8,14.0],[10,16],[12,22.1],[16,27.7],[20,34.6],[24,41.6],[30,53.1],[36,63.5]]);
// function for Rolson hex bolt head height from thread size
function rolson_hex_bolt_hi(dia) = lookup(dia, [
[3,2.4],[4,3.2],[5,4],[6,3.5],[8,4.5],[10,5],[12,10],[16,13],[20,16],[24,19],[30,24],[36,29]]);

// function for Fairbury hex bolt head diameter from thread size
function fairbury_hex_bolt_dia(dia) = lookup(dia, [
[3,6.4],[4,8.1],[5,8.8],[6,11.1],[8,14.4],[10,17.8],[12,20.1],[16,26.8],[20,33.0],[24,39.6],[30,50.9],[36,60.8]]);
// function for Fairbury hex bolt head height from thread size
function fairbury_hex_bolt_hi(dia) = lookup(dia, [
[3,2.4],[4,3.2],[5,3.4],[6,3.9],[8,5.1],[10,6.2],[12,7.3],[16,9.7],[20,12.2],[24,14.6],[30,17.9],[36,21.7]]);

//--top level modules-----------------------------------------------------------

module hex_bolt(dia,hi)
// make an ISO bolt
//  dia=diameter, 6=M6 etc.
//  hi=length of threaded part of bolt
{
	if (WrenchSizes==0)	rolson_hex_bolt(dia,hi);
	else					fairbury_hex_bolt(dia,hi);
}

module hex_nut(dia,hi)
// make an ISO nut
//  dia=diameter, 6=M6 etc.
{
	if (WrenchSizes==0)	rolson_hex_nut(dia);
	else					fairbury_hex_nut(dia);
}

module thread_out(dia,hi,thr=$fn)
// make an outside ISO thread (as used on a bolt)
//  dia=diameter, 6=M6 etc
//  hi=height, 10=make a 10mm long thread
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	p = get_coarse_pitch(dia);
	thread_out_pitch(dia,hi,p,thr);
}

module thread_in(dia,hi,thr=$fn)
// make an inside thread (as used on a nut)
//  dia = diameter, 6=M6 etc
//  hi = height, 10=make a 10mm long thread
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	p = get_coarse_pitch(dia);
	thread_in_pitch(dia,hi,p,thr);
}

module thread_out_pitch(dia,hi,p,thr=$fn)
// make an outside thread (as used on a bolt) with supplied pitch
//  dia=diameter, 6=M6 etc
//  hi=height, 10=make a 10mm long thread
//  p=pitch
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	h=(cos(30)*p)/8;
	Rmin=(dia/2)-(5*h);	// as wiki Dmin
	s=360/thr;				// length of segment in degrees
	t1=(hi-p)/p;			// number of full turns
	r=t1%1.0;				// length remaining (not full turn)
	t=t1-r;					// integer number of full turns
	n=r/(p/thr);			// number of segments for remainder
	// do full turns
	for(tn=[0:t-1])
		translate([0,0,tn*p])	th_out_turn(dia,p,thr);
	// do remainder
	for(sg=[0:n])
		th_out_pt(Rmin+0.1,p,s,sg+(t*thr),thr,h,p/thr);
}

module thread_in_pitch(dia,hi,p,thr=$fn)
// make an inside thread (as used on a nut)
//  dia = diameter, 6=M6 etc
//  hi = height, 10=make a 10mm long thread
//  p=pitch
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	h=(cos(30)*p)/8;
	Rmin=(dia/2)-(5*h);	// as wiki Dmin
	s=360/thr;				// length of segment in degrees
	t1=(hi-p)/p;			// number of full turns
	r=t1%1.0;				// length remaining (not full turn)
	t=t1-r;					// integer number of turns
	n=r/(p/thr);			// number of segments for remainder
	for(tn=[0:t-1])
		translate([0,0,tn*p])	th_in_turn(dia,p,thr);
	for(sg=[0:n])
		th_in_pt(Rmin+0.1,p,s,sg+(t*thr),thr,h,p/thr);
}

module thread_out_centre(dia,hi)
{
	p = get_coarse_pitch(dia);
	thread_out_centre_pitch(dia,hi,p);
}

module thread_out_centre_pitch(dia,hi,p)
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	cylinder(r = Rmin, h = hi);
}

module thread_in_ring(dia,hi,thk)
{
	difference()
	{
		cylinder(r = (dia/2)+0.5,h = hi);
		translate([0,0,-1]) cylinder(r = (dia/2)+0.1, h = hi+thk);
	}
}

//--low level modules-----------------------------------------------------------

module rolson_hex_bolt(dia,hi)
// make an ISO bolt with Rolson wrench sizes
//  dia=diameter, 6=M6 etc.
//  hi=length of threaded part of bolt
{
	hhi = rolson_hex_bolt_hi(dia);
	cylinder(r = rolson_hex_bolt_dia(dia)/2,h = hhi, $fn=6);
	translate([0,0,hhi-0.1])	thread_out(dia,hi+0.1);
	translate([0,0,hhi-0.1])	thread_out_centre(dia,hi+0.1);
}

module fairbury_hex_bolt(dia,hi)
// make an ISO bolt with Fairbury wrench sizes
//  dia=diameter, 6=M6 etc.
//  hi=length of threaded part of bolt
{
	hhi = fairbury_hex_bolt_hi(dia);
	cylinder(r = fairbury_hex_bolt_dia(dia)/2,h = hhi, $fn=6);
	translate([0,0,hhi-0.1])	thread_out(dia,hi+0.1);
	translate([0,0,hhi-0.1])	thread_out_centre(dia,hi+0.1);
}

module rolson_hex_nut(dia)
// make an ISO nut with Rolson wrench sizes
//  dia=diameter, 6=M6 etc.
{
	hi = rolson_hex_nut_hi(dia);
	difference()
	{
		cylinder(r = rolson_hex_nut_dia(dia)/2,h = hi, $fn=6);
		translate([0,0,-0.1])	cylinder(r = dia/2, h =hi + 0.2);
	}
	translate([0,0,0.1])	thread_in(dia,hi-0.2);
}

module fairbury_hex_nut(dia)
// make an ISO nut with Fairbury wrench sizes
//  dia=diameter, 6=M6 etc.
{
	hi = fairbury_hex_nut_hi(dia);
	difference()
	{
		cylinder(r = fairbury_hex_nut_dia(dia)/2,h = hi, $fn=6);
		translate([0,0,-0.1])	cylinder(r = dia/2, h =hi + 0.2);
	}
	translate([0,0,0.1])	thread_in(dia,hi-0.2);
}

module th_out_turn(dia,p,thr=$fn)
// make a single turn of an outside thread
//  dia=diameter, 6=M6 etc
//  p=pitch
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	for(sg=[0:thr-1])
		th_out_pt(Rmin+0.1,p,s,sg,thr,h,p/thr);
}

module th_out_pt(rt,p,s,sg,thr,h,sh)
// make a part of an outside thread (single segment)
//  rt = radius of thread (nearest centre)
//  p = pitch
//  s = segment length (degrees)
//  sg = segment number
//  thr = segments in circumference
//  h = ISO h of thread / 8
//  sh = segment height (z)
{
	as = (sg % thr) * s;			// angle to start of seg
	ae = as + s  - (s/100);		// angle to end of seg (with overlap)
	z = sh*sg;
	//pp = p/2;
	//   1,4
	//   |\
	//   | \  2,5
 	//   | / 
	//   |/
	//   0,3
	//  view from front (x & z) extruded in y by sg
	//  
	//echo(str("as=",as,", ae=",ae," z=",z));
	polyhedron(
		points = [
			[cos(as)*rt,sin(as)*rt,z],								// 0
			[cos(as)*rt,sin(as)*rt,z+(3/4*p)],						// 1
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z+(3/8*p)],		// 2
			[cos(ae)*rt,sin(ae)*rt,z+sh],							// 3
			[cos(ae)*rt,sin(ae)*rt,z+(3/4*p)+sh],					// 4
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+sh+(3/8*p)]],	// 5
		faces = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}

module th_in_turn(dia,p,thr=$fn)
// make an single turn of an inside thread
//  dia = diameter, 6=M6 etc
//  p=pitch
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	for(sg=[0:thr-1])
		th_in_pt(Rmin+0.1,p,s,sg,thr,h,p/thr);
}

module th_in_pt(rt,p,s,sg,thr,h,sh)
// make a part of an inside thread (single segment)
//  rt = radius of thread (nearest centre)
//  p = pitch
//  s = segment length (degrees)
//  sg = segment number
//  thr = segments in circumference
//  h = ISO h of thread / 8
//  sh = segment height (z)
{
	as = ((sg % thr) * s - 180);	// angle to start of seg
	ae = as + s -(s/100);		// angle to end of seg (with overlap)
	z = sh*sg;
	pp = p/2;
	//         2,5
	//          /|
	//     1,4 / | 
 	//         \ |
	//          \|
	//         0,3
	//  view from front (x & z) extruded in y by sg
	//  
	polyhedron(
		points = [
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z],				//0
			[cos(as)*rt,sin(as)*rt,z+(3/8*p)],						//1
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z+(3/4*p)],		//2
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+sh],			//3
			[cos(ae)*rt,sin(ae)*rt,z+(3/8*p)+sh],					//4
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+(3/4*p)+sh]],	//5
		faces = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}

// --------------------------------------------------------------------------------------

// Support WallSize
module thread_in_ring(dia,hi,thk)
{
	difference()
	{
		cylinder(r = (dia/2)+WallSize,h = hi);
		translate([0,0,-1]) cylinder(r = (dia/2)+0.1, h = hi+thk);
	}
}

difference() {
  union() {
    // Overlap tubes by 0.01 to ensure manifoldness...
    translate([0, 0, 0.01-BigTubeLen-WallSize]) {
      // Make some support/rubber greave
      cylinder(r1=LilTubeDia/2, r2=RubberRay, h=BigTubeLen);
      // Make that wider part
      thread_in_ring(BigTubeDia, BigTubeLen+WallSize, -WallSize, Quality);
      // This pitch makes the threads too high, trim them
      difference(){
        thread_in_pitch(BigTubeDia, BigTubeLen, BigTubePitch, Quality);
        cylinder(r=BigTubeDia/2-1, h=BigTubeLen);
      }
    }
    // Small tube on top
    thread_out_centre_pitch(LilTubeDia, LilTubeLen, LilTubePitch, Quality);
    translate([0, 0, LilTubePitch]) // Leave room in the threading.
      thread_out_pitch(LilTubeDia, LilTubeLen-LilTubePitch, LilTubePitch, Quality);
  }
  // 0.01 over on both ends to make it render pretty
  translate([0, 0, -BigTubeLen-WallSize])
    cylinder(r=LilTubeDia/2-WallSize-1, h=BigTubeLen+LilTubeLen+WallSize+0.01);
}
