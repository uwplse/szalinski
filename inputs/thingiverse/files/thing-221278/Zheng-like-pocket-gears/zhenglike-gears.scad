// A gear set like Zheng3's, for 6 mm diameter rare earth magnets
// 
// By Bill Owens, January 2014
//
// A somewhat less graceful version of:
// http://www.thingiverse.com/thing:185155
// (or http://zheng3.com/pocket-gears/)
//
// Based on the example gears from:
// 	Parametric Involute Bevel and Spur Gears by GregFrost
// 	It is licensed under the Creative Commons - GNU GPL license.
// 	© 2010 by GregFrost
// 	http://www.thingiverse.com/thing:3575
//
//
// Instructions: after printing, a 6 mm diameter by 1 mm thick rare earth magnet will need to be inserted in each piece.
//   The holes will be tight; you will likely need to heat the part with a hairdryer or the heated bed on your printer to
//   allow the magnet to fit. After fitting, be sure to glue the magnets in place to keep them from falling out and becoming 
//   a hazard to children or pets, and match the poles so the gears will stick to the backing plate.

// for Thingiverse Customizer

// Diameter of your magnet (mm)
magnet = 6;

// Individual pieces
//large_gear();
//small_gear();
//backing_plate();

// Build plate with all three pieces
large_gear();
translate([40,0,0]) small_gear();
translate([20,30,0]) rotate([0,0,90])  backing_plate();


// Zheng-style gear - large
module large_gear() {
	gear (
	//circular_pitch=600,
	gear_thickness = 2,
	rim_thickness = 4,
	hub_thickness = 5,
	number_of_teeth=30,
	diametral_pitch=1,
	pressure_angle=28,
	clearance = 0.2,
	rim_width = 3,
	hub_diameter = 10,
	bore_diameter = magnet,
	minor_bore_diameter = 5,
	minor_bore_thickness = 4,
	circles = 8,
	backlash = 0,
	twist = 0,
	involute_facets = 0);
}

// Zheng-style gear - small
module small_gear() {
	gear (
	//circular_pitch=600,
	gear_thickness = 2,
	rim_thickness = 4,
	hub_thickness = 5,
	number_of_teeth=15,
	diametral_pitch=1,
	pressure_angle=28,
	clearance = 0.2,
	rim_width = 3,
	hub_diameter = 10,
	bore_diameter = magnet,
	minor_bore_diameter = 5,
	minor_bore_thickness = 4,
	circles = 0,
	backlash = 0,
	twist = 0,
	involute_facets = 0);
}

// backing plate
module backing_plate() {
	difference() {
		union() {
			translate([0,0,1.2]) cube([10,23,2.4], center=true);
			translate([0,11.5,0]) cylinder(r=6, h=2.4);
			translate([0,-11.5,0]) cylinder(r=6, h=2.4);
		}
		translate([0,-11.5,1.2]) cylinder(r=magnet/2, h=1.5, $fn=20);
		translate([0,11.5,1.2]) cylinder(r=magnet/2, h=1.5, $fn=20);
	}
}

pi=3.1415926535897932384626433832795;


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
						triangles=[[0,1,2],[0,2,3],[0,3,4],[0,5,1],[1,5,2],[2,5,3],[3,5,4],[0,4,5]]);
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
	minor_bore_diameter=0,
	minor_bore_thickness=0,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=0)
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
	difference ()
	{
		union ()
		{
			difference ()
			{
				linear_extrude (height=rim_thickness, convexity=10, twist=twist)
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
				cylinder (r=rim_radius,h=gear_thickness);
			if (hub_thickness > gear_thickness)
				translate ([0,0,gear_thickness])
				cylinder (r=hub_diameter/2,h=hub_thickness-gear_thickness);
		}
		// main bore	
		cylinder (
			r=bore_diameter/2,
			h=hub_thickness-minor_bore_thickness,
			$fn=20);
		// minor bore
		translate([0,0,hub_thickness-minor_bore_thickness])
		cylinder (
			r=minor_bore_diameter/2,
			h=minor_bore_thickness*20,
			$fn=20);
		if (circles>0)
		{
			for(i=[0:circles-1])	
				rotate([0,0,i*360/circles])
				translate([circle_orbit_diameter/2,0,-1])
				cylinder(r=circle_diameter/2,h=max(gear_thickness,rim_thickness)+3, $fn=5);
		}
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
	base_radius*(sin (involute_angle) - involute_angle*pi/180*cos (involute_angle)),
];


