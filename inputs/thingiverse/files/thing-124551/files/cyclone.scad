// Design by Marius Gheorghescu, July 2013.

// Diameter of the vacuum hose in mm, for reference: Rigid Shop Vac: 45mm, Bosch Household Vacuum: 35mm
vacuum_diameter = 45;

// height of the main body in mm
body_height = 55;		

// height of the cyclone chamber in mm
cone_height = 110;		

// diameter of the hopper connector (bottle neck) in mm
hopper_diameter = 28;

// length of the hopper connector in mm
hopper_height = 12;

// thickness of the walls in mm
wall_thickness = 2;


/* [Hidden] */

// compensate for intersection errors
epsilon = 0.2;			

// diameter of the main body 
body_diameter = vacuum_diameter*3;		

vacuum_radius = vacuum_diameter/2;
body_radius = body_diameter/2;
hopper_radius = hopper_diameter/2;

module main_cone()
{
	difference() {
		cylinder(r1=hopper_radius+wall_thickness, r2=body_radius+wall_thickness, h=cone_height, $fn=100, center=true);
		cylinder(r1=hopper_radius, r2=body_radius, h=cone_height + epsilon, $fn=100, center=true);

	}
}

module intake(mask) 
{
	intake_length = body_radius + vacuum_radius;

	translate([body_radius/2 + vacuum_radius/2, body_radius - vacuum_radius, -vacuum_radius + body_height/2])
	rotate([0,90,0]) 
		difference() {
			cylinder(r=vacuum_radius, h=intake_length , $fn=100, center=true);

			if (mask)
				// double wall size here to prevent bend and cracks
				cylinder(r=vacuum_radius - 2*wall_thickness, h=intake_length + epsilon, $fn=100, center=true);
		}	
}


module cyclone_body() 
{

	// length of exhaust tube is experimental here
	inner_tube_height =  body_height + cone_height/2.5;

	// $TODO - add checks for minimum diameter here (overlap between intake/exhaust/body) 

	difference() {
	union() {

		// main body
		difference() {
			cylinder(r=body_radius+wall_thickness, h=body_height, $fn=100, center=true);

			translate([0,0, -wall_thickness]) 
				cylinder(r=body_radius, h=(body_height + epsilon - wall_thickness), $fn=100, center=true);
		}


		// inner tube
		translate([0,0, -inner_tube_height/2 + body_height/2 ]) 
			cylinder(r=vacuum_radius + wall_thickness, h=inner_tube_height, $fn=33, center=true);
	}

		// vacuum hose
		cylinder(r=vacuum_radius, h=2*inner_tube_height + epsilon, $fn=33, center=true);

	}
}

module upper_cyclone() 
{
	difference() {
		cyclone_body();
		intake(0);
	}

	intake(1);
}

module hopper_connector() 
{
	difference() {
		cylinder(r=hopper_radius+wall_thickness, h=hopper_height, $fn=33, center=true);
		cylinder(r=hopper_radius, h=hopper_height + epsilon, $fn=33, center=true);
	}
}


module cyclone()
{
	rotate([180,0,0])  {
		main_cone();
		translate([0, 0, cone_height/2 + body_height/2]) upper_cyclone();
		translate([0, 0, -cone_height/2 - hopper_height/2 + epsilon]) hopper_connector();
	}
}

cyclone();
//upper_cyclone();