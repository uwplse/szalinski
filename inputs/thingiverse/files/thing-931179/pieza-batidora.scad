pi=3.1415926535897932384626433832795;
union(){
    difference(){
        union(){
            cylinder (r=11/2, h=15,$fn=100);
            //translate ([0,0,11.5])
            //cylinder (r=20/2, h=19,$fn=100);
            translate ([0,0,21.5])
            sphere(r=20/2, $fn=100);
            }
            translate ([0,0,-10])
            color("red")
            cylinder(r=5/2, h=35, $fn=100);
            color("green")
            translate ([-4,-0.6,-3])
            cube ([8,1.2,15]);
            color("green")
            translate ([-0.6,-4,-3])
            cube ([1.2,8,15]);
            }
            
            color("yellow")
            difference(){
                translate([0,0,20])
                gear (
                number_of_teeth=35,
                circular_pitch=108,
                pressure_angle=40,
                clearance = 1,
                rim_thickness = 14.5,
                hub_thickness = 0,
                hub_diameter=0,
                bore_diameter=00,
                circles=0);
                translate([0,0,34])
                color("red")
                cylinder(r=8/2, h=3,$fn=100);
            }
        }
module gear (
	number_of_teeth,
	circular_pitch=false, diametral_pitch=false,
	pressure_angle=50,
	clearance = 0,
	gear_thickness,
	rim_thickness,
	rim_width,
	hub_thickness,
	hub_diameter,
	bore_diameter,
	circles=0)
{
	if (circular_pitch==false && diametral_pitch==false) 
		echo("MCAD ERROR: gear module needs either a diametral_pitch or circular_pitch");

	//Convert diametrial pitch to our native circular pitch
	circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);

	// Pitch diameter: Diameter of pitch circle.
	pitch_diameter  =  number_of_teeth * circular_pitch / 180;
	pitch_radius = pitch_diameter/2;

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

	half_thick_angle = 360 / (4 * number_of_teeth);

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
				linear_extrude (height = rim_thickness, convexity = 10, twist = 0)
				gear_shape (
					number_of_teeth,
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle);

				if (gear_thickness < rim_thickness)
					translate ([0,0,gear_thickness])
					cylinder (r=rim_radius,h=rim_thickness-gear_thickness+1);
			}
			if (gear_thickness > rim_thickness)
				cylinder (r=rim_radius,h=gear_thickness);
			if (hub_thickness > gear_thickness)
				cylinder (r=hub_diameter/2,h=hub_thickness);
		}
		cylinder (r=bore_diameter/2,h=1+max(rim_thickness,hub_thickness,gear_thickness));
		if (circles>0)
		{
			for(i=[0:circles-1])	
				rotate([0,0,i*360/circles])
				translate([circle_orbit_diameter/2,0,0])
				cylinder(r=circle_diameter/2,h=gear_thickness+1);
		}
	}
}

module gear_shape (
	number_of_teeth,
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle)
{
	union()
	{
		rotate (half_thick_angle) circle ($fn=number_of_teeth*2, r=root_radius);

		for (i = [1:number_of_teeth])
		{
			rotate ([0,0,i*360/number_of_teeth])
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

module involute_gear_tooth (
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle)
{

	min_radius = max (base_radius,root_radius);

	pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
	pitch_angle = atan2 (pitch_point[1],pitch_point[0]);
	centre_angle = pitch_angle + half_thick_angle;

	start_angle = involute_intersect_angle (base_radius, min_radius);
	stop_angle = involute_intersect_angle (base_radius, outer_radius);

	curve=[
		[0,0],
		involute(base_radius,start_angle+(stop_angle - start_angle)*0/10),
		involute(base_radius,start_angle+(stop_angle - start_angle)*1/10),
		involute(base_radius,start_angle+(stop_angle - start_angle)*2/10),
		involute(base_radius,start_angle+(stop_angle - start_angle)*3/10),
		involute(base_radius,start_angle+(stop_angle - start_angle)*4/10),
		involute(base_radius,start_angle+(stop_angle - start_angle)*5/10),
		involute(base_radius,start_angle+(stop_angle - start_angle)*6/10),
		involute(base_radius,start_angle+(stop_angle - start_angle)*7/10),
		involute(base_radius,start_angle+(stop_angle - start_angle)*8/10),
		involute(base_radius,start_angle+(stop_angle - start_angle)*9/10),
		involute(base_radius,start_angle+(stop_angle - start_angle)*10/10),
		[outer_radius*cos(centre_angle),outer_radius*sin(centre_angle)],
		[0,0]
		];

	rotate ([0,0,-centre_angle])
	union ()
	{
		polygon (points=curve);
		mirror([sin(centre_angle),-cos(centre_angle),0])
		{
			polygon (points=curve);
		}
	}
}

// Mathematical Functions
//===============

// Finds the angle of the involute about the base radius at the given distance (radius) from it's center.
//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

function involute_intersect_angle(base_radius, radius) = sqrt( pow(radius/base_radius,2) - 1) * 180 / pi;

// Calculate the involute position for a given base radius and involute angle.

function involute(base_radius,involute_angle) = [
	base_radius*(cos(involute_angle) + involute_angle*pi/180*sin(involute_angle)),
	base_radius*(sin(involute_angle) - involute_angle*pi/180*cos(involute_angle)),
];


/*


// Test Cases
//===============

module test_gears()
{
	gear_shape (number_of_teeth=7,circular_pitch=600,pressure_angle=30,clearance=0.2);
	translate ([50,0,0])
	gear_shape (number_of_teeth=23,circular_pitch=600,pressure_angle=30,clearance=0.2);
//	translate([0, 50])gear(number_of_teeth=17,circular_pitch=200);
//	translate([-50,0]) gear(number_of_teeth=17,diametral_pitch=1);
}


module test_spur_gear()
{
	//spur gear
	linear_extrude(height = 10, center = true, convexity = 10, twist = 0)
	gear(number_of_teeth=15,diametral_pitch=0.5,pressure_angle=30);
}

module test_double_helix_gear ()
{
	//double helical gear
	{
		twist=12;
		height=20;
		teeth=17;
		pressure=30;

		linear_extrude(height=height/2, center=true, convexity=10, twist=twist)
		gear(number_of_teeth=teeth,diametral_pitch=0.4,pressure_angle=pressure);
		translate ([0,0,height/2]) mirror([0,0,1])
		linear_extrude(height=height/2, center=true, convexity=10, twist=twist)
		gear (number_of_teeth=teeth, diametral_pitch=0.4,pressure_angle=pressure);
	}
}*/