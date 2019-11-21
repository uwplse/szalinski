// washing line wench 30/07/2012 Trev Moseley
// modified to make a parametric powered wench by James Newton
// copied all the include files into this one source file so it will work in customizer online.

/* [Render] */
//Select which part to generate. Customizer should generate each as an .stl file
part = "all"; // [all,base,face,top,reel,drive]

/* [wench] */
wench_height = 60; //How tall should the wench be?
wench_id = 30;	//How big should the line spool be?
wench_line_od = 1;	//How thick is your line?
wench_base_thickness = 10; //How thick should the base and cap be?

/* [Hidden] */
wench_reel_od = wench_id + 30;
wench_reel_flange = wench_reel_od + 20;
wench_reel_flange_thickness = 10;
wench_cap_thickness = wench_base_thickness;
wench_reel_height = wench_height - wench_base_thickness;


/* [Gear] */
wench_reel_gear_teeth = 51;
wench_drive_gear_teeth = 13;
wench_drive_gear_hub_h = 12;
wench_drive_gear_setscrew_offset = 5;
wench_drive_gear_setscrew_od = 3.5; //M3 clearance is 3.5
wench_drive_gear_nut_d = 6.2;
wench_drive_gear_nut_h = 3;

/* [Hidden] */
wench_gear_h = wench_reel_flange_thickness;
//distance between the shafts of the two gears. 
wench_gear_d = wench_reel_od;
wench_drive_ratio = wench_reel_gear_teeth / wench_drive_gear_teeth;
wench_gear_pitch = 	360*wench_gear_d/(wench_reel_gear_teeth + wench_drive_gear_teeth);
wench_drive_gear_od = wench_drive_gear_teeth * wench_gear_pitch / 180;
wench_drive_gear_hub_d = wench_drive_gear_od;

/* [Motor] */
wench_motor_size = 23; //NEMA number
wench_motor_adjust = 2; //amount we can slide the motor in either direction.
wench_motor_nut_size = 4; //M# for bolt. 4 gives 7mm accross flats which is about right for an M4
wench_motor_nut_height = 5;
wench_drive_gear_shaft_d = 6.4;//6.35 is 1/4 inch NEMA 23. NEMA 17 is 5mm, 34 is 9.5
wench_drive_gear_setscrew_r = wench_drive_gear_setscrew_od/2;

/* [Hidden] */
wench_base_width = wench_reel_flange + 10;
wench_base_length = wench_reel_od + wench_motor_size + 35;


$fn = 50;
Trans = 0.8;//1.0;

// Tolerances for geometry connections. ??? DO WE REALLY NEED THIS? Yes, to avoid errors when slic3ring.
AT=0.02;
ST=AT*2;
TT=AT/2;


if (part == "all") { wench(); }
// to export STL files for each part in print position.
if (part == "base") { wench_base(); }
if (part == "face") { wench_face(); }
if (part == "top") { 
    translate([0,0,wench_cap_thickness]) rotate([0,180,0]) wench_top();
    }
if (part == "reel") { 
    translate([0,0,wench_height-wench_base_thickness]) rotate([0,180,0]) wench_reel();
    }
if (part == "drive") { wench_drive(); }

module wench()
{
	wench_base();
	translate([0,-wench_base_width/2,wench_height]) wench_face();
	translate([0,0,2+wench_height+wench_base_thickness])	rotate([0,180,0])	wench_top();
	translate([0,0,wench_height+1])	rotate([0,180,($t*360)*-1]) wench_reel();
	translate([wench_gear_d,0,wench_gear_h+wench_base_thickness+1]) 
		rotate([0,180,($t*360*wench_reel_gear_teeth/wench_drive_gear_teeth)]) wench_drive();
	
}

module wench_drive() {
	color("yellow", Trans) {
			//cylinder(r=wench_drive_gear_od/2, h=wench_gear_h);
		difference()	{
			union() {
				translate([0,0,(wench_gear_h/2) - TT])
					gear(	twist = 360 / wench_drive_gear_teeth
						,number_of_teeth = wench_drive_gear_teeth 
						,circular_pitch = wench_gear_pitch
						,hub_thickness = wench_drive_gear_hub_h + (wench_gear_h/2)+AT
						,hub_diameter = wench_drive_gear_shaft_d+15
						,gear_thickness =(wench_gear_h/2)+AT
						,rim_thickness =(wench_gear_h/2)+AT
						,rim_width = 5
						); 
				translate([0,0,(wench_gear_h/2) + TT]) rotate([180,0,0])
					gear(	twist = -360 / wench_drive_gear_teeth
						,number_of_teeth = wench_drive_gear_teeth
						,circular_pitch = wench_gear_pitch
						,hub_thickness = (wench_gear_h/2)+AT
						,gear_thickness =  (wench_gear_h/2)+AT
						,rim_thickness =(wench_gear_h/2)+AT
						); 
				}
			//shafthole
			translate([0,0,-TT]) 
				cylinder(r=wench_drive_gear_shaft_d/2, h=wench_gear_h+wench_drive_gear_hub_h+ST);
			//setscrew shaft
			translate([-(wench_drive_gear_shaft_d+15)/2, 0, wench_drive_gear_hub_h+wench_drive_gear_setscrew_offset ])
				rotate([0,90,0])
				cylinder(r=wench_drive_gear_setscrew_od/2
					, h=(wench_drive_gear_shaft_d+15)/2
					);
			//setscrew captive nut
			translate([-(wench_drive_gear_shaft_d+11-wench_drive_gear_shaft_d)/2, 0
				, wench_drive_gear_hub_h + wench_drive_gear_setscrew_offset]) 
				cube([wench_drive_gear_nut_h, 
					wench_drive_gear_nut_d, 
					wench_drive_gear_nut_d + wench_drive_gear_setscrew_offset + ST ],
					center=true
					);
			}
		}
	}

