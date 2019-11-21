/* [Barrel Decorations] */

// number of rings on barrel
ring_count = 0; // [0:8]

// size of each ring (1=default)
ring_scale=[1,1.2,1,1,1,1,1];

// number of radiator discs
radiator_count = 5; // [0:8]

// radius of each radiator disc
radiator_scale=[1.8,2.1,2.2,2.1,1.8,1.2,1,1,1,1,1];


/* [Main Body and Barrel] */

// Length of the sight
sight_length = 3;

// barrel_caliber
barrel_caliber=1.5; // 

// thickness of the sides of the barrel
barrel_thickness=0.3;

// Lenght of barrel
barrel_length = 17;

// Width of the grip
grip_width=2.5; // 

// length of the grip
grip_length=10; // [4:20]

/* [Fins and Wibbly Bits] */

// Number of fins
fin_count = 0;

// Width of fins
fin_width = 0.2;

// size of fins (best between 0.7 and 1.3)
fin_size = 1.0;

// angle to start the fins
fin_offset_angle = 45; // [0:360]

// number of capacitor ring elements 
capacitor_count = 6; // [0:8]

// angle to display the capacitor  (negative to put these at the back of the gun)
capacitor_angle = 55; // [-80:80]



// Bell on end of barrel? (0=no)
barrel_bell_present = 1; // [0:1]


/* [Hidden] */

radiator_offset=6;


$fn =60;

/************************************************************************************************
****   Library functions for torii, beziers
**************************************************************************************************/

// define a torus
module torus(girth, radius)
{
	rotate_extrude(convexity = 10)
	translate([girth, 0, 0])
	circle(r = radius);
}

// Linear Bezier (linear interpolation)
function lb(t, p0, p1) = p0 + (t * (p1 - p0));
// Quadratic Bezier (1 control point)
function qb(t, p0, p1, p2) = lb(t,
		lb(t, p0, p1),
		lb(t, p1, p2));
// Cubic Bezier (2 control points)
function cb(t, p0, p1, p2, p3) = lb(t,
		qb(t, p0, p1, p2),
		qb(t, p1, p2, p3));
// Fourth-order Bezier (3 control points)
function b4(t, p0, p1, p2, p3, p4) = lb(t,
		cb(t, p0, p1, p2, p3),
		cb(t, p1, p2, p3, p4));
// Vertex at position t on Bezier curve
// Use curve appropriate to number of available control points
function b(t, points) =
		(len(points) == 2 ? lb(t, points[0], points[1]) :
		(len(points) == 3 ? qb(t, points[0], points[1], points[2]) :
		(len(points) == 4 ? cb(t, points[0], points[1], points[2], points[3]) :
		(len(points) == 5 ? b4(t, points[0], points[1], points[2], points[3], points[4]) : [0, 0]))));

// control_points: an array of 5 pairs of 2d coordinates. first and last 
//    points are endpoints, rest are control.
// slices: how many slices to take.
module bezier_solid(control_points, slices)
{
	rotate_extrude($fn=70)
	translate([0.5, 0, 0])
	union() {	
		// Each slice of the profile is a strip that runs from the lathe axis (x = -0.5) to
		// a segment of the Bezier curve. p and q are bottom and top points of the segment.
		for (i = [1 : slices]) {
			assign(p = b((i-1)/slices,control_points), q = b(i/slices,control_points)) {			
				polygon(points=[
						[-0.5, p[1]], // bottom left (on axis; x = -0.5)
						[-0.5, q[1]], // top left (on axis; x = -0.5)
						[q[0], q[1]], // top right (on curve; x = q[0])
						[p[0], p[1]]  // bottom right (on curve; x = p[1])
				]);	
}	}	}	}

/************************************************************************************************
****   Library functions for gun parts
**************************************************************************************************/

// draw the bell on the end of the barrel
module barrel_bell(inner_caliber, mouth_caliber)
{
	translate([barrel_length-0.2,0,0])
	rotate([0,90,0])
	difference()
	{
		bezier_solid([[inner_caliber,0],[1,1],[1,2],[5,3],[mouth_caliber,4]],40);
		translate([0,0,-0.05])
		scale([0.9,0.9,1.1])
		bezier_solid([[inner_caliber-0.4,0],[1,1],[1,2],[5,3],[mouth_caliber,4]],40);
	}
}

module ring(barrel_offset, ringwidth)
{

	translate([barrel_offset,0,0])
		rotate([0,90,0])
		torus(3,ringwidth);

