// Parametric Cinema/Film Lens Gears by Jaymis - http://jaymis.com
// Create precisely-sized, seamless follow focus gears for film and still lenses.
// Including a perky little bevel on gear teeth to remove sharp edges.
//
// Based on "Parametric Involute Bevel and Spur Gears by GregFrost"
// http://www.thingiverse.com/thing:3575
//
// Thanks to sveltema for help making this work with Customiser
// http://www.thingiverse.com/thing:1060283#comment-726112
// http://www.thingiverse.com/sveltema

// Change this number to vary the overall gear diameter
NUMBER_OF_TEETH = 95; // [10:1:260]
// Hole diameter. Change by 0.5mm increments and test
BORE_DIAMETER = 70.0;  // [3:.1:200]
// Thickness of the gear
GEAR_THICKNESS = 10;   // [1:1:60]


// Simple Camera Lens Gear:

module gear (
	NUMBER_OF_TEETH=15,
	circular_pitch=false, diametral_pitch=false, module_number = false,	//diametrial pitch is US, Pc is used by tool
	pressure_angle=20,
	clearance = 0.2,
	GEAR_THICKNESS=5,
	rim_thickness=8,
	rim_width=5,
	hub_thickness=10,
	hub_diameter=15,
	BORE_DIAMETER=5,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=0,
	no_bore = false
	)
{
	if (circular_pitch==false && diametral_pitch==false && module_number==false) 
		echo("MCAD ERROR: gear module needs either a diametral_pitch or circular_pitch");

	//convert module to diametrial pitch because I don't know how to logic
	diametral_pitch = (diametral_pitch!=false?diametral_pitch:1/module_number);

	//Convert diametrial pitch to our native circular pitch
	circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);

	// Pitch diameter: Diameter of pitch circle.
	pitch_diameter  =  NUMBER_OF_TEETH * circular_pitch / 180;
	pitch_radius = pitch_diameter/2;
	echo ("Teeth:", NUMBER_OF_TEETH, " Pitch radius:", pitch_radius);

	// Base Circle
	base_radius = pitch_radius*cos(pressure_angle);

	// Diametrial pitch: Number of teeth per unit length.
	pitch_diametrial = NUMBER_OF_TEETH / pitch_diameter;

	// Addendum: Radial distance from pitch circle to outside circle.
	addendum = 1/pitch_diametrial;

	//Outer Circle
	outer_radius = pitch_radius+addendum;

	// Dedendum: Radial distance from pitch circle to root diameter
	dedendum = addendum + clearance;

	// Root diameter: Diameter of bottom of tooth spaces.
	root_radius = pitch_radius-dedendum;
	backlash_angle = backlash / pitch_radius * 180 / pi;
	half_thick_angle = (360 / NUMBER_OF_TEETH - backlash_angle) / 4;

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

difference () // Difference off hollow cone shapes to remove sharp edges of gears
    {

	difference () // Original gear code
	{
		union () 
		{
			difference () 
			{
				linear_extrude (height=rim_thickness, convexity=10, twist=twist)
				gear_shape (
					NUMBER_OF_TEETH,
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle,
					involute_facets=involute_facets);

				if (GEAR_THICKNESS < rim_thickness)
					translate ([0,0,GEAR_THICKNESS])
					cylinder (r=rim_radius,h=rim_thickness-GEAR_THICKNESS+1);
             
			}
			if (GEAR_THICKNESS > rim_thickness)
				cylinder (r=rim_radius,h=GEAR_THICKNESS);
			if (hub_thickness > GEAR_THICKNESS)
				translate ([0,0,GEAR_THICKNESS])
				cylinder (r=hub_diameter/2,h=hub_thickness-GEAR_THICKNESS);
		}
		if (!no_bore) {
			translate ([0,0,-1])
			cylinder (
				r=BORE_DIAMETER/2,
				h=2+max(rim_thickness,hub_thickness,GEAR_THICKNESS));
		}
		if (circles>0)
		{
			for(i=[0:circles-1])	
				rotate([0,0,i*360/circles])
				translate([circle_orbit_diameter/2,0,-1])
				cylinder(r=circle_diameter/2,h=max(GEAR_THICKNESS,rim_thickness)+3);
		}



	}
  

union () // Union two separate copies of the same tooth bevelling shape because I don't know how to mirror/copy in OpenSCAD 
    {

    difference() // Create a hollow cone shape for bevelling gear teeth
    {
    translate([0,0,rim_thickness-addendum*2]) 
    cylinder(h = outer_radius, r1 = outer_radius+GEAR_THICKNESS, r2 = outer_radius, center = rim_width); // make a cylinder for bevelling gears
    translate([0,0,rim_thickness-addendum*2-clearance]) 
    cylinder(h = outer_radius, r1 = outer_radius+addendum, r2 = 0, center = outer_radius); // make a cone for bevelling gears
    }

mirror( [0,0,1] )
{
    difference() // Create an inverted hollow cone shape for bevelling gear teeth
    {
    translate([0,0,-addendum*2]) 
    cylinder(h = outer_radius, r1 = outer_radius+GEAR_THICKNESS, r2 = outer_radius, center = rim_width); // make a cylinder for bevelling gears
    translate([0,0,-addendum*2-clearance]) 
    cylinder(h = outer_radius, r1 = outer_radius+addendum, r2 = 0, center = outer_radius); // make a cone for bevelling gears
    }
}


} // end union join top and bottom bevel shapes



}

}

module gear_shape (
	NUMBER_OF_TEETH,
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle,
	involute_facets)
{
	union()
	{
		rotate (half_thick_angle) circle ($fn=NUMBER_OF_TEETH*2, r=root_radius);

		for (i = [1:NUMBER_OF_TEETH])
		{
			rotate ([0,0,i*360/NUMBER_OF_TEETH])
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

/* [Hidden] */
$fs = 0.5; // Changed minimum size of circle fragment. Default 2.
$fa = 2; // Changed minimum angle for circle fragment, gives smoother circle. Default 12.

pi=3.1415926535897932384626433832795;

gear (module_number=0.8, // Camera lens gears are Mod 0.8. Don't change this number unless you have a non-standard follow focus system.

	NUMBER_OF_TEETH = NUMBER_OF_TEETH, 
    BORE_DIAMETER = BORE_DIAMETER, // Hole diameter. Change by 0.5mm increments and test

	rim_thickness = GEAR_THICKNESS, // Thickness of the part with the gear teeth
    GEAR_THICKNESS = GEAR_THICKNESS // Thickness of the part which grips the lens barrel
    );

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



