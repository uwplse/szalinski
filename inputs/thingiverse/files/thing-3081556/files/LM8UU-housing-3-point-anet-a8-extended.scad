// copyright aeropic 2017

// play with this value to trim the screw diameter. (If you use threads set it to 4 mm)
screw_diam = 3.5; //[2.9,3,3.1,3.9,4,4.1,4.2]

// bushing outer diameter
bushing_diam = 15.3; //[14.9,15,15.1,15.2]

// do you want  M4 nuts ?
nuts = "no"; //["yes","no"]

// do you want  threads ? (if yes set the screw diam to 4mm)
threads = "no"; //["no","yes"]

// do you want bottom restriction ?
bottom = "yes"; //["yes","no"]


/* [Hidden] */
$fn = 100;




// ISO Metric Thread Implementation
// Trevor Moseley
// 20/04/2014

// For thread dimensions see
//   http://en.wikipedia.org/wiki/File:ISO_and_UTS_Thread_Dimensions.svg



//--pitch-----------------------------------------------------------------------
// function for ISO coarse thread pitch (these are specified by ISO)
function get_coarse_pitch(dia) = lookup(dia, [
[1,0.25],[1.2,0.25],[1.4,0.3],[1.6,0.35],[1.8,0.35],[2,0.4],[2.5,0.45],[3,0.5],[3.5,0.6],[4,0.7],[5,0.8],[6,1],[7,1],[8,1.25],[10,1.5],[12,1.75],[14,2],[16,2],[18,2.5],[20,2.5],[22,2.5],[24,3],[27,3],[30,3.5],[33,3.5],[36,4],[39,4],[42,4.5],[45,4.5],[48,5],[52,5],[56,5.5],[60,5.5],[64,6],[78,5]]);

//--top level modules-----------------------------------------------------------
module thread_in(dia,hi,thr=$fn)
// make an inside thread (as used on a nut)
//  dia = diameter, 6=M6 etc
//  hi = height, 10=make a 10mm long thread
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	p = get_coarse_pitch(dia);
	thread_in_pitch(dia,hi,p,thr);
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

//--low level modules-----------------------------------------------------------
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



// three holes to go around the screws that poke through the carriage, size can be changed here by d=
module three_holes (diam, faces) {
     translate  ([0,12,7.5]) rotate ([0,90,0]) cylinder(d= 5, h = 30, center = true, $fn =faces);
 translate  ([0,12,-7.5]) rotate ([0,90,0]) cylinder(d= 5, h = 30, center = true, $fn =faces);
     translate  ([0,-12,0]) rotate ([0,90,0]) cylinder(d= 5, h = 30, center = true, $fn =faces);
}
// 4 holes, repositioned for center mount on anet a8 y carrier using original carrier mount holes
module four_screws(diam, faces) {
 translate  ([0,12,28]) rotate ([0,90,0]) cylinder(d= diam, h = 30, center = true, $fn =faces);
 translate  ([0,12,-28]) rotate ([0,90,0]) cylinder(d= diam, h = 30, center = true, $fn =faces);    
 translate  ([0,-12,28]) rotate ([0,90,0]) cylinder(d= diam, h = 30, center = true, $fn =faces);
 translate  ([0,-12,-28]) rotate ([0,90,0]) cylinder(d= diam, h = 30, center = true, $fn =faces);


}

module four_threads() {

translate  ([4.2,12,9])rotate([0,90,0])thread_in(4,7);						// make an M4 x 7 ISO thread
    translate  ([4.2,12,-9])rotate([0,90,0])thread_in(4,7);						// make an M4 x 7 ISO thread
    translate  ([4.2,-12,9])rotate([0,90,0])thread_in(4,7);						// make an M4 x 7 ISO thread
    translate  ([4.2,-12,-9])rotate([0,90,0])thread_in(4,7);						// make an M4 x 7 ISO thread
    
}
 
module top(){
 * hull(){
      #translate ([8,0,14.45]) rotate ([0,0,-90])cube ([20,1.2,0.1],center = true);
    #translate ([8,0,12.8]) rotate ([0,0,-90])cube ([20,3,0.5],center = true);
  }
   if (threads == "yes") #four_threads();
difference(){
    hull(){
        translate ([9.5,0,0]) rotate ([0,0,-90])cube ([32,4,64],center = true);
        cylinder (d=bushing_diam+3, h = 29,center = true);
        }
#translate ([0,0,20])cylinder (d=bushing_diam, h = 64,center = true) ;
    if (bottom == "no") #translate ([0,0,0])cylinder (d=bushing_diam, h = 29,center = true);
        
 cylinder (d=bushing_diam*10/15, h = 62,center = true); // drill the bootom hole
 
 three_holes(screw_diam, 100); // drill the hole holes
    
 four_screws(screw_diam, 100); // drill the screws holes
    
 if (nuts == "yes") translate  ([-7,0,0])  # four_screws(6.5, 6);

rotate ([0,0,-90])#translate ([0,-5.5,15-3]) rotate ([0,90,0]) cylinder (d=0.9, h = 49,center = true); // insert the pin
 
 if (bottom == "no") rotate ([0,0,-90])#translate ([0,-5.5,-15+2.5]) rotate ([0,90,0]) cylinder (d=0.9, h = 49,center = true); // insert the bottom pin

}
}



top();