module wench_reel() {
	color("blue", Trans-.1) {
		difference() {
			union() {
				// top lip of reel
				cylinder(r = wench_reel_flange/2, h = wench_reel_flange_thickness);
				translate([0,0,wench_reel_flange_thickness-TT])	
					cylinder(r1 = wench_reel_flange/2, r2 = wench_reel_od/2, h = wench_reel_flange_thickness/2+ST);
				// centre of reel s
				translate([0,0,wench_reel_flange_thickness-TT])	
					cylinder(r = wench_reel_od/2, h = wench_reel_height-(wench_reel_flange_thickness*2)+ST); //h=37
				// bottom lip of reel (15 high)
				translate([0,0,wench_reel_height-wench_reel_flange_thickness])	{ 
					//cylinder(r = wench_reel_flange/2, h = wench_reel_flange_thickness);
					//not a cylinder, a GEAR!!!
					translate([0,0,(wench_gear_h/2) - TT])
						gear(	twist = -360 / wench_reel_gear_teeth 
							,number_of_teeth = wench_reel_gear_teeth 
							,circular_pitch = wench_gear_pitch
							,gear_thickness =(wench_gear_h/2)+ST
							,rim_thickness =(wench_gear_h/2)+ST
							); 
	
					translate([0,0,(wench_gear_h/2) - TT]) rotate([180,0,0])
						gear(	twist = 360 / wench_reel_gear_teeth
							,number_of_teeth = wench_reel_gear_teeth
							,circular_pitch = wench_gear_pitch
							,gear_thickness = (wench_gear_h/2)+ST
							,rim_thickness =(wench_gear_h/2)+ST
							);
					}
				}
			// spindle hole
			translate([0,0,-2])	cylinder(r = wench_id/2 + 1, h = wench_height+1); //r = 27, h = 84
			// knot hole
			translate([wench_reel_od/2+wench_line_od, 0, -1]) { //[33+9,0,-1]
				// line entry to reel
				cylinder(r = wench_line_od, h = wench_reel_flange_thickness*2);
				// knot hole
				cylinder(r = wench_line_od*4, h = wench_line_od*4);
				// line entry
				//translate([0,0,wench_reel_flange_thickness/2])	
				//	cylinder(r1 = wench_line_od+1, r2 = wench_line_od*4
				//		,h=wench_reel_flange_thickness*1.5
				//		);
				}
			}
		// lid bearing (temporary)
		//translate([33,0,-3])	sphere(r = 3);
		}
	}


module wench_base()
{
	echo ("Print area:",wench_base_length+wench_base_width/2-wench_base_width/4+wench_base_thickness,wench_base_width,wench_height);
	color("red",Trans)
	{
		difference()
		{
			union()
			{
				// base
				cylinder(r = wench_base_width/2, h = wench_base_thickness);
				// motor mount
				translate([0,-wench_base_width/2,0]) cube(size = [
					wench_base_length - wench_base_width/4,
					wench_base_width,
					wench_base_thickness
					]);
				// spindle
				translate([0,0,wench_base_thickness-TT])
					cylinder(r = wench_id/2, h = wench_height-wench_base_thickness+2);
			}
			// base bearing
			translate([0,0,-15+wench_base_thickness])
				horiz_bearing(((wench_reel_flange - wench_id)/2+wench_id-wench_motor_adjust)/2,15);
			// top spindle bearing
			vert_bearing(wench_id/2,(wench_height-wench_base_thickness)*3/4+wench_base_thickness);
			// bottom spindle bearing
			vert_bearing(wench_id/2,(wench_height-wench_base_thickness)*1/4+wench_base_thickness);
			// Motor mount
			translate([wench_gear_d,0,0]) 
				NEMA_Mount(
					wench_motor_size
					,shaft=wench_drive_gear_od/2+2 
					,height=wench_base_thickness+2 
					,nut_size=wench_motor_nut_size
					,nut_height=wench_motor_nut_height
					,adjust=wench_motor_adjust
					);
		}
		// vertical bearing supports
		 vert_bearing_support(wench_id/2,(wench_height-wench_base_thickness)*3/4+wench_base_thickness);
		 vert_bearing_support(wench_id/2,(wench_height-wench_base_thickness)*1/4+wench_base_thickness);
		// base bearing (temporary)
		//translate([33,0,15-2])	sphere(r = 3);
		// spindle ball bearings
		//translate([25-2,0,58])	sphere(r = 3);
		//translate([25-2,0,38])	sphere(r = 3);
		//thread_out(diameter, height, segments)
		translate([0,0,wench_height + 1.9])	thread_out(wench_id-5,wench_cap_thickness,80);
		// wench mount
		translate([wench_base_length-wench_base_width/4+wench_base_thickness-TT,0,0]) rotate([0,-90,0])
			difference() { 
				translate([0,-wench_base_width/2,0]) 
					cube(size = [
						wench_height+wench_base_thickness,
						wench_base_width,
						wench_base_thickness
						]);
			// mounting holes
				translate([(wench_height+wench_base_thickness)/2,0,0]) {
					csk(   0,   wench_base_width*3/8	);
					csk( wench_height*2/8,      0		);
					csk(   0,   -wench_base_width*3/8	);
					csk( -wench_height*2/8,      0	);
				}
			}

	}
}

module csk(x,y) {
	translate([x,y,-1]) {	
		// hole itself
		cylinder(r = 2.75,h = wench_base_thickness);
		// counter sink
		translate([0,0,wench_base_thickness*0.74])
			cylinder(h = wench_base_thickness*0.14, r1 = 2.5, r2 = 5);
		// slight counter bore
		translate([0,0,wench_base_thickness*0.87])
			cylinder(r = 5, h = wench_base_thickness*0.14+1);
		}
	}

