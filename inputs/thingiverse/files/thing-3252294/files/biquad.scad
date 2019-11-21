/*

   /\     /\                   |
 A/  \A  /  \                  B
 /__B_\ /    \                 |
 \    /|\    /          -------0------
 A\  /A| \  /                  |    /
   \/  |  \/                   B   C
       |                       |  /
       |                       | /
                             
*/


/* If len set to -1, compute itself the cable lenght. Frequency in MHz */
frequency = 2430;

/* openscad cylinder facets */
fn = 100;

/* A: 1/4 wavelength 2.4 */
diamond_sz = (299792458 / (frequency*1000));
square_side_sz = diamond_sz/4;

/* Cable diameter */
wire_diameter		= 0.8;

/* E.g RG402 */
root_cable_diam   	= 4.2;

/* Legs width */
legs_width = 5;
legs_thickness = 2.5;

/* B */
square_flat_sz  = 2 * (cos(45)*31.5);

/* C */
whole_side_sz	= square_flat_sz / cos(45);

echo( " Diamond (one of the 4) total length: ", diamond_sz );
echo( " Diamond side (1/4 length): ", square_side_sz );


/* With spacer */
wire = wire_diameter + 0.2;


module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
		hull()
		{
			// place 4 circles in the corners, with the given radius
			translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
				circle(r=radius, $fn=fn);

			translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
				circle(r=radius, $fn=fn);

			translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
				circle(r=radius, $fn=fn);

			translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
				circle(r=radius, $fn=fn);
		}
}

module leg_hole()
{
	translate([0,0,legs_thickness])
	{
		translate([0,legs_width/2,0])
			cube([ wire*1.5,legs_width,legs_thickness*3],center=true);
		cylinder(d=wire*1.5, h=legs_thickness*3, center=true, $fn=fn);
	}
}

module leg()
{
	difference()
	{
		roundedRect( [ legs_width, square_flat_sz * 2, legs_thickness ], legs_width/2 );
		union()
		{
			translate([0,-square_flat_sz,0])
				rotate([0,0,180]) leg_hole();
			translate([0,square_flat_sz,0])
				leg_hole();
		}
	}
}

module vleg()
{
	translate([ 0,-legs_thickness/2,0 ])
	rotate([270,0,0])
		difference()
		{
			roundedRect( [ legs_width, square_flat_sz, legs_thickness ], legs_width/2 );
			translate([0,-square_flat_sz/2,0])
				rotate([0,0,180]) leg_hole();
		}
}
module vlegs()
{
	difference() {
		union() {
			translate([ 0, square_flat_sz/2, 0 ]) vleg();
			translate([ 0, -square_flat_sz/2, 0 ]) vleg();
			translate([ square_flat_sz/2, 0, 0 ]) rotate([0,0,90]) vleg();
			translate([ -square_flat_sz/2, 0, 0 ]) rotate([0,0,90]) vleg();
		}
		translate([0,0,-square_flat_sz/2])
			cube( [square_flat_sz*2,square_flat_sz*2,square_flat_sz], center=true );
	}
}

module leg_support()
{
	sz = square_flat_sz*5/6;
	translate([0,0])
		difference() {
			roundedRect([sz, sz, legs_thickness*2],legs_width/2);
			translate([0,0,-1])
				roundedRect([sz-legs_width*2,sz-legs_width*2,
						legs_thickness*4],legs_width/2);
		}
}

module cable_hole()
{
	cylinder(d=root_cable_diam, h=legs_thickness*5,center=true,$fn=fn);
}

module composite()
{
	difference() {
		union() {
			leg();
			rotate([0,0,90]) leg();
			rotate([0,0,45]) leg_support();
		}
		cable_hole();
	}
	vlegs();
}

composite();