	translate([barrel_offset-2.1,0,0.9])
		rotate([0,40,0])
		cylinder(h=3,r=0.2);

	translate([barrel_offset-2.1,-.65,-0.65])
		rotate([120,0,0])
		rotate([0,40,0])
		cylinder(h=3,r=0.2);

	translate([barrel_offset-2.1,0.65,-0.65])	
		rotate([240,0,0])
		rotate([0,40,0])
		cylinder(h=3,r=0.2);
}

module fin(rot_angle)
{
rotate([rot_angle,0,0])
translate([-7,-2.5,0])
scale([1.5*fin_size,0.3*fin_size,1*fin_size])
difference()
{
	cylinder(h=fin_width,r=6);
	translate([0,0,-0.5])
		cube([6,6,2]);
	
	rotate([0,0,60])
		translate([-6,0,-0.5])
		cube([14,9,2]);

}

}



		// barrel rings
		if(ring_count > 0)
		{
			for(k = [1: ring_count])
			{
				scale([1,ring_scale[k-1],ring_scale[k-1]])
					ring(barrel_length+1-2.5*k,0.4);
			}
		}		

		
		if(radiator_count > 0)
		{
			for(m = [1: radiator_count])
			{
				translate([radiator_offset+1*m,0,0])
					rotate([0,90,0])
					difference()
					{
						cylinder(h=0.4, r=1.5*radiator_scale[m-1]);

						translate([0,0,-0.1])
							cylinder(h=0.6, r=barrel_caliber/2-0.04);
	
					}
			}
		}		

		// capacitors
		if(capacitor_count > 0)
		{
			for(ca = [1: capacitor_count])
			{
				translate([-3,0,0])
				rotate([360/capacitor_count*ca,0,0])
				rotate([0,capacitor_angle,0])
				union()
				{
					cylinder(h=5.5+4*abs(cos(90-capacitor_angle)), r=0.2);
					translate([0,0,5.5+4*abs(cos(90-capacitor_angle))])
						sphere(r=0.55, center=true);
				}
			}
		}	


// barrel
rotate([0,90,0])
difference()
{
	union()
	{

		cylinder(h=barrel_length, r=barrel_caliber/2+barrel_thickness);
	}
	translate([0,0,-0.5])
		cylinder(h=barrel_length+1, r=barrel_caliber/2);
}

if(barrel_bell_present==1)
{
	barrel_bell(0.5,4);
}

// body
translate([-3,0,0])
scale([3,1,1.4])
sphere(r=3);

torus(4,0.4);


// grip

translate([-12,-grip_width/2,0-grip_length])
rotate([0,30,0])
scale([1,grip_width,1])
union()
{
	translate([0,0.5,0])
		scale([1,1.25,1])
		cylinder(h=grip_length, r=0.5);
	translate([3,0.5,0])
		scale([1,1.25,1])
		cylinder(h=grip_length, r=0.5);
   cube([3,1,grip_length]);

	// grippy bits
	translate([1.5,0.5,3])
		scale([1.6,0.6,0.5])
		sphere(r=1);
	translate([1.5,0.5,5])
		scale([1.6,0.6,0.5])
		sphere(r=1);
	translate([1.5,0.5,7])
		scale([1.6,0.6,0.5])
		sphere(r=1);
	translate([1.5,0.5,1])
		scale([1.6,0.6,0.5])
		sphere(r=1);
}

// trigger guard
translate([-4,0.5,-5])
rotate([90,0,0])
difference()
{
	cylinder(h=1,r=2);
	translate([0,0,-0.1])
		cylinder(h=1.2,r=1.6);
}
// trigger
translate([-3,0.5,-4.6])
rotate([90,0,0])
difference()
{
	cylinder(h=0.7,r=2);
	translate([0,0,-0.1])
		cylinder(h=1.2,r=1.6);
	translate([-1,-2.5,-0.1])
		cube([3,5,1]);

}





// sight
translate([-8,0,0])
scale([sight_length*5,1,1])
{
translate([0,0,5])
	rotate([0,90,0])
	torus(1,0.1);
translate([0,1,5])
	rotate([90,0,0])
	cylinder(h=2,r=0.1);
translate([0,0,4])
	cylinder(h=2,r=0.1);
}
translate([-8,0,2])
	cylinder(h=2,r=0.4);


// fins
if(fin_count > 0)
{
	for(j = [1: fin_count])
	{
		fin(fin_offset_angle+360/fin_count*j);
	}
}
// preview[view:south east, tilt:top diagonal]