module wench_face() {
	color("grey", Trans-.1) {
		difference() {
			cube(size = [
				wench_base_length - wench_base_width/4,
				wench_base_width,
				wench_base_thickness
				]);
			translate([0,wench_base_width/2,-0.1]) 
				cylinder(r = wench_reel_flange/2+5, h = wench_base_thickness+0.2);
			}
		}
	}

module wench_top()
{
	color("green", Trans)
	{
		difference()
		{
			union()
			{
				// top rounded edge
				translate([0,0,3])	rotate_extrude()	translate([wench_reel_flange/2-3.9, 0, 0])	circle(3);
				// top filler
				translate([0, 0, 0])	cylinder(r = wench_reel_flange/2-3, h = 4.1);
				// main top
				translate([0, 0, 2.9])
					cylinder(r = wench_reel_flange/2,h = wench_base_thickness-2.9,$fn = 20);
			}
			// centre hole
			translate([0,0,-1])	cylinder(r = wench_id/2-2.5, h = wench_cap_thickness+2);
			// bearing
			translate([0,0,-15+wench_cap_thickness])
				horiz_bearing(((wench_reel_flange - wench_id)*2/3+wench_id)/2,15);
		}
		translate([0,0,0.1])	thread_in(wench_id-5,wench_cap_thickness-0.2,80);
		// bearing (temporary)
		//translate([33,0,18])	sphere(r = 3);
	}
}


//use <ISOThread.scad>
// ISO Metric Thread Implementation
// Trevor Moseley
// 15/07/2012

// For thread dimensions see
//   http://en.wikipedia.org/wiki/File:ISO_and_UTS_Thread_Dimensions.svg


defc = 16;

// function for thread pitch
function get_coarse_pitch(dia) = lookup(dia, [
[1,0.25],[1.2,0.25],[1.4,0.3],[1.6,0.35],[1.8,0.35],[2,0.4],[2.5,0.45],[3,0.5],[3.5,0.6],[4,0.7],[5,0.8],[6,1],[7,1],[8,1.25],[10,1.5],[12,1.75],[14,2],[16,2],[18,2.5],[20,2.5],[22,2.5],[24,3],[27,3],[30,3.5],[33,3.5],[36,4],[39,4],[42,4.5],[45,4.5],[48,5],[52,5],[56,5.5],[60,5.5],[64,6],[78,5]]);

// function for hex nut diameter from thread size
function hex_nut_dia(dia) = lookup(dia, [
[3,6.4],[4,8.1],[5,9.2],[6,11.5],[8,16.0],[10,19.6],[12,22.1],[16,27.7],[20,34.6],[24,41.6],[30,53.1],[36,63.5]]);
// function for hex nut height from thread size
function hex_nut_hi(dia) = lookup(dia, [
[3,2.4],[4,3.2],[5,4],[6,3],[8,5],[10,5],[12,10],[16,13],[20,16],[24,19],[30,24],[36,29]]);


// function for hex bolt head diameter from thread size
function hex_bolt_dia(dia) = lookup(dia, [
[3,6.4],[4,8.1],[5,9.2],[6,11.5],[8,14.0],[10,16],[12,22.1],[16,27.7],[20,34.6],[24,41.6],[30,53.1],[36,63.5]]);
// function for hex bolt head height from thread size
function hex_bolt_hi(dia) = lookup(dia, [
[3,2.4],[4,3.2],[5,4],[6,3.5],[8,4.5],[10,5],[12,10],[16,13],[20,16],[24,19],[30,24],[36,29]]);

module thread_out(dia,hi,thr=defc)
{
	p = get_coarse_pitch(dia);
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	t = (hi-p)/p;			// number of turns
	n = t*thr;				// number of segments
	//echo(str("dia=",dia," hi=",hi," p=",p," h=",h," Rmin=",Rmin," s=",s));
	cylinder(r = Rmin, h = hi);
	for(sg=[0:n])
		th_out_pt(Rmin-0.1,p,s,sg,thr,h,(hi-p)/n);
}

module th_out_pt(rt,p,s,sg,thr,h,sh)
// rt = radius of thread (nearest centre)
// p = pitch
// s = segment length (degrees)
// sg = segment number
// thr = segments in circumference
// h = ISO h of thread / 8
// sh = segment height (z)
{
//	as = 360-((sg % thr) * s);	// angle to start of seg
//	ae = as - s  + (s/100);		// angle to end of seg (with overlap)
	as = (sg % thr) * s;			// angle to start of seg
	ae = as + s  - (s/100);		// angle to end of seg (with overlap)
	z = sh*sg;
	//pp = p/2;
	//   1,4
	//   |\
	//   |  \  2,5
 	//   |  / 
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
		triangles = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}

module thread_in(dia,hi,thr=defc)
{
	p = get_coarse_pitch(dia);
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	t = (hi-p)/p;			// number of turns
	n = t*thr;				// number of segments
	echo(str("dia=",dia," hi=",hi," p=",p," h=",h," Rmin=",Rmin," s=",s));
	difference()
	{
		cylinder(r = (dia/2)+0.5,h = hi);
		translate([0,0,-1]) cylinder(r = (dia/2)+0.1, h = hi+2);
	}
	for(sg=[0:n])
		th_in_pt(Rmin+0.2,p,s,sg,thr,h,(hi-p)/n);
}

