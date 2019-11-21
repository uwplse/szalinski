/* [Dimensions] */
// Card width
width     = 57;
// Card height
height    = 88;
// Height of the pile of cards
stackheight   = 50;

/* [Advanced] */
// Here you can set the clearance between the rails. 0.1 is recommended for a tight fit on most printers. This only affects the cover so in case you need to adjust the clearance, you only need to reprint the cover.
clearance     = 0.1;

// Shortens the object by 4 millimeters
thin_bottom   = 1; //[0:false, 1:true]

// Helps to grip. Might not look as nice.
hole_on_cover = 1; //[0:false, 1:true]

/* [Hidden] */
$fn           = 36;  // roundness of exported file
cutoutcorners = 6;   // Shape of cutout in front
thickness     = 5;   // This variable affects the thickness of every wall

module box ()
{
	difference()
	{
		if(thin_bottom)
			translate([0, 0, 4]) roundcube([width + (thickness * 2), stackheight + (thickness * 2), height + 1], thickness);
		else
			roundcube([width + (thickness * 2), stackheight + (thickness * 2), height + thickness], thickness);

		// Hollow the inside
		translate([thickness, thickness, thickness]) cube([width, stackheight, height]);

		// Rails
		translate([0, thickness, height]) rail(0);
		translate([width + thickness * 2, thickness, height]) mirror([1, 0, 0]) rail(0);

		// Rear opening
		translate([0, stackheight + thickness, height]) cube([width + (thickness * 2), thickness, thickness]);

		//front cutout
		if(width > 50 && height > 60) translate([(width/2) + thickness, 0, (height / 2) + thickness]) rotate([-90, undef]) cylinder(5, 30, 20, $fn=cutoutcorners);
		echo("rotate undef is fine :)");
	};
};

module cover (clearance)
{
	difference()
	{
		roundcube([width + (thickness * 2), stackheight + (thickness * 2), thickness * 2], thickness);
		cube([width + (thickness * 2), stackheight + thickness, thickness]);
		if(hole_on_cover) translate([(width / 2) + thickness, (stackheight / 2) + thickness, thickness]) cylinder(thickness, 10, 15);
	}
	// Rails
	translate([0, thickness]) rail(clearance);
	translate([width + (thickness * 2), thickness]) mirror([1, 0, 0]) rail(clearance);
};

module roundcube (dimensions=[1,1,1], radius=0)
{
	hull()
	{
		translate([radius, radius]) cylinder(dimensions[2], radius, radius);
		translate([dimensions[0] - radius, radius]) cylinder(dimensions[2], radius, radius);
		translate([radius, dimensions[1] - radius]) cylinder(dimensions[2], radius, radius);
		translate([dimensions[0] - radius, dimensions[1] - radius]) cylinder(dimensions[2], radius, radius);
	}
}

module rail (clearance)
{
	c=((sqrt(2) * thickness) / 3);
	translate([0, clearance]) difference()
	{
		union()
		{
			cube([(thickness / 3) - clearance, stackheight, thickness]);
			translate([(thickness / 3) - clearance, 0]) cube([(thickness / 3), stackheight, thickness/2 - (thickness / 6)]);
			intersection()
			{
				translate([-clearance, 0, thickness/2 - (thickness / 6)]) rotate([-90,-45]) cube([c, c, stackheight]);
				translate([(thickness / 3) - clearance, 0]) cube([(thickness / 3), stackheight, thickness]);
			}
		}
		rotate([45, 0]) cube(sqrt(2) * thickness, center=true);
	}
}

/* Final parts */
box();

if(thin_bottom) translate([0, -thickness, (thickness * 2) + 4]) rotate([180, 0]) cover(0.1);
else translate([0, -thickness, thickness * 2]) rotate([180, 0]) cover(0.1);
