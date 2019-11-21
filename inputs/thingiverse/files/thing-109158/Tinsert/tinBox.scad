//	Thingiverse Customizer Template v1.2 by MakerBlock
//	http://www.thingiverse.com/thing:44090
//	v1.2 now includes the Build Plate library as well

//	Uncomment the library/libraries of your choice to include them
//	include <MCAD/filename.scad>
//	include <pins/pins.scad>
//	include <write/Write.scad>
	include <utils/build_plate.scad>

//CUSTOMIZER VARIABLE



// Length
length = 80;

// Width
width = 30;

// Height
height = 10;

// Thickness
thickness = 1;

// Compartments (x)
x = 5;

// Compartments (y)
y = 4;

// Corner Radius
radius = 3;

// Outside wall?
wall = "yes"; // [yes,no]

// End tab?
vertical = "no"; // [yes,no]

// Tab Width
vWidth = 40;

// Tab Height
vHeight = 20;

// Handle?
handle = "no"; // [yes, no]

// Handle Width
hWidth = 5;

// Handle Thickness
hThickness = 1;

// Handle Height
hHeight = 5;


//	This section is creates the build plates for scale
//	for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//	when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//	when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

//CUSTOMIZER VARIABLES END

xSpace = ((width - (x * thickness)) / x)+thickness;
ySpace = ((length - (y * thickness)) / y)+thickness;



/* NOTES:

*/

union()
{
	
	/* limit tab */
	if (vertical == "yes")
	{
		translate([0, (-1 * (vWidth - width))/2,0]) cube(size = [thickness, vWidth, vHeight]);
	}
	
	/* create handle tab */
	if ((handle == "yes") && (wall == "yes"))
	{
		translate([length, (width / 2) - (hThickness / 2), (height/2) - (hHeight / 2)]) cube(size = [hWidth, hThickness, hHeight]);
	}
	
	if (radius == 0)
	{
		difference() {
			cube(size = [length,width,height]);
			
			if (wall =="yes")
			{
				translate([thickness,thickness,thickness]) cube(size = [length - (2 * thickness), width - (2 * thickness), height]);
			}
			else
			{
				translate([ -thickness, -thickness,thickness]) cube(size = [length + (2 * thickness), width + (2 * thickness), height]);
			}
		}
	}
	else
	{
		difference() {
			union(){
				translate([0,radius,0]) cube(size = [length,width - (2 * radius),height]);
				translate([radius,0,0]) cube(size = [length - (2 * radius), width,height]);
	
			/* if end is not increased then create end cylinders */
				if (vertical != "yes")
				{
					translate([radius, radius, 0]) cylinder(r = radius, h = height);
					translate([radius, width-radius, 0]) cylinder(r = radius, h = height);
				}
				translate([length - radius, radius, 0]) cylinder(r = radius, h = height);
				translate([length - radius, width - radius, 0]) cylinder(r = radius, h = height);
		} /* end of union function */
				
		/* two rectangular prisms (forming a cross), to be deleted*/
			translate([thickness,radius,thickness]) cube(size = [length - (2 * thickness),width - (2 * radius),height]);
			translate([radius,thickness,thickness]) cube(size = [length - (2 * radius), width - (2 * thickness),height]);
		/* cylinders to be deleted */
			translate([radius, radius, thickness]) cylinder(r = radius - thickness, h = height);
			translate([length - radius, radius, thickness]) cylinder(r = radius - thickness, h = height);
			translate([radius, width-radius, thickness]) cylinder(r = radius - thickness, h = height);
			translate([length - radius, width - radius, thickness]) cylinder(r = radius - thickness, h = height);
	
			if (wall == "no")
			{
				translate([ -thickness, -thickness,thickness]) cube(size = [length + (2 * thickness), width + (2 * thickness), height]);
			}
	
		}
			
		/* adjust for end tab */
			if (vertical == "yes")
			{
				difference() {
					cube(size = [radius,width,thickness]);
		
					translate([0, thickness, thickness]) cube(size = [radius + thickness, width - (2 * thickness), thickness]);
				}
			}
	}
	
	for (i = [1 : (x - 1)  ])
	{
		if((i * xSpace > radius) && ((width - (i *xSpace)) > radius))
		{
			translate([0, (i * xSpace)  , 0]) cube(size = [length, thickness, height]);
		}
	}
	
	for (i = [1 : (y - 1)  ])
	{
		if((i * ySpace > radius) && ((length - (i *ySpace)) > radius))
		{
			translate([(i * ySpace), 0  , 0]) cube(size = [thickness, width, height]);
		}
	}
	
} /* /union */

