module th_in_pt(rt,p,s,sg,thr,h,sh)
// rt = radius of thread (nearest centre)
// p = pitch
// s = segment length (degrees)
// sg = segment number
// thr = segments in circumference
// h = ISO h of thread / 8
// sh = segment height (z)
{
//	as = 360 - (((sg % thr) * s) - 180);	// angle to start of seg
//	ae = as - s + (s/100);		// angle to end of seg (with overlap)
	as = ((sg % thr) * s - 180);	// angle to start of seg
	ae = as + s -(s/100);		// angle to end of seg (with overlap)
	z = sh*sg;
	pp = p/2;
	//         2,5
	//          /|
	//  1,4 /  | 
 	//        \  |
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
		triangles = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}

module hex_nut(dia,thr=defc)
{
	hi = hex_nut_hi(dia);
	difference()
	{
		cylinder(r = hex_nut_dia(dia)/2,h = hi, $fn=6);
		translate([0,0,-0.1])	cylinder(r = dia/2, h =hi + 0.2);
	}
	translate([0,0,0.1])	thread_in(dia,hi-0.2,thr);
}

module hex_bolt(dia,hi,thr=defc)
{
	hhi = hex_bolt_hi(dia);
	cylinder(r = hex_bolt_dia(dia)/2,h = hhi, $fn=6);
	translate([0,0,hhi-0.1])	thread_out(dia,hi+0.1,thr);
}

//use <vert_bear.scad> 
// washing line winch 15/07/2012 Trev Moseley
// 2013/10/26 modifide by James Newton - Bearings were a bit tight.
//   made the roof race .1mm higher, upper lip .1mm lower, and
//   reduced the above and below supports by .1mm as well.

$fn = 100;
Trans = 1.0;


module vert_bearing(r,z)
{
	// bottom spindle bearing
	translate([0,0,z-3])
	{
		//  lip (bearings trap)
		difference()
		{
			translate([0,0,+0.3])	cylinder(r = r+0.1, h = 5.7); //h- brings upper lip down
			translate([0,0,+0.2])	cylinder(r = r-0.7, h = 7);
		}
		// bearing run
		translate([0,0,-0.1])
			difference()
			{
				cylinder(r = r-0.6, h = 6.3); //h+ makes roof of race higher
				translate([0,0,-1])	cylinder(r = r-5.05, h = 8.2); //r makes race deeper
			}
	}
}

module vert_bearing_support(r,z)
{
	// above support
	translate([0,0,z+1])
	{
		difference()
		{
			cylinder( h = 2,r1 = r-5.3, r2 = r-3.5);
			translate([0,0,-1])	cylinder(r = r-5.1, h = 8.2); 
		}
	}
	// below support
	translate([0,0,z-3])
	{
		difference()
		{
			cylinder( h = 2,r1 = r-3.5, r2 = r-5.3);
			translate([0,0,-1])	cylinder(r = r-5.1, h = 8.2); 
		}
	}
	// supports (for printing - break outs)
	translate([0,0,z-2.7])	
	{
		difference()
		{
			cylinder(r = r+0.5, h = 5.7);
			translate([0,0,-0.1])		cylinder(r = r-0.3, h = 6);
			translate([-1.5, r-4,-0.1])	cube([3,6,6]);	//top
			translate([-1.5,-r-4,-0.1])	cube([3,6,6]);	//bottom
			translate([ r-4,-1.5,-0.1])	cube([6,3,6]);	//right
			translate([-r-4,-1.5,-0.1])	cube([6,3,6]);	//left
		}
	}
}








//use <horiz_bear.scad>
// washing line winch 15/07/2012 Trev Moseley

$fn = 100;
Trans = 0.7;


module horiz_bearing(rad,top)
{
	//  lip (bearings trap)
	translate([0,0,top-1.1])
		difference()
		{
			cylinder(r = rad+3-0.3, h = 1.2);
			translate([0,0,-0.2])	cylinder(r = rad-3, h = 1.4);
		}
	// bearing run
	translate([0,0,top-5.1])
		difference()
		{
			cylinder(r = rad+3.15, h = 4.1);
			translate([0,0,-0.1])	cylinder(r = rad-3.15, h = 4.3);
		}
}

//use <NEMAMount.scad>
/**
 * NEMAMount.scad
 *
 * Produces the shape to be subtracted from a base to make a NEMA motor mount.
 *
 * @copyright  James Newton, 2013
 * @license    http://creativecommons.org/licenses/LGPL/2.1/
 * @license    http://creativecommons.org/licenses/by-sa/3.0/
 *
 * @see        http://www.thingiverse.com/thing:137829
 *
 *
**/
module NEMA_Mount (NEMA_Size, shaft=-1, pilot=-1, height, nut_size, nut_height, adjust=0) {
	for (r = [-adjust: 2: adjust]) 
		translate([r,0,0])
		Simple_NEMA_Mount (NEMA_Size, shaft, pilot, height, nut_size, nut_height, $fs=adjust/2+0.01);
	//drop the resolution to keep from swamping the system with CSG Products.
	}

module Simple_NEMA_Mount (NEMA_Size, shaft=-1, pilot=-1, height, nut_size, nut_height) {

	NEMA_Mount = lookup(NEMA_Size,[
		[ 8,15.4/2],
		[11,23.0/2],
		[14,26.0/2],
		[17,31.04/2],
		[23,47.14/2],
		[34,69.58/2],
		[42,88.90/2]
		]);

