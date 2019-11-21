height = 5;
type = "Spur"; // [Spur,Cog,Double Helix(beta), Single Helix]
teeth = 17;	//	[5:56]
scale = 100;//[3:100]
hole = "Yes"; //[Yes,No]
//don't make too big or your gear will disappear
holeSize = 1.5;
if (type == "Spur")
{
if(hole == "Yes")
{
hole();
}
else
{
spur();
}
}
else if(type == "Cog")
{
if(hole == "Yes")
{
hole();
}
else
{
cog();
}
}
else if(type == "Double Helix(beta)")
{
if(hole == "Yes")
{
hole();
}
else
{
double_helix();
}
}
else if (type == "Single Helix")
{
if(hole == "Yes")
{
hole();
}
else
{
single_helix();
}
}


module gear(number_of_teeth,
		circular_pitch=false, diametral_pitch=false,
		pressure_angle=20, clearance = 0)
{

	//Convert diametrial pitch to our native circular pitch
	circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);

	// Pitch diameter: Diameter of pitch circle.
	pitch_diameter  =  number_of_teeth * circular_pitch / 180;
	pitch_radius = pitch_diameter/2;

	// Base Circle
	base_diameter = pitch_diameter*cos(pressure_angle);
	base_radius = base_diameter/2;

	// Diametrial pitch: Number of teeth per unit length.
	pitch_diametrial = number_of_teeth / pitch_diameter;

	// Addendum: Radial distance from pitch circle to outside circle.
	addendum = 1/pitch_diametrial;

	//Outer Circle
	outer_radius = pitch_radius+addendum;
	outer_diameter = outer_radius*2;

	// Dedendum: Radial distance from pitch circle to root diameter
	dedendum = addendum + clearance;

	// Root diameter: Diameter of bottom of tooth spaces.
	root_radius = pitch_radius-dedendum;
	root_diameter = root_radius * 2;

	half_thick_angle = 360 / (4 * number_of_teeth);

	union()
	{
		rotate(half_thick_angle) circle($fn=number_of_teeth*2, r=root_radius*1.001);

		for (i= [1:number_of_teeth])
		//for (i = [0])
		{
			rotate([0,0,i*360/number_of_teeth])
			{
				involute_gear_tooth(
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle);
			}
		}
	}
}


module involute_gear_tooth(
					pitch_radius,
					root_radius,
					base_radius,
					outer_radius,
					half_thick_angle
					)
{
	pitch_to_base_angle  = involute_intersect_angle( base_radius, pitch_radius );

	outer_to_base_angle = involute_intersect_angle( base_radius/2, outer_radius*1);

	base1 = 0 - pitch_to_base_angle - half_thick_angle;
	pitch1 = 0 - half_thick_angle;
	outer1 = outer_to_base_angle - pitch_to_base_angle - half_thick_angle;

	b1 = polar_to_cartesian([ base1, base_radius ]);
	p1 = polar_to_cartesian([ pitch1, pitch_radius ]);
	o1 = polar_to_cartesian([ outer1, outer_radius ]);

	b2 = polar_to_cartesian([ -base1, base_radius ]);
	p2 = polar_to_cartesian([ -pitch1, pitch_radius ]);
	o2 = polar_to_cartesian([ -outer1, outer_radius ]);

	// ( root_radius > base_radius variables )
		pitch_to_root_angle = pitch_to_base_angle - involute_intersect_angle(base_radius, root_radius );
		root1 = pitch1 - pitch_to_root_angle;
		root2 = -pitch1 + pitch_to_root_angle;
		r1_t =  polar_to_cartesian([ root1, root_radius ]);
		r2_t =  polar_to_cartesian([ -root1, root_radius ]);

	// ( else )
		r1_f =  polar_to_cartesian([ base1, root_radius ]);
		r2_f =  polar_to_cartesian([ -base1, root_radius ]);

	if (root_radius > base_radius)
	{
		//echo("true");
		polygon( points = [
			r1_t,p1,o1,o2,p2,r2_t
		], convexity = 3);
	}
	else
	{
		polygon( points = [
			r1_f, b1,p1,o1,o2,p2,b2,r2_f
		], convexity = 3);
	}

}

// Mathematical Functions
//===============

// Finds the angle of the involute about the base radius at the given distance (radius) from it's center.
//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

function involute_intersect_angle(base_radius, radius) = sqrt( pow(radius/base_radius,2) - 1);



// Polar coord [angle, radius] to cartesian coord [x,y]

function polar_to_cartesian(polar) = [
	polar[1]*cos(polar[0]),
	polar[1]*sin(polar[0])
];


// Test Cases
//===============

module test_gears()
{
	gear(number_of_teeth=51,circular_pitch=200);
	translate([0, 50])gear(number_of_teeth=17,circular_pitch=200);
	translate([-50,0]) gear(number_of_teeth=17,diametral_pitch=1);
}
module cog()
{
		gear(number_of_teeth=teeth,diametral_pitch=scale/100);

}
module single_helix()
{
	translate([50,0]);
	{
	linear_extrude(height = height, center = true, convexity = 10, twist = -45)
	 gear(number_of_teeth=teeth,diametral_pitch=scale/100);
	}
}
module double_helix()
{



linear_extrude(height = height, center = true, convexity = 10, twist = -45)
	 gear(number_of_teeth=teeth,diametral_pitch=scale/100);
	translate([0,0,height]) linear_extrude(height = height, center = true, convexity = 10, twist = 45)
	 gear(number_of_teeth=teeth,diametral_pitch=scale/100);

}
module spur()
{

		translate([0,0]) linear_extrude(height = height, center = true, convexity = 10, twist = 0)
	 gear(number_of_teeth=teeth,diametral_pitch=1);


}

module demo_3d_gears()
{
	//double helical gear
	// (helics don't line up perfectly - for display purposes only ;)
	translate([50,0])
	{
	linear_extrude(height = 10, center = true, convexity = 10, twist = -45)
	 gear(number_of_teeth=17,diametral_pitch=1);
	translate([0,0,10]) linear_extrude(height = height, center = true, convexity = 10, twist = 45)
	 gear(number_of_teeth=17,diametral_pitch=1);
	}

	//spur gear
	translate([0,-50]) linear_extrude(height = height, center = true, convexity = 10, twist = 0)
	 gear(number_of_teeth=17,diametral_pitch=1);

}
module hole() {
   difference() {
if(type == "Spur")
{
translate([0,0]) linear_extrude(height = height, center = true, convexity = 10, twist = 0)
	 gear(number_of_teeth=teeth,diametral_pitch=1);
}
else if(type == "Cog")
{
gear(number_of_teeth=teeth,diametral_pitch=scale/100);
}
else if (type == "Double Helix(beta)")
{
linear_extrude(height = height, center = true, convexity = 10, twist = -45)
	 gear(number_of_teeth=teeth,diametral_pitch=scale/100);
	translate([0,0,height]) linear_extrude(height = height, center = true, convexity = 10, twist = 45)
	 gear(number_of_teeth=teeth,diametral_pitch=scale/100);
}
else if (type == "Single Helix")
{
linear_extrude(height = height, center = true, convexity = 10, twist = -45)
	 gear(number_of_teeth=teeth,diametral_pitch=scale/100);
}
# rotate ([0,0,0]) cylinder (h = height*4, r=holeSize, center = true, $fn=100);
}
}




module test_involute_curve()
{
	for (i=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])
	{
		translate(polar_to_cartesian([involute_intersect_angle( 0.1,i) , i ])) circle($fn=15, r=0.5);
	}
}