	NEMA_Bolt = lookup(NEMA_Size,[
		[ 8,2.0/2],
		[11,2.5/2],
		[14,3.0/2],
		[17,4.0/2],
		[23,4.75/2],
		[34,6.5/2],
		[42,7.15/2]
		]);

//the -.1's here are to ensure the hole breaks through the mounting plate
	translate([-NEMA_Mount,-NEMA_Mount,-.1]) cylinder(h=height-nut_height+.2, r=NEMA_Bolt);
	if (nut_height > 0) translate([-NEMA_Mount,-NEMA_Mount,height-nut_height]) nut(nut_size, nut_height);
	translate([-NEMA_Mount,+NEMA_Mount,-.1]) cylinder(h=height-nut_height+.2, r=NEMA_Bolt);
	if (nut_height > 0) translate([-NEMA_Mount,+NEMA_Mount,height-nut_height]) nut(nut_size, nut_height);
	translate([+NEMA_Mount,-NEMA_Mount,-.1]) cylinder(h=height-nut_height+.2, r=NEMA_Bolt);
	if (nut_height > 0) translate([+NEMA_Mount,-NEMA_Mount,height-nut_height]) nut(nut_size, nut_height);
	translate([+NEMA_Mount,+NEMA_Mount,-.1]) cylinder(h=height-nut_height+.2, r=NEMA_Bolt);
	if (nut_height > 0) translate([+NEMA_Mount,+NEMA_Mount,height-nut_height]) nut(nut_size, nut_height);
	if (shaft > 0) translate([0,0,-.1]) cylinder(h=height+.1, r=shaft);
	if (shaft < 0) translate([0,0,-.1]) cylinder(h=height+.1, r=-shaft + lookup(NEMA_Size,[
		[ 8,4.00/2],
		[11,5.00/2],
		[14,5.00/2],
		[17,5.00/2],
		[23,6.35/2],
		[34,9.50/2],
		[42,16.0/2]
		])
		);
	if (pilot > 0) cylinder(h=2, r=pilot);
	if (pilot < 0) translate([0,0,-.1]) cylinder(h=2, r=-pilot + lookup(NEMA_Size,[
		[ 8,15.00/2],
		[11,22.00/2],
		[14,22.00/2],
		[17,22.00/2],
		[23,38.10/2],
		[34,73.00/2],
		[42,73.0/2]
		])
		);
	};

module nut(nutSize,nutHeight) {
	//I have no idea if this actually produces the correct size.
	// need to check against:
	//http://www.boltdepot.com/fastener-information/Nuts-Washers/Metric-Nut-Dimensions.aspx
	for (r = [-60, 0, 60]) 
		translate([0,0,nutHeight/2]) rotate([0,0,r]) cube([nutSize*1.75, nutSize, nutHeight], true);
	}



//use <involute_gears.scad> 
// Parametric Involute Bevel and Spur Gears by GregFrost
// It is licensed under the Creative Commons - GNU LGPL 2.1 license.
// © 2010 by GregFrost, thingiverse.com/Amp
// http://www.thingiverse.com/thing:3575 and http://www.thingiverse.com/thing:3752

pi=3.1415926535897932384626433832795;

//==================================================
// Bevel Gears:
// Two gears with the same cone distance, circular pitch (measured at the cone distance)
// and pressure angle will mesh.

module bevel_gear_pair (
	gear1_teeth = 41,
	gear2_teeth = 7,
	axis_angle = 90,
	outside_circular_pitch=1000)
{
	outside_pitch_radius1 = gear1_teeth * outside_circular_pitch / 360;
	outside_pitch_radius2 = gear2_teeth * outside_circular_pitch / 360;
	pitch_apex1=outside_pitch_radius2 * sin (axis_angle) +
		(outside_pitch_radius2 * cos (axis_angle) + outside_pitch_radius1) / tan (axis_angle);
	cone_distance = sqrt (pow (pitch_apex1, 2) + pow (outside_pitch_radius1, 2));
	pitch_apex2 = sqrt (pow (cone_distance, 2) - pow (outside_pitch_radius2, 2));
	echo ("cone_distance", cone_distance);
	pitch_angle1 = asin (outside_pitch_radius1 / cone_distance);
	pitch_angle2 = asin (outside_pitch_radius2 / cone_distance);
	echo ("pitch_angle1, pitch_angle2", pitch_angle1, pitch_angle2);
	echo ("pitch_angle1 + pitch_angle2", pitch_angle1 + pitch_angle2);

	rotate([0,0,90])
	translate ([0,0,pitch_apex1+20])
	{
		translate([0,0,-pitch_apex1])
		bevel_gear (
			number_of_teeth=gear1_teeth,
			cone_distance=cone_distance,
			pressure_angle=30,
			outside_circular_pitch=outside_circular_pitch);

		rotate([0,-(pitch_angle1+pitch_angle2),0])
		translate([0,0,-pitch_apex2])
		bevel_gear (
			number_of_teeth=gear2_teeth,
			cone_distance=cone_distance,
			pressure_angle=30,
			outside_circular_pitch=outside_circular_pitch);
	}
}

//Bevel Gear Finishing Options:
bevel_gear_flat = 0;
bevel_gear_back_cone = 1;

module bevel_gear (
	number_of_teeth=11,
	cone_distance=100,
	face_width=20,
	outside_circular_pitch=1000,
	pressure_angle=30,
	clearance = 0.2,
	bore_diameter=5,
	gear_thickness = 15,
	backlash = 0,
	involute_facets=0,
	finish = -1)
{
	echo ("bevel_gear",
		"teeth", number_of_teeth,
		"cone distance", cone_distance,
		face_width,
		outside_circular_pitch,
		pressure_angle,
		clearance,
		bore_diameter,
		involute_facets,
		finish);

	// Pitch diameter: Diameter of pitch circle at the fat end of the gear.
	outside_pitch_diameter  =  number_of_teeth * outside_circular_pitch / 180;
	outside_pitch_radius = outside_pitch_diameter / 2;

	// The height of the pitch apex.
	pitch_apex = sqrt (pow (cone_distance, 2) - pow (outside_pitch_radius, 2));
	pitch_angle = asin (outside_pitch_radius/cone_distance);

	echo ("Num Teeth:", number_of_teeth, " Pitch Angle:", pitch_angle);

	finish = (finish != -1) ? finish : (pitch_angle < 45) ? bevel_gear_flat : bevel_gear_back_cone;

	apex_to_apex=cone_distance / cos (pitch_angle);
	back_cone_radius = apex_to_apex * sin (pitch_angle);

	// Calculate and display the pitch angle. This is needed to determine the angle to mount two meshing cone gears.

	// Base Circle for forming the involute teeth shape.
	base_radius = back_cone_radius * cos (pressure_angle);

	// Diametrial pitch: Number of teeth per unit length.
	pitch_diametrial = number_of_teeth / outside_pitch_diameter;

	// Addendum: Radial distance from pitch circle to outside circle.
	addendum = 1 / pitch_diametrial;
	// Outer Circle
	outer_radius = back_cone_radius + addendum;

	// Dedendum: Radial distance from pitch circle to root diameter
	dedendum = addendum + clearance;
	dedendum_angle = atan (dedendum / cone_distance);
	root_angle = pitch_angle - dedendum_angle;

	root_cone_full_radius = tan (root_angle)*apex_to_apex;
	back_cone_full_radius=apex_to_apex / tan (pitch_angle);

	back_cone_end_radius =
		outside_pitch_radius -
		dedendum * cos (pitch_angle) -
		gear_thickness / tan (pitch_angle);
	back_cone_descent = dedendum * sin (pitch_angle) + gear_thickness;

	// Root diameter: Diameter of bottom of tooth spaces.
	root_radius = back_cone_radius - dedendum;

	half_tooth_thickness = outside_pitch_radius * sin (360 / (4 * number_of_teeth)) - backlash / 4;
	half_thick_angle = asin (half_tooth_thickness / back_cone_radius);

	face_cone_height = apex_to_apex-face_width / cos (pitch_angle);
	face_cone_full_radius = face_cone_height / tan (pitch_angle);
	face_cone_descent = dedendum * sin (pitch_angle);
	face_cone_end_radius =
		outside_pitch_radius -
		face_width / sin (pitch_angle) -
		face_cone_descent / tan (pitch_angle);

	// For the bevel_gear_flat finish option, calculate the height of a cube to select the portion of the gear that includes the full pitch face.
	bevel_gear_flat_height = pitch_apex - (cone_distance - face_width) * cos (pitch_angle);

//	translate([0,0,-pitch_apex])
	difference ()
	{
		intersection ()
		{
			union()
			{
				rotate (half_thick_angle)
				translate ([0,0,pitch_apex-apex_to_apex])
				cylinder ($fn=number_of_teeth*2, r1=root_cone_full_radius,r2=0,h=apex_to_apex);
				for (i = [1:number_of_teeth])
//				for (i = [1:1])
				{
					rotate ([0,0,i*360/number_of_teeth])
					{
						involute_bevel_gear_tooth (
							back_cone_radius = back_cone_radius,
							root_radius = root_radius,
							base_radius = base_radius,
							outer_radius = outer_radius,
							pitch_apex = pitch_apex,
							cone_distance = cone_distance,
							half_thick_angle = half_thick_angle,
							involute_facets = involute_facets);
					}
				}
			}

			if (finish == bevel_gear_back_cone)
			{
				translate ([0,0,-back_cone_descent])
				cylinder (
					$fn=number_of_teeth*2,
					r1=back_cone_end_radius,
					r2=back_cone_full_radius*2,
					h=apex_to_apex + back_cone_descent);
			}
			else
			{
				translate ([-1.5*outside_pitch_radius,-1.5*outside_pitch_radius,0])
				cube ([3*outside_pitch_radius,
					3*outside_pitch_radius,
					bevel_gear_flat_height]);
			}
		}

		if (finish == bevel_gear_back_cone)
		{
			translate ([0,0,-face_cone_descent])
			cylinder (
				r1=face_cone_end_radius,
				r2=face_cone_full_radius * 2,
				h=face_cone_height + face_cone_descent+pitch_apex);
		}

		translate ([0,0,pitch_apex - apex_to_apex])
		cylinder (r=bore_diameter/2,h=apex_to_apex);
	}
}

module involute_bevel_gear_tooth (
	back_cone_radius,
	root_radius,
	base_radius,
	outer_radius,
	pitch_apex,
	cone_distance,
	half_thick_angle,
	involute_facets)
{
//	echo ("involute_bevel_gear_tooth",
//		back_cone_radius,
//		root_radius,
//		base_radius,
//		outer_radius,
//		pitch_apex,
//		cone_distance,
//		half_thick_angle);

	min_radius = max (base_radius*2,root_radius*2);

	pitch_point =
		involute (
			base_radius*2,
			involute_intersect_angle (base_radius*2, back_cone_radius*2));
	pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
	centre_angle = pitch_angle + half_thick_angle;

	start_angle = involute_intersect_angle (base_radius*2, min_radius);
	stop_angle = involute_intersect_angle (base_radius*2, outer_radius*2);

	res=(involute_facets!=0)?involute_facets:($fn==0)?5:$fn/4;

	translate ([0,0,pitch_apex])
	rotate ([0,-atan(back_cone_radius/cone_distance),0])
	translate ([-back_cone_radius*2,0,-cone_distance*2])
	union ()
	{
		for (i=[1:res])
		{
			assign (
				point1=
					involute (base_radius*2,start_angle+(stop_angle - start_angle)*(i-1)/res),
				point2=
					involute (base_radius*2,start_angle+(stop_angle - start_angle)*(i)/res))
			{
				assign (
					side1_point1 = rotate_point (centre_angle, point1),
					side1_point2 = rotate_point (centre_angle, point2),
					side2_point1 = mirror_point (rotate_point (centre_angle, point1)),
					side2_point2 = mirror_point (rotate_point (centre_angle, point2)))
				{
					polyhedron (
						points=[
							[back_cone_radius*2+0.1,0,cone_distance*2],
							[side1_point1[0],side1_point1[1],0],
							[side1_point2[0],side1_point2[1],0],
							[side2_point2[0],side2_point2[1],0],
							[side2_point1[0],side2_point1[1],0],
							[0.1,0,0]],
						triangles=[[0,2,1],[0,3,2],[0,4,3],[0,1,5],[1,2,5],[2,3,5],[3,4,5],[0,5,4]]);
				}
			}
		}
	}
}

module gear (
	number_of_teeth=15,
	circular_pitch=false, diametral_pitch=false,
	pressure_angle=28,
	clearance = 0.2,
	gear_thickness=5,
	rim_thickness=8,
	rim_width=5,
	hub_thickness=10,
	hub_diameter=15,
	bore_diameter=5,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=0,
	flat=false)
{
	if (circular_pitch==false && diametral_pitch==false)
		echo("MCAD ERROR: gear module needs either a diametral_pitch or circular_pitch");

	//Convert diametrial pitch to our native circular pitch
	circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);

	// Pitch diameter: Diameter of pitch circle.
	pitch_diameter  =  number_of_teeth * circular_pitch / 180;
	pitch_radius = pitch_diameter/2;
	echo ("Teeth:", number_of_teeth, " Pitch radius:", pitch_radius);

	// Base Circle
	base_radius = pitch_radius*cos(pressure_angle);

	// Diametrial pitch: Number of teeth per unit length.
	pitch_diametrial = number_of_teeth / pitch_diameter;

	// Addendum: Radial distance from pitch circle to outside circle.
	addendum = 1/pitch_diametrial;

	//Outer Circle
	outer_radius = pitch_radius+addendum;

	// Dedendum: Radial distance from pitch circle to root diameter
	dedendum = addendum + clearance;

	// Root diameter: Diameter of bottom of tooth spaces.
	root_radius = pitch_radius-dedendum;
	backlash_angle = backlash / pitch_radius * 180 / pi;
	half_thick_angle = (360 / number_of_teeth - backlash_angle) / 4;

	// Variables controlling the rim.
	rim_radius = root_radius - rim_width;

	// Variables controlling the circular holes in the gear.
	circle_orbit_diameter=hub_diameter/2+rim_radius;
	circle_orbit_curcumference=pi*circle_orbit_diameter;

	// Limit the circle size to 90% of the gear face.
	circle_diameter=
		min (
			0.70*circle_orbit_curcumference/circles,
			(rim_radius-hub_diameter/2)*0.9);

	difference()
	{
		union ()
		{
			difference ()
			{
				linear_exturde_flat_option(flat=flat, height=rim_thickness, convexity=10, twist=twist)
				gear_shape (
					number_of_teeth,
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle,
					involute_facets=involute_facets);

				if (gear_thickness < rim_thickness)
					translate ([0,0,gear_thickness])
					cylinder (r=rim_radius,h=rim_thickness-gear_thickness+1);
			}
			if (gear_thickness > rim_thickness)
				linear_exturde_flat_option(flat=flat, height=gear_thickness)
				circle (r=rim_radius);
			if (flat == false && hub_thickness > gear_thickness)
				translate ([0,0,gear_thickness])
				linear_exturde_flat_option(flat=flat, height=hub_thickness-gear_thickness)
				circle (r=hub_diameter/2);
		}
		translate ([0,0,-1])
		linear_exturde_flat_option(flat =flat, height=2+max(rim_thickness,hub_thickness,gear_thickness))
		circle (r=bore_diameter/2);
		if (circles>0)
		{
			for(i=[0:circles-1])
				rotate([0,0,i*360/circles])
				translate([circle_orbit_diameter/2,0,-1])
				linear_exturde_flat_option(flat =flat, height=max(gear_thickness,rim_thickness)+3)
				circle(r=circle_diameter/2);
		}
	}
}

module linear_exturde_flat_option(flat =false, height = 10, center = false, convexity = 2, twist = 0)
{
	if(flat==false)
	{
		linear_extrude(height = height, center = center, convexity = convexity, twist= twist) child(0);
	}
	else
	{
		child(0);
	}

}

module gear_shape (
	number_of_teeth,
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle,
	involute_facets)
{
	union()
	{
		rotate (half_thick_angle) circle ($fn=number_of_teeth*2, r=root_radius);

		for (i = [1:number_of_teeth])
		{
			rotate ([0,0,i*360/number_of_teeth])
			{
				involute_gear_tooth (
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle,
					involute_facets=involute_facets);
			}
		}
	}
}

module involute_gear_tooth (
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle,
	involute_facets)
{
	min_radius = max (base_radius,root_radius);

	pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
	pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
	centre_angle = pitch_angle + half_thick_angle;

	start_angle = involute_intersect_angle (base_radius, min_radius);
	stop_angle = involute_intersect_angle (base_radius, outer_radius);

	res=(involute_facets!=0)?involute_facets:($fn==0)?5:$fn/4;

	union ()
	{
		for (i=[1:res])
		assign (
			point1=involute (base_radius,start_angle+(stop_angle - start_angle)*(i-1)/res),
			point2=involute (base_radius,start_angle+(stop_angle - start_angle)*i/res))
		{
			assign (
				side1_point1=rotate_point (centre_angle, point1),
				side1_point2=rotate_point (centre_angle, point2),
				side2_point1=mirror_point (rotate_point (centre_angle, point1)),
				side2_point2=mirror_point (rotate_point (centre_angle, point2)))
			{
				polygon (
					points=[[0,0],side1_point1,side1_point2,side2_point2,side2_point1],
					paths=[[0,1,2,3,4,0]]);
			}
		}
	}
}

// Mathematical Functions
//===============

// Finds the angle of the involute about the base radius at the given distance (radius) from it's center.
//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

function involute_intersect_angle (base_radius, radius) = sqrt (pow (radius/base_radius, 2) - 1) * 180 / pi;

// Calculate the involute position for a given base radius and involute angle.

function rotated_involute (rotate, base_radius, involute_angle) =
[
	cos (rotate) * involute (base_radius, involute_angle)[0] + sin (rotate) * involute (base_radius, involute_angle)[1],
	cos (rotate) * involute (base_radius, involute_angle)[1] - sin (rotate) * involute (base_radius, involute_angle)[0]
];

function mirror_point (coord) =
[
	coord[0],
	-coord[1]
];

function rotate_point (rotate, coord) =
[
	cos (rotate) * coord[0] + sin (rotate) * coord[1],
	cos (rotate) * coord[1] - sin (rotate) * coord[0]
];

function involute (base_radius, involute_angle) =
[
	base_radius*(cos (involute_angle) + involute_angle*pi/180*sin (involute_angle)),
	base_radius*(sin (involute_angle) - involute_angle*pi/180*cos (involute_angle))
];


// Test Cases
//===============

module test_gears()
{
	translate([17,-15])
	{
		gear (number_of_teeth=17,
			circular_pitch=500,
			circles=8);

		rotate ([0,0,360*4/17])
		translate ([39.088888,0,0])
		{
			gear (number_of_teeth=11,
				circular_pitch=500,
				hub_diameter=0,
				rim_width=65);
			translate ([0,0,8])
			{
				gear (number_of_teeth=6,
					circular_pitch=300,
					hub_diameter=0,
					rim_width=5,
					rim_thickness=6,
					pressure_angle=31);
				rotate ([0,0,360*5/6])
				translate ([22.5,0,1])
				gear (number_of_teeth=21,
					circular_pitch=300,
					bore_diameter=2,
					hub_diameter=4,
					rim_width=1,
					hub_thickness=4,
					rim_thickness=4,
					gear_thickness=3,
					pressure_angle=31);
			}
		}

		translate ([-61.1111111,0,0])
		{
			gear (number_of_teeth=27,
				circular_pitch=500,
				circles=5,
				hub_diameter=2*8.88888889);

			translate ([0,0,10])
			{
				gear (
					number_of_teeth=14,
					circular_pitch=200,
					pressure_angle=5,
					clearance = 0.2,
					gear_thickness = 10,
					rim_thickness = 10,
					rim_width = 15,
					bore_diameter=5,
					circles=0);
				translate ([13.8888888,0,1])
				gear (
					number_of_teeth=11,
					circular_pitch=200,
					pressure_angle=5,
					clearance = 0.2,
					gear_thickness = 10,
					rim_thickness = 10,
					rim_width = 15,
					hub_thickness = 20,
					hub_diameter=2*7.222222,
					bore_diameter=5,
					circles=0);
			}
		}

		rotate ([0,0,360*-5/17])
		translate ([44.444444444,0,0])
		gear (number_of_teeth=15,
			circular_pitch=500,
			hub_diameter=10,
			rim_width=5,
			rim_thickness=5,
			gear_thickness=4,
			hub_thickness=6,
			circles=9);

		rotate ([0,0,360*-1/17])
		translate ([30.5555555,0,-1])
		gear (number_of_teeth=5,
			circular_pitch=500,
			hub_diameter=0,
			rim_width=5,
			rim_thickness=10);
	}
}

module meshing_double_helix ()
{
	test_double_helix_gear ();

	mirror ([0,1,0])
	translate ([58.33333333,0,0])
	test_double_helix_gear (teeth=13,circles=6);
}

module test_double_helix_gear (
	teeth=17,
	circles=8)
{
	//double helical gear
	{
		twist=200;
		height=20;
		pressure_angle=30;

		gear (number_of_teeth=teeth,
			circular_pitch=700,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = height/2*0.5,
			rim_thickness = height/2,
			rim_width = 5,
			hub_thickness = height/2*1.2,
			hub_diameter=15,
			bore_diameter=5,
			circles=circles,
			twist=twist/teeth);
		mirror([0,0,1])
		gear (number_of_teeth=teeth,
			circular_pitch=700,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = height/2,
			rim_thickness = height/2,
			rim_width = 5,
			hub_thickness = height/2,
			hub_diameter=15,
			bore_diameter=5,
			circles=circles,
			twist=twist/teeth);
	}
}

module test_backlash ()
{
	backlash = 2;
	teeth = 15;

	translate ([-29.166666,0,0])
	{
		translate ([58.3333333,0,0])
		rotate ([0,0,-360/teeth/4])
		gear (
			number_of_teeth = teeth,
			circular_pitch=700,
			gear_thickness = 12,
			rim_thickness = 15,
			rim_width = 5,
			hub_thickness = 17,
			hub_diameter=15,
			bore_diameter=5,
			backlash = 2,
			circles=8);

		rotate ([0,0,360/teeth/4])
		gear (
			number_of_teeth = teeth,
			circular_pitch=700,
			gear_thickness = 12,
			rim_thickness = 15,
			rim_width = 5,
			hub_thickness = 17,
			hub_diameter=15,
			bore_diameter=5,
			backlash = 2,
			circles=8);
	}

	color([0,0,128,0.5])
	translate([0,0,-5])
	cylinder ($fn=20,r=backlash / 4,h=25);
}

